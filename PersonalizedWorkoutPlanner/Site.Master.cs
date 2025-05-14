using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace PersonalizedWorkoutPlanner
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LogOut(object sender, EventArgs e)
        {
            // Clear all session data
            Session.Clear();
            Session.Abandon();
            
            // Prevent caching
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoStore();
            
            // Forms Authentication sign out
            FormsAuthentication.SignOut();
            
            // Redirect to login page
            Response.Redirect("Login.aspx");
        }
    }
}