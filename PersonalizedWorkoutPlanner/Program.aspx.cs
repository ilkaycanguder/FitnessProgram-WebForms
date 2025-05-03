using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Linq;

namespace PersonalizedWorkoutPlanner
{
    public partial class Program : System.Web.UI.Page
    {
        // Genişletilmiş program önerileri
        private Dictionary<string, List<string>> workoutPlans = new Dictionary<string, List<string>>()
        {
            { "Göğüs", new List<string> {
                "Bench Press",
                "Incline Dumbbell Press",
                "Push-up",
                "Dumbbell Fly",
                "Cable Crossover",
                "Chest Dip"
            }},

            { "Bacak", new List<string> {
                "Squat",
                "Lunge",
                "Leg Press",
                "Leg Extension",
                "Hamstring Curl",
                "Calf Raise"
            }},

            { "Sırt", new List<string> {
                "Deadlift",
                "Lat Pulldown",
                "Barbell Row",
                "Pull-up",
                "T-Bar Row",
                "Face Pull"
            }},

            { "Kardiyo", new List<string> {
                "Koşu Bandı",
                "Bisiklet",
                "İp Atlama",
                "Eliptik Bisiklet",
                "Kürek Çekme",
                "Yüzme"
            }},

            { "Kol", new List<string> {
                "Bicep Curl",
                "Tricep Extension",
                "Hammer Curl",
                "Skull Crusher",
                "Concentration Curl",
                "Dips"
            }},

            { "Omuz", new List<string> {
                "Shoulder Press",
                "Lateral Raise",
                "Front Raise",
                "Reverse Fly",
                "Face Pull",
                "Upright Row"
            }}
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
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
                        // Elimizde JSON formatında veri var: [{"muscleGroup":"Göğüs","workoutName":"Bench Press"},...]
                        // Manuel JSON parsing yerine daha güvenilir yöntem kullanalım

                        // String'i temizle
                        string json = hiddenWorkouts.Trim();

                        // Basit çözümleme - köşeli parantezleri kaldır
                        if (json.StartsWith("[") && json.EndsWith("]"))
                        {
                            json = json.Substring(1, json.Length - 2);

                            // Her bir öğeyi ayır: {"muscleGroup":"Göğüs","workoutName":"Bench Press"}
                            string[] items = json.Split(new string[] { "},{" }, StringSplitOptions.None);

                            foreach (string item in items)
                            {
                                // Süslü parantezleri ve tırnak işaretlerini temizle
                                string cleanItem = item
                                    .Replace("{", "")
                                    .Replace("}", "")
                                    .Replace("\"muscleGroup\":\"", "muscleGroup:")
                                    .Replace("\",\"workoutName\":\"", ",workoutName:")
                                    .Replace("\"", "");

                                // Bileşenleri ayır
                                string[] pairs = cleanItem.Split(',');

                                if (pairs.Length >= 2)
                                {
                                    string muscleGroup = pairs[0].Replace("muscleGroup:", "").Trim();
                                    string workoutName = pairs[1].Replace("workoutName:", "").Trim();

                                    if (!string.IsNullOrEmpty(muscleGroup) && !string.IsNullOrEmpty(workoutName))
                                    {
                                        selectedWorkouts.Add(new WorkoutSelection
                                        {
                                            MuscleGroup = muscleGroup,
                                            WorkoutName = workoutName
                                        });
                                    }
                                }
                            }
                        }
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
                string selectedDays = string.Join(",",
                    chkPazartesi.Checked ? "Pazartesi" : null,
                    chkSali.Checked ? "Salı" : null,
                    chkCarsamba.Checked ? "Çarşamba" : null,
                    chkPersembe.Checked ? "Perşembe" : null,
                    chkCuma.Checked ? "Cuma" : null,
                    chkCumartesi.Checked ? "Cumartesi" : null,
                    chkPazar.Checked ? "Pazar" : null
                );
                selectedDays = string.Join(",", selectedDays.Split(',').Where(x => !string.IsNullOrEmpty(x)));

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
                            cmd.Parameters.AddWithValue("@Days", selectedDays);
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