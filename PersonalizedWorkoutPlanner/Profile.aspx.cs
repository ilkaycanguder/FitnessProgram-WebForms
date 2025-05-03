using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace PersonalizedWorkoutPlanner
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserData();
            }
        }

        private void LoadUserData()
        {
            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                string query = "SELECT Height, Weight, Goal FROM Users WHERE Id = @UserId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtHeight.Text = reader["Height"].ToString();
                    txtWeight.Text = reader["Weight"].ToString();
                    
                    string userGoal = reader["Goal"].ToString();
                    if (!string.IsNullOrEmpty(userGoal))
                    {
                        ddlGoal.SelectedValue = userGoal;
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                string query = "UPDATE Users SET Height = @Height, Weight = @Weight, Goal = @Goal WHERE Id = @UserId";
                SqlCommand cmd = new SqlCommand(query, conn);
                
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@Height", Convert.ToInt32(txtHeight.Text));
                cmd.Parameters.AddWithValue("@Weight", Convert.ToInt32(txtWeight.Text));
                cmd.Parameters.AddWithValue("@Goal", ddlGoal.SelectedValue);

                conn.Open();
                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    lblMessage.Text = "Profil bilgileriniz başarıyla güncellendi.";
                }
                else
                {
                    lblMessage.Text = "Güncelleme sırasında bir hata oluştu. Lütfen tekrar deneyin.";
                }
            }
        }
    }
} 