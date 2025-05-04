using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PersonalizedWorkoutPlanner
{
    public partial class _Default : System.Web.UI.Page
    {
        // Panel kontrolleri
        protected System.Web.UI.WebControls.Panel pnlNotLoggedIn;
        protected System.Web.UI.WebControls.Panel pnlLoggedIn;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kullanıcı giriş yapmış mı kontrol et
                if (Session["UserId"] != null)
                {
                    pnlNotLoggedIn.Visible = false;
                    pnlLoggedIn.Visible = true;
                }
                else
                {
                    pnlNotLoggedIn.Visible = true;
                    pnlLoggedIn.Visible = false;
                }
            }
        }
    }
}