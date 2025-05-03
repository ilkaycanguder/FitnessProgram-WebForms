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
                ViewState["ProgramToDelete"] = programId;
            }
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            if (ViewState["ProgramToDelete"] != null)
            {
                int programId = Convert.ToInt32(ViewState["ProgramToDelete"]);
                DeleteProgram(programId);
                LoadPrograms(ddlFilterMuscleGroup.SelectedValue, ddlSortByDate.SelectedValue);
                LoadStatistics();
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
            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                string query = @"SELECT MuscleGroup, WorkoutName, DateCreated 
                               FROM Programs 
                               WHERE UserId = @UserId 
                               AND (@MuscleGroup = '' OR MuscleGroup = @MuscleGroup)
                               ORDER BY DateCreated " + (ddlSortByDate.SelectedValue == "DESC" ? "DESC" : "ASC");

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@MuscleGroup", ddlFilterMuscleGroup.SelectedValue);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=Programlarim.csv");
                Response.Charset = "UTF-8";
                Response.ContentType = "text/csv";
                Response.ContentEncoding = Encoding.UTF8;

                using (var sw = new StreamWriter(Response.OutputStream, new UTF8Encoding(true)))
                {
                    sw.WriteLine("Kas Grubu,Egzersiz,Tarih");
                    while (reader.Read())
                    {
                        sw.WriteLine($"{reader["MuscleGroup"]},{reader["WorkoutName"]},{Convert.ToDateTime(reader["DateCreated"]):dd.MM.yyyy HH:mm}");
                    }
                    sw.Flush();
                }
                Response.End();
            }
        }

        protected void btnExportPDF_Click(object sender, EventArgs e)
        {
            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                string query = @"SELECT MuscleGroup, WorkoutName, DateCreated 
                               FROM Programs 
                               WHERE UserId = @UserId 
                               AND (@MuscleGroup = '' OR MuscleGroup = @MuscleGroup)
                               ORDER BY DateCreated " + (ddlSortByDate.SelectedValue == "DESC" ? "DESC" : "ASC");

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@MuscleGroup", ddlFilterMuscleGroup.SelectedValue);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                using (MemoryStream ms = new MemoryStream())
                {
                    string fontPath = Server.MapPath("~/Fonts/arial.ttf");
                    BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
                    Font titleFont = new Font(baseFont, 16, Font.BOLD);
                    Font headerFont = new Font(baseFont, 12, Font.BOLD);
                    Font contentFont = new Font(baseFont, 10);

                    Document document = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
                    PdfWriter writer = PdfWriter.GetInstance(document, ms);

                    document.Open();

                    Paragraph title = new Paragraph("Antrenman Programlarım", titleFont);
                    title.Alignment = Element.ALIGN_CENTER;
                    title.SpacingAfter = 20f;
                    document.Add(title);

                    PdfPTable table = new PdfPTable(3);
                    table.WidthPercentage = 100;

                    table.AddCell(new PdfPCell(new Phrase("Kas Grubu", headerFont)));
                    table.AddCell(new PdfPCell(new Phrase("Egzersiz", headerFont)));
                    table.AddCell(new PdfPCell(new Phrase("Tarih", headerFont)));

                    while (reader.Read())
                    {
                        table.AddCell(new PdfPCell(new Phrase(reader["MuscleGroup"].ToString(), contentFont)));
                        table.AddCell(new PdfPCell(new Phrase(reader["WorkoutName"].ToString(), contentFont)));
                        table.AddCell(new PdfPCell(new Phrase(Convert.ToDateTime(reader["DateCreated"]).ToString("dd.MM.yyyy HH:mm"), contentFont)));
                    }

                    document.Add(table);
                    document.Close();

                    Response.Clear();
                    Response.Buffer = true;
                    Response.AddHeader("content-disposition", "attachment;filename=Programlarim.pdf");
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(ms.ToArray());
                    Response.End();
                }
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