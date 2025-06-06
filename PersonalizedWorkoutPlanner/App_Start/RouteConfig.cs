using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace PersonalizedWorkoutPlanner
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);

            // Default sayfa yönlendirmesi
            routes.MapPageRoute(
                "DefaultPage",
                "",
                "~/Default.aspx"
            );
        }
    }
}
