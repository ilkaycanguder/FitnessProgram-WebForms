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

            try
            {
                using (SqlConnection conn = new SqlConnection(conStr))
                {
                    string query = "SELECT Height, Weight, Goal FROM Users WHERE Id = @UserId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtHeight.Text = reader["Height"] != DBNull.Value ? reader["Height"].ToString() : string.Empty;
                        txtWeight.Text = reader["Weight"] != DBNull.Value ? reader["Weight"].ToString() : string.Empty;
                        
                        string userGoal = reader["Goal"] != DBNull.Value ? reader["Goal"].ToString() : string.Empty;
                        if (!string.IsNullOrEmpty(userGoal))
                        {
                            ddlGoal.SelectedValue = userGoal;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Bilgileri yüklerken bir hata oluştu: " + ex.Message;
                lblMessage.CssClass = "success-message show error-message";
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserId"]);

            try
            {
                using (SqlConnection conn = new SqlConnection(conStr))
                {
                    string query = "UPDATE Users SET Height = @Height, Weight = @Weight, Goal = @Goal WHERE Id = @UserId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@Height", string.IsNullOrEmpty(txtHeight.Text) ? (object)DBNull.Value : Convert.ToInt32(txtHeight.Text));
                    cmd.Parameters.AddWithValue("@Weight", string.IsNullOrEmpty(txtWeight.Text) ? (object)DBNull.Value : Convert.ToInt32(txtWeight.Text));
                    cmd.Parameters.AddWithValue("@Goal", string.IsNullOrEmpty(ddlGoal.SelectedValue) ? (object)DBNull.Value : ddlGoal.SelectedValue);

                    conn.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        lblMessage.Text = "Profil bilgileriniz başarıyla güncellendi.";
                        lblMessage.CssClass = "success-message show";
                    }
                    else
                    {
                        lblMessage.Text = "Güncelleme sırasında bir hata oluştu. Lütfen tekrar deneyin.";
                        lblMessage.CssClass = "success-message show error-message";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Güncelleme sırasında bir hata oluştu: " + ex.Message;
                lblMessage.CssClass = "success-message show error-message";
            }
        }
    }
} 