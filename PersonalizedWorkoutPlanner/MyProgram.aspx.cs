using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Web.UI.HtmlControls;
using System.Threading;

namespace PersonalizedWorkoutPlanner
{
    public partial class MyProgram : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadPrograms();
                LoadStatistics();
            }
        }

        private void LoadStatistics()
        {
            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                conn.Open();

                string totalWorkoutsQuery = "SELECT COUNT(*) FROM Programs WHERE UserId = @UserId";
                SqlCommand totalWorkoutsCmd = new SqlCommand(totalWorkoutsQuery, conn);
                totalWorkoutsCmd.Parameters.AddWithValue("@UserId", userId);
                int totalWorkouts = (int)totalWorkoutsCmd.ExecuteScalar();
                litTotalWorkouts.Text = totalWorkouts.ToString();

                string muscleGroupsQuery = "SELECT COUNT(DISTINCT MuscleGroup) FROM Programs WHERE UserId = @UserId";
                SqlCommand muscleGroupsCmd = new SqlCommand(muscleGroupsQuery, conn);
                muscleGroupsCmd.Parameters.AddWithValue("@UserId", userId);
                int muscleGroups = (int)muscleGroupsCmd.ExecuteScalar();
                litMuscleGroups.Text = muscleGroups.ToString();
            }
        }

        private void LoadPrograms(string muscleGroup = "", string sortOrder = "DESC")
        {
            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                string query = @"SELECT Id, MuscleGroup, WorkoutName, DateCreated 
                               FROM Programs 
                               WHERE UserId = @UserId 
                               AND (@MuscleGroup = '' OR MuscleGroup = @MuscleGroup)
                               AND WorkoutName IS NOT NULL
                               ORDER BY DateCreated " + (sortOrder == "DESC" ? "DESC" : "ASC");

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@MuscleGroup", muscleGroup);

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    gvPrograms.DataSource = dt;
                    gvPrograms.DataBind();
                    lblEmpty.Visible = false;
                }
                else
                {
                    lblEmpty.Text = "Henüz kaydedilmiş program bulunmamaktadır.";
                    lblEmpty.Visible = true;
                }
            }
        }

        protected void ddlFilterMuscleGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadPrograms(ddlFilterMuscleGroup.SelectedValue, ddlSortByDate.SelectedValue);
        }

        protected void ddlSortByDate_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadPrograms(ddlFilterMuscleGroup.SelectedValue, ddlSortByDate.SelectedValue);
        }

        protected void gvPrograms_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteProgram")
            {
                int programId = Convert.ToInt32(e.CommandArgument);
                hdnProgramIdToDelete.Value = programId.ToString();
                
                // Show confirmation dialog using JavaScript
                ClientScript.RegisterStartupScript(this.GetType(), "ShowDeleteDialog", 
                    "document.getElementById('deleteConfirmationDialog').style.display = 'block'; document.getElementById('dialogOverlay').style.display = 'block';", true);
            }
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(hdnProgramIdToDelete.Value))
            {
                int programId = Convert.ToInt32(hdnProgramIdToDelete.Value);
                DeleteProgram(programId);
                LoadPrograms(ddlFilterMuscleGroup.SelectedValue, ddlSortByDate.SelectedValue);
                LoadStatistics();
                
                // Clear the hidden field
                hdnProgramIdToDelete.Value = string.Empty;
            }
        }

        private void DeleteProgram(int programId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                string query = "DELETE FROM Programs WHERE Id = @ProgramId AND UserId = @UserId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProgramId", programId);
                cmd.Parameters.AddWithValue("@UserId", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            try
            {
                string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
                int userId = Convert.ToInt32(Session["UserId"]);
                
                // Verileri al
                List<ProgramData> programList = new List<ProgramData>();
                
                using (SqlConnection conn = new SqlConnection(conStr))
                {
                    string query = @"SELECT Id, MuscleGroup, WorkoutName, DateCreated 
                                   FROM Programs 
                                   WHERE UserId = @UserId 
                                   AND (@MuscleGroup = '' OR MuscleGroup = @MuscleGroup)
                                   AND WorkoutName IS NOT NULL
                                   ORDER BY DateCreated " + (ddlSortByDate.SelectedValue == "DESC" ? "DESC" : "ASC");

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@MuscleGroup", ddlFilterMuscleGroup.SelectedValue);

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            programList.Add(new ProgramData
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                MuscleGroup = reader["MuscleGroup"].ToString(),
                                WorkoutName = reader["WorkoutName"].ToString(),
                                DateCreated = Convert.ToDateTime(reader["DateCreated"])
                            });
                        }
                    }
                }
                
                // CSV dosyasını MemoryStream'e yaz
                byte[] csvBytes;
                using (MemoryStream ms = new MemoryStream())
                {
                    using (var sw = new StreamWriter(ms, new UTF8Encoding(true)))
                    {
                        // CSV Header
                        sw.WriteLine("Kas Grubu,Egzersiz,Tarih");
                        
                        // CSV Content
                        foreach (var program in programList)
                        {
                            sw.WriteLine($"{program.MuscleGroup},{program.WorkoutName},{program.DateCreated:dd.MM.yyyy HH:mm}");
                        }
                        
                        sw.Flush();
                        ms.Position = 0;
                        csvBytes = ms.ToArray();
                    }
                }
                
                // Response'u temizle ve gerekli headerleri ayarla
                Response.Clear();
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "text/csv";
                Response.AddHeader("Content-Disposition", "attachment; filename=Programlarim.csv");
                Response.AddHeader("Content-Length", csvBytes.Length.ToString());
                Response.ContentEncoding = Encoding.UTF8;
                Response.Buffer = true;
                
                // CSV verilerini response stream'e yaz
                Response.OutputStream.Write(csvBytes, 0, csvBytes.Length);
                Response.End();
            }
            catch (ThreadAbortException)
            {
                // Response.End() normal olarak ThreadAbortException fırlatır, bu yüzden bunu görmezden geliyoruz
            }
            catch (Exception ex)
            {
                // Hata durumunda kullanıcıya bildirme
                string errorScript = $"alert('CSV oluşturulurken bir hata oluştu: {ex.Message.Replace("'", "\\'")}');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "CsvError", errorScript, true);
            }
        }

        protected void btnExportPDF_Click(object sender, EventArgs e)
        {
            try
            {
                string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
                int userId = Convert.ToInt32(Session["UserId"]);
                
                // PDF'i oluşturmak için veritabanı sorgusunu yap
                List<ProgramData> programList = new List<ProgramData>();
                
                using (SqlConnection conn = new SqlConnection(conStr))
                {
                    string query = @"SELECT Id, MuscleGroup, WorkoutName, DateCreated 
                                   FROM Programs 
                                   WHERE UserId = @UserId 
                                   AND (@MuscleGroup = '' OR MuscleGroup = @MuscleGroup)
                                   AND WorkoutName IS NOT NULL
                                   ORDER BY DateCreated " + (ddlSortByDate.SelectedValue == "DESC" ? "DESC" : "ASC");

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@MuscleGroup", ddlFilterMuscleGroup.SelectedValue);

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            programList.Add(new ProgramData
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                MuscleGroup = reader["MuscleGroup"].ToString(),
                                WorkoutName = reader["WorkoutName"].ToString(),
                                DateCreated = Convert.ToDateTime(reader["DateCreated"])
                            });
                        }
                    }
                }
                
                // Memory stream'e PDF oluştur
                byte[] pdfBytes;
                using (MemoryStream ms = new MemoryStream())
                {
                    Document document = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
                    PdfWriter writer = PdfWriter.GetInstance(document, ms);
                    
                    document.Open();
                    
                    // Basit font kullanımı
                    Font titleFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
                    Font headerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
                    Font contentFont = new Font(Font.FontFamily.HELVETICA, 10);
                    
                    // Başlık ekle
                    Paragraph title = new Paragraph("Antrenman Programlarım", titleFont);
                    title.Alignment = Element.ALIGN_CENTER;
                    title.SpacingAfter = 20f;
                    document.Add(title);
                    
                    // Alt başlık olarak tarih ve filtre bilgisi ekle
                    Paragraph subtitle = new Paragraph($"Oluşturulma Tarihi: {DateTime.Now:dd.MM.yyyy HH:mm}", contentFont);
                    subtitle.Alignment = Element.ALIGN_RIGHT;
                    subtitle.SpacingAfter = 20f;
                    document.Add(subtitle);
                    
                    if (!string.IsNullOrEmpty(ddlFilterMuscleGroup.SelectedValue))
                    {
                        Paragraph filterInfo = new Paragraph($"Filtre: {ddlFilterMuscleGroup.SelectedItem.Text}", contentFont);
                        filterInfo.Alignment = Element.ALIGN_RIGHT;
                        filterInfo.SpacingAfter = 20f;
                        document.Add(filterInfo);
                    }
                    
                    // Tablo oluştur
                    PdfPTable table = new PdfPTable(3);
                    table.WidthPercentage = 100;
                    table.SetWidths(new float[] { 2f, 4f, 2f });
                    
                    // Tablo başlıkları
                    PdfPCell headerCell1 = new PdfPCell(new Phrase("Kas Grubu", headerFont));
                    headerCell1.BackgroundColor = new BaseColor(240, 244, 248);
                    headerCell1.HorizontalAlignment = Element.ALIGN_CENTER;
                    headerCell1.VerticalAlignment = Element.ALIGN_MIDDLE;
                    headerCell1.Padding = 8;
                    
                    PdfPCell headerCell2 = new PdfPCell(new Phrase("Egzersiz", headerFont));
                    headerCell2.BackgroundColor = new BaseColor(240, 244, 248);
                    headerCell2.HorizontalAlignment = Element.ALIGN_CENTER;
                    headerCell2.VerticalAlignment = Element.ALIGN_MIDDLE;
                    headerCell2.Padding = 8;
                    
                    PdfPCell headerCell3 = new PdfPCell(new Phrase("Tarih", headerFont));
                    headerCell3.BackgroundColor = new BaseColor(240, 244, 248);
                    headerCell3.HorizontalAlignment = Element.ALIGN_CENTER;
                    headerCell3.VerticalAlignment = Element.ALIGN_MIDDLE;
                    headerCell3.Padding = 8;
                    
                    table.AddCell(headerCell1);
                    table.AddCell(headerCell2);
                    table.AddCell(headerCell3);
                    
                    // Tablo içeriği
                    bool alternate = false;
                    foreach (var program in programList)
                    {
                        PdfPCell cell1 = new PdfPCell(new Phrase(program.MuscleGroup, contentFont));
                        PdfPCell cell2 = new PdfPCell(new Phrase(program.WorkoutName, contentFont));
                        PdfPCell cell3 = new PdfPCell(new Phrase(program.DateCreated.ToString("dd.MM.yyyy HH:mm"), contentFont));
                        
                        if (alternate)
                        {
                            cell1.BackgroundColor = new BaseColor(248, 250, 253);
                            cell2.BackgroundColor = new BaseColor(248, 250, 253);
                            cell3.BackgroundColor = new BaseColor(248, 250, 253);
                        }
                        
                        cell1.Padding = 8;
                        cell2.Padding = 8;
                        cell3.Padding = 8;
                        
                        table.AddCell(cell1);
                        table.AddCell(cell2);
                        table.AddCell(cell3);
                        
                        alternate = !alternate;
                    }
                    
                    document.Add(table);
                    
                    // Eğer liste boş ise bilgi mesajı ekle
                    if (programList.Count == 0)
                    {
                        Paragraph emptyInfo = new Paragraph("Seçilen kriterlere uygun kayıt bulunamadı.", contentFont);
                        emptyInfo.Alignment = Element.ALIGN_CENTER;
                        emptyInfo.SpacingBefore = 20f;
                        document.Add(emptyInfo);
                    }
                    
                    document.Close();
                    writer.Close();
                    
                    // PDF verilerini byte array olarak al
                    pdfBytes = ms.ToArray();
                }
                
                // Response'u temizle ve gerekli headerleri ayarla
                Response.Clear();
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment; filename=Programlarim.pdf");
                Response.AddHeader("Content-Length", pdfBytes.Length.ToString());
                Response.Buffer = true;
                
                // PDF verilerini response stream'e yaz
                Response.OutputStream.Write(pdfBytes, 0, pdfBytes.Length);
                Response.End();
            }
            catch (ThreadAbortException)
            {
                // Response.End() normal olarak ThreadAbortException fırlatır, bu yüzden bunu görmezden geliyoruz
            }
            catch (Exception ex)
            {
                // Hata durumunda kullanıcıya bildirme
                string errorScript = $"alert('PDF oluşturulurken bir hata oluştu: {ex.Message.Replace("'", "\\'")}');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "PdfError", errorScript, true);
            }
        }
    }

    public class ProgramData
    {
        public int Id { get; set; }
        public string MuscleGroup { get; set; }
        public string WorkoutName { get; set; }
        public DateTime DateCreated { get; set; }
    }
}