using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Text;

namespace PersonalizedWorkoutPlanner
{
    public partial class Profile : System.Web.UI.Page
    {
        // BMI değeri için public property
        public double CalculatedBMI { get; set; }
        public string BMICategory { get; set; }
        public string BMIColor { get; set; }
        public int BMIPercentage { get; set; }

        // BMI göstergesi için kullanılacak değer
        public int BMIPosition { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // IsPostBack kontrolü
            if (!IsPostBack)
            {
                LoadUserData();
            }
            else
            {
                // POST işlemi olsa bile BMI'yı hesaplamak için verileri doğrula
                System.Diagnostics.Debug.WriteLine("PostBack - BMI yeniden hesaplanıyor");
            }

            try
            {
                // Her durumda BMI değerlerini hesapla
                CalculateBMI();

                // BMI kontrollerini güncelle
                UpdateBMIControls();

                // JavaScript için BMI animasyonunu tetikle
                if (!IsPostBack) // Sadece ilk yüklemede otomatik animasyon
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "initBmiAnimation",
                        "setTimeout(function() { animateBMI(); }, 500);", true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Page_Load BMI hesaplama hatası: " + ex.ToString());
            }
        }

        private void LoadUserData()
        {
            string conStr = ConfigurationManager.ConnectionStrings["FitnessDBConnectionString"].ConnectionString;
            int userId = Convert.ToInt32(Session["UserId"]);

            System.Diagnostics.Debug.WriteLine($"LoadUserData çağrıldı. UserId: {userId}");

            try
            {
                using (SqlConnection conn = new SqlConnection(conStr))
                {
                    string query = "SELECT Height, Weight, Goal FROM Users WHERE Id = @UserId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.CommandTimeout = 30;

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Boy değerini al ve ayarla
                            if (reader["Height"] != DBNull.Value)
                            {
                                int height = Convert.ToInt32(reader["Height"]);
                                txtHeight.Text = height.ToString();
                                System.Diagnostics.Debug.WriteLine($"Kullanıcı boyu: {height} cm");
                            }
                            else
                            {
                                txtHeight.Text = string.Empty;
                                System.Diagnostics.Debug.WriteLine("Kullanıcı boyu: null");
                            }

                            // Kilo değerini al ve ayarla
                            if (reader["Weight"] != DBNull.Value)
                            {
                                int weight = Convert.ToInt32(reader["Weight"]);
                                txtWeight.Text = weight.ToString();
                                System.Diagnostics.Debug.WriteLine($"Kullanıcı kilosu: {weight} kg");
                            }
                            else
                            {
                                txtWeight.Text = string.Empty;
                                System.Diagnostics.Debug.WriteLine("Kullanıcı kilosu: null");
                            }

                            // Hedef değerini al ve ayarla
                            string userGoal = reader["Goal"] != DBNull.Value ? reader["Goal"].ToString() : string.Empty;
                            if (!string.IsNullOrEmpty(userGoal))
                            {
                                ddlGoal.SelectedValue = userGoal;
                                System.Diagnostics.Debug.WriteLine($"Kullanıcı hedefi: {userGoal}");
                            }
                            else
                            {
                                System.Diagnostics.Debug.WriteLine("Kullanıcı hedefi: null");
                            }
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine("Kullanıcı bulunamadı!");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Bilgileri yüklerken bir hata oluştu: " + ex.Message;
                lblMessage.CssClass = "success-message show error-message";
                System.Diagnostics.Debug.WriteLine("Veri yükleme hatası: " + ex.ToString());
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

            System.Diagnostics.Debug.WriteLine($"btnUpdate_Click çağrıldı. UserId: {userId}");
            System.Diagnostics.Debug.WriteLine($"Boy: {txtHeight.Text}, Kilo: {txtWeight.Text}, Hedef: {ddlGoal.SelectedValue}");

            try
            {
                int height = 0;
                int weight = 0;
                string goal = ddlGoal.SelectedValue;

                // Parse ve doğrulama işlemleri
                if (!string.IsNullOrEmpty(txtHeight.Text))
                {
                    if (!int.TryParse(txtHeight.Text, out height))
                    {
                        lblMessage.Text = "Boy değeri geçerli bir sayı değil!";
                        lblMessage.CssClass = "success-message show error-message";
                        return;
                    }
                }

                if (!string.IsNullOrEmpty(txtWeight.Text))
                {
                    if (!int.TryParse(txtWeight.Text, out weight))
                    {
                        lblMessage.Text = "Kilo değeri geçerli bir sayı değil!";
                        lblMessage.CssClass = "success-message show error-message";
                        return;
                    }
                }

                // Veritabanı bağlantısı ve güncelleme
                using (SqlConnection conn = new SqlConnection(conStr))
                {
                    try
                    {
                        conn.Open();
                        System.Diagnostics.Debug.WriteLine("Veritabanı bağlantısı açıldı");

                        // SQL sorgusu
                        string query = "UPDATE Users SET Height = @Height, Weight = @Weight, Goal = @Goal WHERE Id = @UserId";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.CommandTimeout = 30;

                            // Parametreleri ekle
                            cmd.Parameters.AddWithValue("@UserId", userId);

                            // Boy ve kilo değerlerini kontrol et
                            if (height > 0)
                                cmd.Parameters.AddWithValue("@Height", height);
                            else
                                cmd.Parameters.AddWithValue("@Height", DBNull.Value);

                            if (weight > 0)
                                cmd.Parameters.AddWithValue("@Weight", weight);
                            else
                                cmd.Parameters.AddWithValue("@Weight", DBNull.Value);

                            // Goal değeri
                            if (string.IsNullOrEmpty(goal))
                                cmd.Parameters.AddWithValue("@Goal", DBNull.Value);
                            else
                                cmd.Parameters.AddWithValue("@Goal", goal);

                            System.Diagnostics.Debug.WriteLine("Veritabanı güncellemesi yapılıyor...");
                            System.Diagnostics.Debug.WriteLine($"SQL: {query}");
                            System.Diagnostics.Debug.WriteLine($"Parametreler: UserId={userId}, Height={height}, Weight={weight}, Goal={goal}");

                            int result = cmd.ExecuteNonQuery();
                            System.Diagnostics.Debug.WriteLine("Güncelleme sonucu: " + result);

                            if (result > 0)
                            {
                                lblMessage.Text = "Profil bilgileriniz başarıyla güncellendi.";
                                lblMessage.CssClass = "success-message show";

                                // Önceki BMI değerini sakla
                                double previousBMI = CalculatedBMI;

                                // BMI değerini hesapla
                                CalculateBMI();

                                // BMI kontrollerini güncelle
                                UpdateBMIControls();

                                // BMI kart animasyonunu tetikle
                                string script = $@"
                                    setTimeout(function() {{ 
                                        console.log('BMI güncelleniyor - Eski: {previousBMI.ToString("0.0").Replace(',', '.')}, Yeni: {CalculatedBMI.ToString("0.0").Replace(',', '.')}');
                                        animateBMI(true, {previousBMI.ToString("0.0").Replace(',', '.')}, {CalculatedBMI.ToString("0.0").Replace(',', '.')});
                                    }}, 500);";

                                ScriptManager.RegisterStartupScript(this, GetType(), "triggerBmiAnimation", script, true);
                            }
                            else
                            {
                                lblMessage.Text = "Güncelleme sırasında bir hata oluştu. Lütfen tekrar deneyin.";
                                lblMessage.CssClass = "success-message show error-message";
                                System.Diagnostics.Debug.WriteLine("Güncelleme başarısız: Etkilenen satır sayısı = 0");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Veritabanı hatası: " + ex.Message);
                        throw; // Hatayı üst catch bloğuna aktar
                    }
                }
            }
            catch (Exception ex)
            {
                // Hata mesajını detaylı göster
                lblMessage.Text = "Güncelleme sırasında bir hata oluştu: " + ex.Message;
                lblMessage.CssClass = "success-message show error-message";
                System.Diagnostics.Debug.WriteLine("HATA: " + ex.ToString());
            }
        }

        // BMI kontrollerini güncelle
        private void UpdateBMIControls()
        {
            try
            {
                // Debug için mesaj
                System.Diagnostics.Debug.WriteLine($"UpdateBMIControls çağrıldı. BMI: {CalculatedBMI}, Kategori: {BMICategory}, Renk: {BMIColor}");

                // Panel'in görünürlüğünü ayarla
                pnlBMI.Visible = (CalculatedBMI > 0);

                if (CalculatedBMI > 0)
                {
                    // Literal kontrollerini doldur
                    litBMIValue.Text = CalculatedBMI.ToString("0.0");
                    litBMICategory.Text = BMICategory;
                    litHeight.Text = txtHeight.Text;
                    litWeight.Text = txtWeight.Text;

                    // Kategori paneli stil
                    pnlCategory.Style["background-color"] = BMIColor;
                    pnlCategory.Style["color"] = "white";

                    // BMI gösterge konumu hesapla (0-100 arası)
                    BMIPosition = CalculatePositionOnScale(CalculatedBMI);
                    System.Diagnostics.Debug.WriteLine($"BMI Pozisyonu hesaplandı: {BMIPosition}%");

                    // SORUN ÇÖZÜMÜ: BMI değerleri doğrudan sayısal olarak hesaplanacak
                    int bmiPercent = BMIPosition;
                    string bmiColor = BMIColor;
                    double bmiValue = CalculatedBMI;

                    // Debug bilgisi
                    System.Diagnostics.Debug.WriteLine($"Hesaplanan BMI değerleri - Pozisyon: {bmiPercent}%, Renk: {bmiColor}, Değer: {bmiValue}");

                    // ÖNEMLİ: Progress bar direkt attribute olarak stil verelim
                    // CSS stil yerine doğrudan HTML attribute olarak genişliği ayarla
                    pnlProgressBar.Attributes["style"] = $"width: {bmiPercent}%; background-color: {bmiColor}; height: 100%;";

                    // Debugger ile kontrol
                    System.Diagnostics.Debug.WriteLine($"pnlProgressBar style attribute: {pnlProgressBar.Attributes["style"]}");

                    // HTML kaynak koduna eklemek için ScriptManager kullan
                    string immediateWidthFix = $@"
                        <script>
                            // Sunucu tarafında ayarlanan değeri doğrudan global değişkenlere ata
                            window.currentBMI = {bmiValue.ToString("0.0").Replace(',', '.')};
                            window.currentBMICategory = '{BMICategory}';
                            window.currentBMIColor = '{bmiColor}';
                            window.currentBMIPosition = {bmiPercent};
                            
                            console.log('BMI değerleri doğrudan ayarlandı:', {{
                                bmi: window.currentBMI,
                                category: window.currentBMICategory,
                                color: window.currentBMIColor,
                                position: window.currentBMIPosition
                            }});
                            
                            // Sunucu tarafında ayarlanan değeri doğrudan HTML'e ekle
                            document.addEventListener('DOMContentLoaded', function() {{
                                var progressBar = document.getElementById('pnlProgressBar');
                                if (progressBar) {{
                                    progressBar.setAttribute('style', 'width: {bmiPercent}%; background-color: {bmiColor}; height: 100%;');
                                    console.log('Progress bar genişliği ayarlandı: {bmiPercent}%');
                                }}
                                
                                var indicator = document.getElementById('bmiIndicator');
                                if (indicator) {{
                                    indicator.style.left = '{bmiPercent}%';
                                    indicator.style.borderColor = '{bmiColor}';
                                    indicator.setAttribute('data-value', '{bmiValue.ToString("0.0")} - {BMICategory}');
                                }}
                            }});
                        </script>
                    ";

                    // ScriptManager ile script ekle - false parametresi script etiketlerini de ekler
                    ScriptManager.RegisterStartupScript(pnlProgressBar, GetType(), "directStyleFix", immediateWidthFix, false);

                    // Düzenli JavaScript çağrısı 
                    string script = $@"
                        // Sayfa yüklendiğinde stil uygula
                        window.addEventListener('load', function() {{
                            // Progress bar elementini bul
                            var progressBar = document.getElementById('pnlProgressBar');
                            var indicator = document.getElementById('bmiIndicator');
                            
                            if (progressBar) {{
                                // Stili direkt uygula
                                progressBar.style.cssText = 'width: {bmiPercent}%; background-color: {bmiColor}; height: 100%;';
                                console.log('Sayfa yüklendi, progress bar stili uygulandı: {bmiPercent}%');
                            }}
                            
                            if (indicator) {{
                                indicator.style.left = '{bmiPercent}%';
                                indicator.style.borderColor = '{bmiColor}';
                            }}
                            
                            // BMI değişimini animasyonla göster
                            setTimeout(function() {{
                                animateBMI(false, {bmiValue.ToString("0.0").Replace(',', '.')}, {bmiValue.ToString("0.0").Replace(',', '.')});
                            }}, 500);
                        }});
                    ";

                    // Sayfa yükleme bittiğinde çalışacak script
                    ScriptManager.RegisterStartupScript(this, GetType(), "initBmiValues", script, true);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("UpdateBMIControls hata: " + ex.ToString());
            }
        }

        // BMI değerine göre skala üzerindeki pozisyonu hesapla
        private int CalculatePositionOnScale(double bmi)
        {
            // BMI değerini 0-100 arasında bir pozisyona dönüştür
            // BMI değerleri genelde 15-40 arasında olur
            if (bmi < 15) return 0;
            if (bmi > 40) return 100;

            // 15-40 arası BMI değerlerini 0-100 arasına dönüştür
            return (int)((bmi - 15) * 4); // Her BMI birimi 4% ilerletir
        }

        // BMI değerini hesaplayan metot
        private void CalculateBMI()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("CalculateBMI çağrıldı");

                if (!string.IsNullOrEmpty(txtHeight.Text) && !string.IsNullOrEmpty(txtWeight.Text))
                {
                    // Önce doğru sayısal değerlere dönüşüp dönüşmediğini kontrol et
                    int heightCm, weightKg;
                    if (int.TryParse(txtHeight.Text, out heightCm) && int.TryParse(txtWeight.Text, out weightKg))
                    {
                        if (heightCm > 0 && weightKg > 0)
                        {
                            // Boy santimetre olarak gelir, metreye çevrilmeli
                            double heightM = heightCm / 100.0;

                            System.Diagnostics.Debug.WriteLine($"BMI hesaplanıyor: Boy = {heightM}m, Kilo = {weightKg}kg");

                            // BMI formülü: Kilo (kg) / (Boy (m) * Boy (m))
                            double bmi = weightKg / (heightM * heightM);
                            CalculatedBMI = Math.Round(bmi, 1);

                            System.Diagnostics.Debug.WriteLine($"Hesaplanan BMI: {CalculatedBMI}");

                            // BMI kategorisini belirle
                            if (CalculatedBMI < 18.5)
                            {
                                BMICategory = "Zayif";
                                BMIColor = "#f1c40f"; // Sarı
                                BMIPercentage = 25;
                            }
                            else if (CalculatedBMI < 25)
                            {
                                BMICategory = "Normal";
                                BMIColor = "#2ecc71"; // Yeşil
                                BMIPercentage = 50;
                            }
                            else if (CalculatedBMI < 30)
                            {
                                BMICategory = "Fazla Kilolu";
                                BMIColor = "#e67e22"; // Turuncu
                                BMIPercentage = 75;
                            }
                            else
                            {
                                BMICategory = "Obez";
                                BMIColor = "#e74c3c"; // Kırmızı
                                BMIPercentage = 100;
                            }

                            System.Diagnostics.Debug.WriteLine($"BMI Kategori: {BMICategory}, Renk: {BMIColor}");
                            return;
                        }
                    }
                }

                // Eğer geçerli değerler yoksa veya hesaplama başarısız olursa
                System.Diagnostics.Debug.WriteLine("BMI hesaplanamadı - geçersiz boy/kilo değerleri");
                CalculatedBMI = 0;
                BMICategory = "Hesaplanamadı";
                BMIColor = "#95a5a6"; // Gri
                BMIPercentage = 0;
            }
            catch (Exception ex)
            {
                CalculatedBMI = 0;
                BMICategory = "Hesaplama Hatası";
                BMIColor = "#95a5a6"; // Gri
                BMIPercentage = 0;
                System.Diagnostics.Debug.WriteLine("BMI hesaplama hatası: " + ex.Message);
                System.Diagnostics.Debug.WriteLine("Hata detayları: " + ex.ToString());
            }
        }
    }
}