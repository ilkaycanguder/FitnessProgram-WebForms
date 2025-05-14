using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Linq;
using System.Text.Json;
using System.IO;
using System.Web.Script.Serialization;
using System.Web;

namespace PersonalizedWorkoutPlanner
{
    public partial class Program : System.Web.UI.Page
    {
        // CheckBox kontrolleri
        protected System.Web.UI.WebControls.CheckBox chkPazartesi;
        protected System.Web.UI.WebControls.CheckBox chkSali;
        protected System.Web.UI.WebControls.CheckBox chkCarsamba;
        protected System.Web.UI.WebControls.CheckBox chkPersembe;
        protected System.Web.UI.WebControls.CheckBox chkCuma;
        protected System.Web.UI.WebControls.CheckBox chkCumartesi;
        protected System.Web.UI.WebControls.CheckBox chkPazar;

        // Genişletilmiş program önerileri
        private Dictionary<string, List<string>> workoutPlans;

        // Varsayılan egzersiz planları
        private static readonly Dictionary<string, List<string>> DefaultWorkoutPlans;

        // Static constructor
        static Program()
        {
            DefaultWorkoutPlans = new Dictionary<string, List<string>>
            {
                { "Göğüs", new List<string> { "Bench Press", "Incline Dumbbell Press", "Push-up", "Dumbbell Fly", "Cable Crossover", "Chest Dip" } },
                { "Bacak", new List<string> { "Squat", "Lunge", "Leg Press", "Leg Extension", "Hamstring Curl", "Calf Raise" } },
                { "Sırt", new List<string> { "Deadlift", "Lat Pulldown", "Barbell Row", "Pull-up", "T-Bar Row" } },
                { "Kardiyo", new List<string> { "HIIT", "Burpee" } },
                { "Kol", new List<string> { "Preacher Curl" } },
                { "Omuz", new List<string> { "Shoulder Press", "Reverse Fly", "Face Pull", "Upright Row", "Arnold Press" } }
            };
        }

        // JSON verilerini JavaScript'e aktarmak için property
        public string WorkoutPlansJson
        {
            get
            {
                try
                {
                    if (workoutPlans == null)
                    {
                        LoadWorkoutPlans();
                    }
                    // JavaScriptSerializer kullanarak güvenli JSON üretimi
                    var serializer = new JavaScriptSerializer();
                    return serializer.Serialize(workoutPlans ?? DefaultWorkoutPlans);
                }
                catch
                {
                    // Hata durumunda varsayılan değerleri kullan
                    var serializer = new JavaScriptSerializer();
                    return serializer.Serialize(DefaultWorkoutPlans);
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    LoadWorkoutPlans();
                    if (Session["UserId"] == null)
                    {
                        Response.Redirect("Login.aspx");
                    }
                }
                else
                {
                    // PostBack durumunda da workoutPlans'ı yükle
                    if (workoutPlans == null)
                    {
                        LoadWorkoutPlans();
                    }
                }
            }
            catch (Exception ex)
            {
                // Hata durumunda varsayılan değerleri kullan
                workoutPlans = new Dictionary<string, List<string>>(DefaultWorkoutPlans);
                System.Diagnostics.Debug.WriteLine("Page_Load hatası: " + ex.Message);
            }
        }

