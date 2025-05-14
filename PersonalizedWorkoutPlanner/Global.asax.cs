using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Configuration;
using System.Data.SqlClient;

namespace PersonalizedWorkoutPlanner
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // WebService ve WebMethod çağrıları için session başlatma
            HttpContext.Current?.SetSessionStateBehavior(SessionStateBehavior.Required);

            // Default route'u ayarla
            RouteTable.Routes.MapPageRoute(
                "DefaultRoute",
                "",
                "~/Default.aspx"
            );
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            try
            {
                // Session başlangıcında çalışacak kod
                if (Session != null)
                {
                    System.Diagnostics.Debug.WriteLine("Session başlatıldı: " + Session.SessionID);
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Session başlatıldı fakat Session nesnesi null.");
                    return;
                }

                // Kullanıcı kimliği doğrulanmışsa Session'a UserId bilgisini ekle
                if (Context != null && Context.User != null && Context.User.Identity != null && Context.User.Identity.IsAuthenticated)
                {
                    string username = Context.User.Identity.Name;
                    System.Diagnostics.Debug.WriteLine("Kimliği doğrulanmış kullanıcı bulundu: " + username);

                    // Veritabanından kullanıcı ID'sini al
                    try
                    {
                        string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
                        using (SqlConnection conn = new SqlConnection(conStr))
                        {
                            string query = "SELECT Id FROM Users WHERE Username = @Username";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@Username", username);

                            conn.Open();
                            object result = cmd.ExecuteScalar();

                            if (result != null)
                            {
                                int userId = Convert.ToInt32(result);
                                Session["UserId"] = userId;
                                Session["Username"] = username;
                                System.Diagnostics.Debug.WriteLine($"Session'a UserId eklendi: {userId}");
                            }
                        }
                    }
                    catch (Exception dbEx)
                    {
                        System.Diagnostics.Debug.WriteLine("Session_Start veritabanı hatası: " + (dbEx != null ? dbEx.ToString() : "Null exception"));
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Session_Start genel hata: " + (ex != null ? ex.ToString() : "Null exception"));
            }
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            try
            {
                // CORS ve seçenek istekleri için güvenlik başlıkları
                // Origin null kontrolü ekle
                if (HttpContext.Current != null && HttpContext.Current.Request != null && HttpContext.Current.Response != null)
                {
                    // Erişim için tüm başlıkları ayarla
                    HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", HttpContext.Current.Request.Headers["Origin"] ?? "*");
                    HttpContext.Current.Response.AddHeader("Access-Control-Allow-Credentials", "true");
                    HttpContext.Current.Response.AddHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
                    HttpContext.Current.Response.AddHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");

                    // OPTIONS isteğini işle
                    if (HttpContext.Current.Request.HttpMethod == "OPTIONS")
                    {
                        HttpContext.Current.Response.StatusCode = 200;
                        HttpContext.Current.Response.End();
                    }

                    // FormsAuthentication ve Session cookie'lerini ayarlamaya zorla
                    if (HttpContext.Current.Request.Path.EndsWith(".aspx") &&
                        HttpContext.Current.User != null &&
                        HttpContext.Current.User.Identity != null &&
                        HttpContext.Current.User.Identity.IsAuthenticated &&
                        HttpContext.Current.Session != null)
                    {
                        // Session değişkeni eklenir
                        if (HttpContext.Current.Session["UserId"] == null)
                        {
                            string username = HttpContext.Current.User.Identity.Name;
                            System.Diagnostics.Debug.WriteLine($"BeginRequest'de kullanıcı adı: {username}");

                            try
                            {
                                string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
                                using (SqlConnection conn = new SqlConnection(conStr))
                                {
                                    string query = "SELECT Id FROM Users WHERE Username = @Username";
                                    SqlCommand cmd = new SqlCommand(query, conn);
                                    cmd.Parameters.AddWithValue("@Username", username);

                                    conn.Open();
                                    object result = cmd.ExecuteScalar();

                                    if (result != null)
                                    {
                                        int userId = Convert.ToInt32(result);
                                        HttpContext.Current.Session["UserId"] = userId;
                                        HttpContext.Current.Session["Username"] = username;
                                        System.Diagnostics.Debug.WriteLine($"BeginRequest'de UserId eklendi: {userId}");
                                    }
                                }
                            }
                            catch (Exception dbEx)
                            {
                                System.Diagnostics.Debug.WriteLine("BeginRequest veritabanı hatası: " + (dbEx != null ? dbEx.ToString() : "Null exception"));
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Application_BeginRequest hatası: " + (ex != null ? ex.ToString() : "Null exception"));
            }
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            try
            {
                // AuthenticateRequest olayında giriş kontrolü
                if (HttpContext.Current != null &&
                    HttpContext.Current.User != null &&
                    HttpContext.Current.User.Identity != null &&
                    HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    string username = HttpContext.Current.User.Identity.Name;

                    // Session null değilse kontrol et
                    if (HttpContext.Current.Session != null)
                    {
                        System.Diagnostics.Debug.WriteLine($"Kimliği doğrulanmış kullanıcı: {username}, Session UserId: {HttpContext.Current.Session["UserId"]}");

                        // Session'da UserId yoksa ama kullanıcı giriş yapmışsa session verilerini ekle
                        if (HttpContext.Current.Session["UserId"] == null)
                        {
                            // Burada Session_Start'taki kodu tekrar kullanılabilir
                            try
                            {
                                string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
                                using (SqlConnection conn = new SqlConnection(conStr))
                                {
                                    string query = "SELECT Id FROM Users WHERE Username = @Username";
                                    SqlCommand cmd = new SqlCommand(query, conn);
                                    cmd.Parameters.AddWithValue("@Username", username);

                                    conn.Open();
                                    object result = cmd.ExecuteScalar();

                                    if (result != null)
                                    {
                                        int userId = Convert.ToInt32(result);
                                        HttpContext.Current.Session["UserId"] = userId;
                                        HttpContext.Current.Session["Username"] = username;
                                        System.Diagnostics.Debug.WriteLine($"AuthenticateRequest'de UserId eklendi: {userId}");
                                    }
                                    else
                                    {
                                        // Kullanıcı bulunamadı, oturumu sonlandır
                                        try
                                        {
                                            FormsAuthentication.SignOut();
                                            if (!HttpContext.Current.Response.IsRequestBeingRedirected)
                                            {
                                                HttpContext.Current.Response.Redirect("~/Login.aspx", true);
                                            }
                                        }
                                        catch (Exception redirectEx)
                                        {
                                            System.Diagnostics.Debug.WriteLine("Redirect hatası: " + (redirectEx != null ? redirectEx.ToString() : "Null exception"));
                                        }
                                    }
                                }
                            }
                            catch (Exception dbEx)
                            {
                                System.Diagnostics.Debug.WriteLine("Application_AuthenticateRequest veritabanı hatası: " + (dbEx != null ? dbEx.ToString() : "Null exception"));
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Application_AuthenticateRequest genel hata: " + (ex != null ? ex.ToString() : "Null exception"));
            }
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            try
            {
                // Uygulama hatalarını yakalama
                Exception ex = Server.GetLastError();
                if (ex != null)
                {
                    System.Diagnostics.Debug.WriteLine("Uygulama Hatası: " + ex.Message);
                    System.Diagnostics.Debug.WriteLine("Hata Kaynağı: " + ex.Source);
                    System.Diagnostics.Debug.WriteLine("Yığın İzleme: " + ex.StackTrace);

                    // Özel hata durumlarını ele al
                    if (ex is ArgumentNullException)
                    {
                        System.Diagnostics.Debug.WriteLine("ArgumentNullException: " + ex.ToString());
                        // Hatayı temizle (opsiyonel)
                        Server.ClearError();
                    }
                }
            }
            catch (Exception handlerEx)
            {
                System.Diagnostics.Debug.WriteLine("Application_Error işleyici hatası: " + (handlerEx != null ? handlerEx.ToString() : "Null exception"));
            }
        }
    }
}