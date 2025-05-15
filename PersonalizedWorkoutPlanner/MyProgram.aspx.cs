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
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Web.Security;

namespace PersonalizedWorkoutPlanner
{
    public partial class MyProgram : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                LoadPrograms();

                // IsPostBack false ise, yani sayfa ilk defa yükleniyorsa
                // Alert mesajlarının tekrarlamasını engellemek için bir script ekle
                string script = @"
                // Önceki mesajlar varsa temizle
                if (window.__deleteMessageShown) {
                    delete window.__deleteMessageShown;
                }";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ClearAlerts", script, true);
            }
        }

        private void LoadPrograms()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string connectionString = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql = @"
                    SELECT Id, MuscleGroup, WorkoutName, Days, DateCreated as CreatedDate
                    FROM Programs
                    WHERE UserId = @UserId
                    ORDER BY DateCreated DESC";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    conn.Open();

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        if (dt.Rows.Count == 0)
                        {
                            pnlNoProgram.Visible = true;
                            pnlPrograms.Visible = false;
                            btnDeleteAllPrograms.Visible = false;
                            btnExportWorkoutPDF.Visible = false;
                            return;
                        }

                        pnlNoProgram.Visible = false;
                        pnlPrograms.Visible = true;
                        btnDeleteAllPrograms.Visible = true;
                        btnExportWorkoutPDF.Visible = true;

                        // Her gün için programları filtreleme işlemi - kelime sınırlarını dikkate alan daha kesin filtreleme
                        // Her gün için ayrı bir yardımcı metot kullanarak filtreleme yapalım
                        rptPazartesi.DataSource = FilterProgramsByExactDay(dt, "Pazartesi");
                        rptPazartesi.DataBind();

                        rptSali.DataSource = FilterProgramsByExactDay(dt, "Salı");
                        rptSali.DataBind();

                        rptCarsamba.DataSource = FilterProgramsByExactDay(dt, "Çarşamba");
                        rptCarsamba.DataBind();

                        rptPersembe.DataSource = FilterProgramsByExactDay(dt, "Perşembe");
                        rptPersembe.DataBind();

                        rptCuma.DataSource = FilterProgramsByExactDay(dt, "Cuma");
                        rptCuma.DataBind();

                        rptCumartesi.DataSource = FilterProgramsByExactDay(dt, "Cumartesi");
                        rptCumartesi.DataBind();

                        rptPazar.DataSource = FilterProgramsByExactDay(dt, "Pazar");
                        rptPazar.DataBind();
                    }
                }
            }
        }

        // Günlere göre tam eşleme yapan filtreleme metodu
        private List<DataRow> FilterProgramsByExactDay(DataTable dt, string day)
        {
            return dt.AsEnumerable()
                .Where(row =>
                {
                    string days = row.Field<string>("Days");
                    if (string.IsNullOrEmpty(days)) return false;

                    // Tam gün adı eşleşmesi için kontrol
                    // Not: Cumartesi ile Cuma çakışmaması için kelime sınırlarını kontrol et
                    return days.Equals(day, StringComparison.OrdinalIgnoreCase) ||
                           days.StartsWith(day + ",", StringComparison.OrdinalIgnoreCase) ||
                           days.EndsWith(", " + day, StringComparison.OrdinalIgnoreCase) ||
                           days.IndexOf(", " + day + ",", StringComparison.OrdinalIgnoreCase) >= 0;
                })
                .ToList();
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

        protected void ddlFilterMuscleGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadPrograms();
        }

        protected void ddlSortByDate_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadPrograms();
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
                LoadPrograms();
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

        protected void btnExportWorkoutPDF_Click(object sender, EventArgs e)
        {
            try
            {
                string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
                int userId = Convert.ToInt32(Session["UserId"]);

                // Veritabanından tüm programları al
                Dictionary<string, List<ProgramData>> programsByDay = new Dictionary<string, List<ProgramData>>();
                string[] weekDays = { "Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar" };

                // Her gün için boş bir liste oluştur
                foreach (string day in weekDays)
                {
                    programsByDay[day] = new List<ProgramData>();
                }

                // Veritabanından günlere göre programları sorgula
                using (SqlConnection conn = new SqlConnection(conStr))
                {
                    string query = @"
                        SELECT Id, MuscleGroup, WorkoutName, Days, DateCreated 
                                   FROM Programs 
                                   WHERE UserId = @UserId 
                        ORDER BY DateCreated DESC";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string days = reader["Days"].ToString();
                            string muscleGroup = reader["MuscleGroup"].ToString();
                            string workoutName = reader["WorkoutName"].ToString();

                            // Koşu Bandı yazım hatasını düzelt
                            if (workoutName.Equals("Koşu Bandı", StringComparison.OrdinalIgnoreCase) ||
                                workoutName.Equals("Kou Band", StringComparison.OrdinalIgnoreCase) ||
                                workoutName.Contains("Kosu Band"))
                            {
                                workoutName = "Kosu Bandi";
                            }

                            // İp atlama yazım düzeltmesi
                            if (workoutName.Contains("p Atlama"))
                            {
                                workoutName = "Ip Atlama";
                            }

                            // Diğer Türkçe karakter düzeltmeleri
                            workoutName = workoutName.Replace("ğ", "g")
                                                    .Replace("ü", "u")
                                                    .Replace("ş", "s")
                                                    .Replace("ı", "i")
                                                    .Replace("ö", "o")
                                                    .Replace("ç", "c")
                                                    .Replace("Ğ", "G")
                                                    .Replace("Ü", "U")
                                                    .Replace("Ş", "S")
                                                    .Replace("İ", "I")
                                                    .Replace("Ö", "O")
                                                    .Replace("Ç", "C");

                            if (muscleGroup.Contains("ğ") || muscleGroup.Contains("ö") || muscleGroup.Contains("ü") ||
                                muscleGroup.Contains("ç") || muscleGroup.Contains("ş") || muscleGroup.Contains("ı"))
                            {
                                muscleGroup = muscleGroup.Replace("ğ", "g")
                                                        .Replace("ü", "u")
                                                        .Replace("ş", "s")
                                                        .Replace("ı", "i")
                                                        .Replace("ö", "o")
                                                        .Replace("ç", "c")
                                                        .Replace("Ğ", "G")
                                                        .Replace("Ü", "U")
                                                        .Replace("Ş", "S")
                                                        .Replace("İ", "I")
                                                        .Replace("Ö", "O")
                                                        .Replace("Ç", "C");
                            }

                            int id = Convert.ToInt32(reader["Id"]);
                            DateTime dateCreated = Convert.ToDateTime(reader["DateCreated"]);

                            // Her bir program için, o günle eşleşiyorsa listeye ekle
                            foreach (string day in weekDays)
                            {
                                if (days == day || days.StartsWith(day + ",") || days.EndsWith(", " + day) || days.Contains(", " + day + ","))
                                {
                                    programsByDay[day].Add(new ProgramData
                                    {
                                        Id = id,
                                        MuscleGroup = muscleGroup,
                                        WorkoutName = workoutName,
                                        DateCreated = dateCreated,
                                        Days = days
                                    });
                                }
                            }
                        }
                    }
                }

                // Memory stream'e PDF oluştur
                byte[] pdfBytes;
                using (MemoryStream ms = new MemoryStream())
                {
                    // Yatay (Landscape) format kullanımı
                    Document document = new Document(PageSize.A4.Rotate(), 20f, 20f, 30f, 20f);
                    PdfWriter writer = PdfWriter.GetInstance(document, ms);

                    document.Open();

                    // Font tanımları - standart encoding ile
                    Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
                    Font headerFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
                    Font subHeaderFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
                    Font contentFont = new Font(Font.FontFamily.HELVETICA, 10);
                    Font boldContentFont = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD);

                    // Başlık ekle
                    Paragraph title = new Paragraph("ANTRENMAN PROGRAMIM", titleFont);
                    title.Alignment = Element.ALIGN_CENTER;
                    title.SpacingAfter = 15f;
                    document.Add(title);

                    // Kullanıcı bilgilerini ve tarihi ekle
                    Paragraph dateInfo = new Paragraph($"Tarih: {DateTime.Now:dd.MM.yyyy}", contentFont);
                    dateInfo.Alignment = Element.ALIGN_RIGHT;
                    dateInfo.SpacingAfter = 20f;
                    document.Add(dateInfo);

                    // Ana tablo oluştur (tüm içeriği kapsayan)
                    PdfPTable mainTable = new PdfPTable(7); // 7 gün için
                    mainTable.WidthPercentage = 100;
                    mainTable.SetWidths(new float[] { 1f, 1f, 1f, 1f, 1f, 1f, 1f }); // Eşit genişlikler
                    mainTable.HeaderRows = 1;

                    // Gün başlıklarını ekle
                    BaseColor headerBgColor = new BaseColor(30, 60, 114); // Koyu mavi
                    BaseColor headerTextColor = BaseColor.WHITE;

                    foreach (string day in weekDays)
                    {
                        PdfPCell headerCell = new PdfPCell(new Phrase(day, headerFont));
                        headerCell.BackgroundColor = headerBgColor;
                        headerCell.HorizontalAlignment = Element.ALIGN_CENTER;
                        headerCell.VerticalAlignment = Element.ALIGN_MIDDLE;
                        headerCell.Padding = 10f;
                        headerCell.BorderWidth = 1f;
                        headerCell.BorderColor = BaseColor.WHITE;
                        headerCell.PaddingBottom = 10f;
                        headerCell.PaddingTop = 10f;
                        headerCell.MinimumHeight = 40f;
                        headerFont.Color = headerTextColor;
                        mainTable.AddCell(headerCell);
                    }

                    // Her gün için maksimum program sayısını bul
                    int maxProgramCount = 0;
                    foreach (string day in weekDays)
                    {
                        maxProgramCount = Math.Max(maxProgramCount, programsByDay[day].Count);
                    }

                    // Gün içeriğini ekle (her günün programları)
                    for (int i = 0; i < maxProgramCount; i++)
                    {
                        foreach (string day in weekDays)
                        {
                            PdfPCell dayCell;

                            if (i < programsByDay[day].Count)
                            {
                                var program = programsByDay[day][i];

                                // İç içe bir tablo oluştur (her program için)
                                PdfPTable programTable = new PdfPTable(1);
                                programTable.WidthPercentage = 100;

                                // Egzersiz adı
                                PdfPCell nameCell = new PdfPCell(new Phrase(program.WorkoutName, boldContentFont));
                                nameCell.BorderWidth = 0;
                                nameCell.HorizontalAlignment = Element.ALIGN_CENTER;
                                nameCell.BackgroundColor = new BaseColor(240, 244, 248);
                                nameCell.Padding = 5f;
                                programTable.AddCell(nameCell);

                                // Kas grubu
                                PdfPCell muscleGroupCell = new PdfPCell(new Phrase("Kas Grubu: " + program.MuscleGroup, contentFont));
                                muscleGroupCell.BorderWidth = 0;
                                muscleGroupCell.PaddingLeft = 5f;
                                muscleGroupCell.PaddingRight = 5f;
                                programTable.AddCell(muscleGroupCell);

                                // Ana hücre içine tablo yerleştir
                                dayCell = new PdfPCell(programTable);
                                dayCell.Padding = 5f;
                            }
                            else
                            {
                                // Boş hücre
                                dayCell = new PdfPCell(new Phrase("", contentFont));
                            }

                            dayCell.BorderWidth = 0.5f;
                            dayCell.BorderColor = BaseColor.LIGHT_GRAY;
                            mainTable.AddCell(dayCell);
                        }
                    }

                    document.Add(mainTable);

                    // Alt bilgi notu
                    Paragraph footer = new Paragraph("Bu program Kisisellestirilmis Egzersiz Programi uygulamasi tarafindan olusturulmustur.", contentFont);
                    footer.Alignment = Element.ALIGN_CENTER;
                    footer.SpacingBefore = 20f;
                    document.Add(footer);

                    document.Close();
                    writer.Close();

                    // PDF verilerini byte array olarak al
                    pdfBytes = ms.ToArray();
                }

                // PDF'i indirme işlemi
                Response.Clear();
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment; filename=AntrenmanProgramim.pdf");
                Response.AddHeader("Content-Length", pdfBytes.Length.ToString());
                Response.Buffer = true;
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
                string errorScript = $"alert('Antrenman programı PDF'i oluşturulurken bir hata oluştu: {ex.Message.Replace("'", "\\'")}');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "WorkoutPdfError", errorScript, true);
            }
        }

        protected void ProgramSil_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Sil")
            {
                int programId = Convert.ToInt32(e.CommandArgument);
                DeleteProgram(programId);
                LoadPrograms();
            }
        }

        protected void btnDeleteAllPrograms_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Log user and action
                int userId = Convert.ToInt32(Session["UserId"]);
                System.Diagnostics.Debug.WriteLine($"Attempting to delete all programs for user {userId}");

                // Tüm programları sil
                DeleteAllPrograms();

                // Programları yeniden yükle (boş olacak)
                LoadPrograms();

                // Başarılı mesajı göster - sayfayı yeniden yükleme kodunu kaldırdık
                string script = @"
                    window.__deleteMessageShown = true;
                    alert('Tüm programlarınız başarıyla silindi!');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "DeleteAllSuccess", script, true);
            }
            catch (SqlException sqlEx)
            {
                // SQL özel hata mesajı göster
                string errorScript = $"alert('Veritabanı işlemi sırasında bir hata oluştu: {sqlEx.Message.Replace("'", "\\'")}\\nHata kodu: {sqlEx.Number}')";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "DeleteAllSqlError", errorScript, true);

                // Hata ayrıntılarını logla
                System.Diagnostics.Debug.WriteLine($"SQL Exception in DeleteAllPrograms_Click: {sqlEx.Message}, Number: {sqlEx.Number}");
            }
            catch (Exception ex)
            {
                // Genel hata mesajı göster
                string errorScript = $"alert('Programlar silinirken bir hata oluştu: {ex.Message.Replace("'", "\\'")}');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "DeleteAllError", errorScript, true);

                // Hata ayrıntılarını logla
                System.Diagnostics.Debug.WriteLine($"Exception in DeleteAllPrograms_Click: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
            }
        }

        private void DeleteAllPrograms()
        {
            if (Session["UserId"] == null)
                return;

            int userId = Convert.ToInt32(Session["UserId"]);
            string connectionString = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Use a transaction to ensure all deletions succeed or fail together
                    using (SqlTransaction transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            // First delete command
                            string query = "DELETE FROM Programs WHERE UserId = @UserId";
                            SqlCommand cmd = new SqlCommand(query, conn, transaction);
                            cmd.Parameters.AddWithValue("@UserId", userId);
                            cmd.CommandTimeout = 120; // Increase timeout to 2 minutes

                            int rowsAffected = cmd.ExecuteNonQuery();

                            // Commit the transaction
                            transaction.Commit();

                            System.Diagnostics.Debug.WriteLine($"Kullanıcı (ID: {userId}) için {rowsAffected} program silindi.");
                        }
                        catch (Exception ex)
                        {
                            // Rollback in case of error
                            transaction.Rollback();
                            System.Diagnostics.Debug.WriteLine($"DeleteAllPrograms transaction error: {ex.Message}");
                            throw;
                        }
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"DeleteAllPrograms connection error: {ex.Message}");
                    throw;
                }
            }
        }

        protected void btnUpdateDay_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Hidden field değerlerini al
                int workoutId;
                if (!int.TryParse(hdnWorkoutId.Value, out workoutId))
                {
                    // Hata oluştuğunda programa dön
                    LoadPrograms();
                    return;
                }

                string newDay = hdnNewDay.Value;
                if (string.IsNullOrEmpty(newDay))
                {
                    // Hata oluştuğunda programa dön
                    LoadPrograms();
                    return;
                }

                int userId = Convert.ToInt32(Session["UserId"]);
                System.Diagnostics.Debug.WriteLine($"Normal post ile güncelleme: userId={userId}, workoutId={workoutId}, newDay={newDay}");

                // Güncelleme işlemi
                UpdateWorkoutDay(userId, workoutId, newDay);

                // Programları yeniden yükle
                LoadPrograms();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"btnUpdateDay_Click hatası: {ex.Message}");
                // Hataya rağmen programları yükle
                LoadPrograms();
            }
        }

        private void UpdateWorkoutDay(int userId, int workoutId, string newDay)
        {
            try
            {
                string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(conStr))
                {
                    conn.Open();

                    // Önce mevcut günleri alın
                    string getOldDayQuery = "SELECT Days FROM Programs WHERE Id = @Id AND UserId = @UserId";
                    SqlCommand getOldDayCmd = new SqlCommand(getOldDayQuery, conn);
                    getOldDayCmd.Parameters.AddWithValue("@Id", workoutId);
                    getOldDayCmd.Parameters.AddWithValue("@UserId", userId);

                    string oldDaysStr = getOldDayCmd.ExecuteScalar()?.ToString();

                    // Eğer yeni gün, günlerden biri ise işlem yapmaya gerek yok
                    if (oldDaysStr == newDay)
                    {
                        System.Diagnostics.Debug.WriteLine("Gün zaten aynı, değişiklik yapılmadı");
                        return;
                    }

                    // Yeni günü ayarla - sürükleme işlemi çoklu günleri desteklemeli
                    // Mevcut programda birden fazla gün olabilir, o yüzden sadece günü değiştiriyoruz
                    string updatedDay = newDay;

                    System.Diagnostics.Debug.WriteLine($"Eski günler: '{oldDaysStr}', Yeni gün: '{updatedDay}'");

                    // Günü değiştir
                    string query = "UPDATE Programs SET Days = @Days WHERE Id = @Id AND UserId = @UserId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Days", updatedDay);
                    cmd.Parameters.AddWithValue("@Id", workoutId);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    int result = cmd.ExecuteNonQuery();
                    System.Diagnostics.Debug.WriteLine($"UpdateWorkoutDay sonucu: {result} satır etkilendi");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"UpdateWorkoutDay hatası: {ex.Message}");
                throw;
            }
        }
    }

    public class ProgramData
    {
        public int Id { get; set; }
        public string MuscleGroup { get; set; }
        public string WorkoutName { get; set; }
        public DateTime DateCreated { get; set; }
        public string Days { get; set; }
    }
}