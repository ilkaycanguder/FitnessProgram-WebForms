using System;
using System.Web;

namespace PersonalizedWorkoutPlanner
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear all session data
            Session.Clear();
            Session.Abandon();

            // Prevent caching
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();

            // Forms Authentication sign out
            System.Web.Security.FormsAuthentication.SignOut();

            // Redirect to Default.aspx
            Response.Redirect("~/Default.aspx");
        }
    }
}