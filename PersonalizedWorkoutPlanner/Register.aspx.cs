using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PersonalizedWorkoutPlanner
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                string query = "INSERT INTO Users (Username, Password, Height, Weight, Goal) " +
                               "VALUES (@Username, @Password, @Height, @Weight, @Goal)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                cmd.Parameters.AddWithValue("@Height", Convert.ToInt32(txtHeight.Text));
                cmd.Parameters.AddWithValue("@Weight", Convert.ToInt32(txtWeight.Text));
                cmd.Parameters.AddWithValue("@Goal", ddlGoal.SelectedValue);

                conn.Open();
                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    lblMessage.Text = "Kayıt başarılı! Giriş sayfasına yönlendiriliyorsunuz...";
                    Response.AddHeader("REFRESH", "2;URL=Login.aspx");
                }
                else
                {
                    lblMessage.Text = "Kayıt başarısız!";
                }
            }
        }
    }
}