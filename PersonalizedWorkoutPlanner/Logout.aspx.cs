using System;
using System.Web.UI;

namespace PersonalizedWorkoutPlanner
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear all session data
            Session.Clear();
            Session.Abandon();
        }
    }
} 