using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace PersonalizedWorkoutPlanner
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kullanıcı zaten giriş yapmışsa, Program.aspx'e yönlendir
            if (Session["UserId"] != null)
            {
                Response.Redirect("Program.aspx");
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                try
                {
                    string query = "SELECT Id, Username FROM Users WHERE Username = @Username AND Password = @Password";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        int userId = Convert.ToInt32(reader["Id"]);
                        string username = reader["Username"].ToString();

                        // Session değişkenlerini ayarla
                        Session["UserId"] = userId;
                        Session["Username"] = username;

                        // Authentication cookie ayarla
                        FormsAuthentication.SetAuthCookie(username, true);

                        // Ana sayfaya yönlendir
                        Response.Redirect("Program.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Geçersiz kullanıcı adı veya şifre.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Bir hata oluştu: " + ex.Message;
                    System.Diagnostics.Debug.WriteLine("Login hatası: " + ex.ToString());
                }
            }
        }
    }
}