        private void LoadWorkoutPlans()
        {
            try
            {
                // Önce workoutPlans'ı varsayılan değerlerle başlat
                workoutPlans = new Dictionary<string, List<string>>(DefaultWorkoutPlans);

                // HttpContext.Current'i kontrol et
                if (HttpContext.Current == null)
                {
                    System.Diagnostics.Debug.WriteLine("HttpContext.Current null");
                    return; // Varsayılan değerleri kullanmaya devam et
                }

                // Server nesnesini kontrol et
                if (HttpContext.Current.Server == null)
                {
                    System.Diagnostics.Debug.WriteLine("HttpContext.Current.Server null");
                    return; // Varsayılan değerleri kullanmaya devam et
                }

                // App_Data klasörünün varlığını kontrol et
                string appDataPath = null;
                try
                {
                    appDataPath = HttpContext.Current.Server.MapPath("~/App_Data");
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Server.MapPath hatası: " + ex.Message);
                    return; // Varsayılan değerleri kullanmaya devam et
                }

                if (string.IsNullOrEmpty(appDataPath))
                {
                    System.Diagnostics.Debug.WriteLine("App_Data yolu null veya boş");
                    return; // Varsayılan değerleri kullanmaya devam et
                }

                if (!Directory.Exists(appDataPath))
                {
                    try
                    {
                        Directory.CreateDirectory(appDataPath);
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Klasör oluşturma hatası: " + ex.Message);
                        return; // Varsayılan değerleri kullanmaya devam et
                    }
                }

                string jsonFilePath = Path.Combine(appDataPath, "workoutPlans.json");
                if (File.Exists(jsonFilePath))
                {
                    try
                    {
                        string jsonString = File.ReadAllText(jsonFilePath);
                        if (!string.IsNullOrEmpty(jsonString))
                        {
                            var serializer = new JavaScriptSerializer();
                            var loadedPlans = serializer.Deserialize<Dictionary<string, List<string>>>(jsonString);
                            if (loadedPlans != null && loadedPlans.Count > 0)
                            {
                                workoutPlans = loadedPlans;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("JSON okuma hatası: " + ex.Message);
                        // Varsayılan değerleri kullanmaya devam et
                    }
                }
                else
                {
                    try
                    {
                        // JSON dosyası yoksa varsayılan değerleri kaydet
                        var serializer = new JavaScriptSerializer();
                        string defaultJson = serializer.Serialize(DefaultWorkoutPlans);
                        File.WriteAllText(jsonFilePath, defaultJson);
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("JSON dosyası yazma hatası: " + ex.Message);
                        // Varsayılan değerleri kullanmaya devam et
                    }
                }
            }
            catch (Exception ex)
            {
                // Hata durumunda varsayılan değerleri kullan
                workoutPlans = new Dictionary<string, List<string>>(DefaultWorkoutPlans);
                System.Diagnostics.Debug.WriteLine("LoadWorkoutPlans genel hata: " + ex.Message);
            }
        }

        protected void ddlMuscleGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            lstWorkouts.Items.Clear();
            string selectedGroup = ddlMuscleGroup.SelectedValue;

            if (workoutPlans.ContainsKey(selectedGroup))
            {
                foreach (string workout in workoutPlans[selectedGroup])
                {
                    lstWorkouts.Items.Add(workout);
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // Kas grubu seçilmiş mi kontrol et
                if (string.IsNullOrEmpty(ddlMuscleGroup.SelectedValue))
                {
                    lblMessage.Text = "Lütfen önce bir kas grubu seçiniz.";
                    lblMessage.CssClass = "alert alert-warning mt-3";
                    return;
                }

                // Seçili egzersizleri al - client tarafında seçim yapıldıysa hidden field'dan al
                string hiddenWorkouts = Request.Form["selectedWorkoutsHidden"];
                List<WorkoutSelection> selectedWorkouts = new List<WorkoutSelection>();

                if (!string.IsNullOrEmpty(hiddenWorkouts))
                {
                    try
                    {
                        // JavaScriptSerializer ile JSON parse
                        var serializer = new JavaScriptSerializer();
                        selectedWorkouts = serializer.Deserialize<List<WorkoutSelection>>(hiddenWorkouts);
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Egzersiz seçimlerini işlerken hata oluştu: " + ex.Message;
                        lblMessage.CssClass = "alert alert-danger mt-3";
                        return;
                    }
                }
                else
                {
                    // Fallback olarak server-side seçimleri kontrol et
                    if (lstWorkouts.GetSelectedIndices().Length == 0)
                    {
                        lblMessage.Text = "Lütfen en az bir egzersiz seçiniz.";
                        lblMessage.CssClass = "alert alert-warning mt-3";
                        return;
                    }

                    // Server tarafı seçimleri al
                    foreach (int index in lstWorkouts.GetSelectedIndices())
                    {
                        selectedWorkouts.Add(new WorkoutSelection
                        {
                            MuscleGroup = ddlMuscleGroup.SelectedValue,
                            WorkoutName = lstWorkouts.Items[index].Text
                        });
                    }
                }

                // En az bir hareket seçilmiş mi kontrol et
                if (selectedWorkouts.Count == 0)
                {
                    lblMessage.Text = "Lütfen en az bir egzersiz seçiniz.";
                    lblMessage.CssClass = "alert alert-warning mt-3";
                    return;
                }

                // Kullanıcı kimliğini al
                int userId = GetCurrentUserId();
                if (userId <= 0)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Seçilen günleri topla
                List<string> selectedDays = new List<string>();
                if (chkPazartesi.Checked) selectedDays.Add("Pazartesi");
                if (chkSali.Checked) selectedDays.Add("Salı");
                if (chkCarsamba.Checked) selectedDays.Add("Çarşamba");
                if (chkPersembe.Checked) selectedDays.Add("Perşembe");
                if (chkCuma.Checked) selectedDays.Add("Cuma");
                if (chkCumartesi.Checked) selectedDays.Add("Cumartesi");
                if (chkPazar.Checked) selectedDays.Add("Pazar");

                string daysString = string.Join(",", selectedDays);

                // Veritabanı bağlantısı oluştur
                string connectionString = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Seçilen hareketleri programla ilişkilendir - her biri kendi kas grubuyla kaydedilir
                    foreach (var workout in selectedWorkouts)
                    {
                        if (string.IsNullOrEmpty(workout.WorkoutName))
                            continue; // Boş egzersiz adlarını atla

                        string insertWorkoutSql = @"
                            INSERT INTO Programs (UserId, MuscleGroup, WorkoutName, Days)
                            VALUES (@UserId, @MuscleGroup, @WorkoutName, @Days)
                        ";

                        using (SqlCommand cmd = new SqlCommand(insertWorkoutSql, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserId", userId);
                            cmd.Parameters.AddWithValue("@MuscleGroup", workout.MuscleGroup);
                            cmd.Parameters.AddWithValue("@WorkoutName", workout.WorkoutName);
                            cmd.Parameters.AddWithValue("@Days", daysString);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Başarılı mesajı göster
                    lblMessage.Text = "Programınız başarıyla kaydedildi!";
                    lblMessage.CssClass = "success-message";
                }
            }
            catch (Exception ex)
            {
                // Hata mesajı göster
                lblMessage.Text = "Hata: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger mt-3";
            }
        }

        /// <summary>
        /// Oturum açmış kullanıcının ID'sini alır
        /// </summary>
        private int GetCurrentUserId()
        {
            if (Session["UserId"] != null)
            {
                return Convert.ToInt32(Session["UserId"]);
            }
            return -1;
        }

        // WorkoutSelection sınıfı ekle - egzersiz adı ve kas grubunu birlikte saklar
        public class WorkoutSelection
        {
            public string MuscleGroup { get; set; }
            public string WorkoutName { get; set; }
        }
    }
}