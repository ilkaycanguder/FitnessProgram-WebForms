using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;


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
            if (lstWorkouts.SelectedIndex == -1)
            {
                lblMessage.Text = "Lütfen en az bir antrenman seçin.";
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            string muscleGroup = ddlMuscleGroup.SelectedValue;
            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                conn.Open();

                foreach (var item in lstWorkouts.GetSelectedIndices())
                {
                    string workoutName = lstWorkouts.Items[item].Text;

                    string query = "INSERT INTO Programs (UserId, MuscleGroup, WorkoutName) VALUES (@UserId, @MuscleGroup, @WorkoutName)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@MuscleGroup", muscleGroup);
                    cmd.Parameters.AddWithValue("@WorkoutName", workoutName);

                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "Program başarıyla kaydedildi!";
            }
        }
    }
}