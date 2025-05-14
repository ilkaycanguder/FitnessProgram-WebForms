<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs"
Inherits="PersonalizedWorkoutPlanner.Profile" EnableViewState="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Profil - Kisisellestirilmis Egzersiz Planlayici</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.5/gsap.min.js"></script>
    <style>
      body {
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem 0;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }

      .profile-wrapper {
        width: 100%;
        max-width: 900px;
        display: flex;
        box-shadow: 0 15px 50px rgba(0, 0, 0, 0.2);
        border-radius: 20px;
        overflow: hidden;
      }

      .profile-sidebar {
        width: 35%;
        background: url("https://images.unsplash.com/photo-1545389336-cf090694435e?q=80&w=1964&auto=format&fit=crop")
          center/cover;
        position: relative;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        padding: 2.5rem;
        color: white;
      }

      .profile-sidebar::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(
          0deg,
          rgba(30, 60, 114, 0.9) 0%,
          rgba(42, 82, 152, 0.7) 100%
        );
      }

      .sidebar-content {
        position: relative;
        z-index: 2;
      }

      .sidebar-header h2 {
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 1rem;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
      }

      .sidebar-header p {
        font-size: 1.1rem;
        opacity: 0.9;
        margin-bottom: 2rem;
      }

      .sidebar-nav {
        margin-top: auto;
      }

      .nav-btn {
        background: rgba(255, 255, 255, 0.15);
        border: 2px solid rgba(255, 255, 255, 0.3);
        color: white;
        text-decoration: none;
        font-weight: 600;
        padding: 1rem 1.5rem;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 1rem;
        transition: all 0.3s ease;
        backdrop-filter: blur(5px);
      }

      .nav-btn:hover {
        background: rgba(255, 255, 255, 0.25);
        border-color: white;
        color: white;
        transform: translateY(-3px);
      }

      .nav-btn i {
        margin-right: 0.8rem;
        font-size: 1.1rem;
      }

      .profile-container {
        background: white;
        padding: 3rem;
        width: 65%;
        display: flex;
        flex-direction: column;
      }

      .profile-header {
        margin-bottom: 2.5rem;
        position: relative;
      }

      .profile-header h2 {
        color: #1e3c72;
        font-weight: 700;
        font-size: 1.8rem;
        margin-bottom: 0.8rem;
        position: relative;
        display: inline-block;
      }

      .profile-header h2::after {
        content: "";
        position: absolute;
        bottom: -10px;
        left: 0;
        width: 50px;
        height: 3px;
        background: linear-gradient(90deg, #1e3c72, #2a5298);
        border-radius: 3px;
      }

      .profile-header p {
        color: #666;
        font-size: 1.1rem;
      }

      .form-group {
        margin-bottom: 1.8rem;
        position: relative;
      }

      .form-label {
        font-weight: 600;
        color: #1e3c72;
        margin-bottom: 0.7rem;
        display: block;
      }

      .input-wrapper {
        position: relative;
        width: 100%;
      }

      .input-icon {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        left: 1rem;
        color: #1e3c72;
        font-size: 1.2rem;
        z-index: 10;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 20px;
        text-align: center;
        pointer-events: none;
      }

      .form-control {
        border-radius: 12px;
        padding: 1rem 1rem 1rem 3rem;
        border: 2px solid #e1e8f3;
        font-size: 1rem;
        transition: all 0.3s ease;
        box-shadow: none;
        width: 100%;
      }

      .form-control:focus {
        border-color: #1e3c72;
        box-shadow: 0 0 0 0.25rem rgba(30, 60, 114, 0.15);
      }

      .form-select {
        border-radius: 12px;
        padding: 1rem 1rem 1rem 3rem;
        border: 2px solid #e1e8f3;
        font-size: 1rem;
        transition: all 0.3s ease;
        box-shadow: none;
        width: 100%;
        cursor: pointer;
        appearance: none;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%231e3c72' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 1rem center;
        background-size: 16px 12px;
      }

      .form-select:focus {
        border-color: #1e3c72;
        box-shadow: 0 0 0 0.25rem rgba(30, 60, 114, 0.15);
      }

      .btn-update {
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        color: white;
        padding: 1.2rem 2rem;
        border-radius: 12px;
        font-weight: 700;
        font-size: 1.1rem;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        border: none;
        box-shadow: 0 8px 20px rgba(30, 60, 114, 0.3);
        margin-top: 1rem;
        position: relative;
        overflow: hidden;
      }

      .btn-update::before {
        content: "";
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(
          90deg,
          transparent,
          rgba(255, 255, 255, 0.2),
          transparent
        );
        transition: all 0.6s ease;
      }

      .btn-update:hover {
        background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
        color: white;
        transform: translateY(-3px);
        box-shadow: 0 12px 25px rgba(30, 60, 114, 0.4);
      }

      .btn-update:hover::before {
        left: 100%;
      }

      .validation-error {
        color: #dc3545;
        font-size: 0.85rem;
        margin-top: 0.5rem;
        padding-left: 0.5rem;
        display: block;
      }

      .success-message {
        color: #155724;
        font-weight: 600;
        text-align: center;
        margin-top: 1.5rem;
        padding: 1rem;
        border-radius: 12px;
        background: #d4edda;
        border: 1px solid #c3e6cb;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        font-size: 1rem;
        display: none;
        animation: fadeIn 0.3s ease-out;
      }

      .success-message.show {
        display: block;
      }

      .error-message {
        background-color: #f8d7da !important;
        border-color: #f5c6cb !important;
        color: #721c24 !important;
      }

      /* BMI Kart Stilleri */
      .bmi-card {
        margin-top: 2rem;
        background: white;
        border-radius: 15px;
        padding: 1.5rem;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        animation: fadeIn 0.5s ease;
        overflow: hidden;
      }

      .bmi-card h3 {
        font-size: 1.3rem;
        font-weight: 700;
        margin-bottom: 1rem;
        text-align: center;
        color: #2c3e50;
      }

      .bmi-result {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1rem;
      }

      .bmi-value {
        font-size: 2.5rem;
        font-weight: 800;
        color: #1e3c72;
        line-height: 1;
        transition: all 0.5s ease;
        transform: scale(1);
      }

      .bmi-value.animate {
        transform: scale(1.2);
        color: #e74c3c;
      }

      .bmi-category {
        background: #f8f9fa;
        border-radius: 10px;
        padding: 0.5rem 1rem;
        font-weight: 600;
        display: inline-block;
        margin-left: 1rem;
        transition: all 0.5s ease;
        transform: translateX(0);
      }

      .bmi-category.animate {
        transform: translateX(10px);
      }

      .bmi-details {
        text-align: center;
        margin-top: 0.5rem;
        font-size: 0.9rem;
        color: #7f8c8d;
        margin-bottom: 1rem;
      }

      /* BMI Progress Bar */
      .bmi-progress {
        height: 1.25rem;
        margin-top: 1.5rem;
        border-radius: 10px;
        overflow: hidden;
        background: #ecf0f1;
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
        position: relative;
      }

      .bmi-progress-bar {
        height: 100% !important;
        border-radius: 10px;
        background: linear-gradient(
          90deg,
          #2ecc71,
          #f1c40f,
          #e74c3c
        ) !important;
        position: relative;
        width: 0%; /* Başlangıç değeri - JavaScript tarafından değiştirilecek */
        min-width: 0; /* Minimum genişlik 0 olacak */
        will-change: width, background-color; /* Tarayıcıya optimize etme ipucu */
        transition: none !important; /* CSS animasyonlarını devre dışı bırak */
        display: block !important;
        visibility: visible !important;
      }

      .bmi-indicator {
        position: absolute;
        width: 20px;
        height: 20px;
        border-radius: 50%;
        background-color: white;
        border: 3px solid #1e3c72;
        top: 50%;
        transform: translate(-50%, -50%);
        margin-top: -2px;
        z-index: 10;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        left: 0%; /* Başlangıç değeri - JavaScript tarafından değiştirilecek */
        will-change: left, border-color; /* Tarayıcıya optimize etme ipucu */
        transition: none !important; /* CSS animasyonlarını devre dışı bırak */
      }

      .bmi-indicator::after {
        content: attr(data-value);
        position: absolute;
        top: -30px;
        left: 50%;
        transform: translateX(-50%);
        background: #1e3c72;
        color: white;
        padding: 2px 8px;
        border-radius: 5px;
        font-size: 12px;
        opacity: 0;
        transition: opacity 0.3s ease;
        pointer-events: none;
        white-space: nowrap;
      }

      .bmi-indicator:hover::after {
        opacity: 1;
      }

      .bmi-scale {
        display: flex;
        justify-content: space-between;
        margin-top: 0.5rem;
        font-size: 0.8rem;
        color: #7f8c8d;
      }

      .bmi-scale-item {
        position: relative;
        text-align: center;
      }

      .bmi-scale-item::before {
        content: "";
        position: absolute;
        top: -8px;
        left: 50%;
        transform: translateX(-50%);
        width: 1px;
        height: 6px;
        background: #bdc3c7;
      }

      /* Özel BMI Animasyonları */
      @keyframes pulse {
        0%,
        100% {
          transform: scale(1);
        }
        50% {
          transform: scale(1.05);
        }
      }

      .pulse-animation {
        animation: pulse 2s infinite;
      }

      @keyframes slideIn {
        from {
          transform: translateX(-100%);
          opacity: 0;
        }
        to {
          transform: translateX(0);
          opacity: 1;
        }
      }

      .slide-in {
        animation: slideIn 0.8s ease forwards;
      }

      @keyframes fadeScale {
        from {
          opacity: 0;
          transform: scale(0.8);
        }
        to {
          opacity: 1;
          transform: scale(1);
        }
      }

      .fade-scale {
        animation: fadeScale 0.5s ease forwards;
      }

      /* Animations */
      @keyframes fadeIn {
        from {
          opacity: 0;
        }
        to {
          opacity: 1;
        }
      }

      @keyframes scaleIn {
        from {
          transform: scale(0);
        }
        to {
          transform: scale(1);
        }
      }

      @media (max-width: 992px) {
        .profile-wrapper {
          flex-direction: column;
          max-width: 600px;
        }

        .profile-sidebar,
        .profile-container {
          width: 100%;
        }

        .profile-sidebar {
          height: 200px;
          padding: 1.5rem;
        }
      }

      @media (max-width: 576px) {
        .profile-container {
          padding: 2rem;
        }
      }
    </style>
  </head>
  <body>
    <form id="formProfile" runat="server">
      <asp:ScriptManager ID="ScriptManager1" runat="server" />
      <div class="profile-wrapper">
        <div class="profile-sidebar">
          <div class="sidebar-content">
            <div class="sidebar-header">
              <h2>Profil Bilgileri</h2>
              <p>Kisisel bilgilerinizi yonetin ve hedeflerinizi guncelleyin</p>
            </div>

            <div class="sidebar-nav">
              <a href="Program.aspx" class="nav-btn">
                <i class="fas fa-plus-circle"></i> Yeni Program Olustur
              </a>
              <a href="MyProgram.aspx" class="nav-btn">
                <i class="fas fa-list-alt"></i> Programlarimi Goruntule
              </a>
              <a href="Default.aspx" class="nav-btn">
                <i class="fas fa-home"></i> Ana Sayfa
              </a>
            </div>
          </div>
        </div>

        <div class="profile-container">
          <div class="profile-header">
            <h2>Profil Bilgilerimi Guncelle</h2>
            <p>Egzersiz icin gerekli istatistiklerinizi yonetin</p>
          </div>

          <div class="form-group">
            <label class="form-label">Boy (cm)</label>
            <div class="input-wrapper">
              <asp:TextBox
                ID="txtHeight"
                runat="server"
                CssClass="form-control"
                Placeholder="Boyunuzu girin"
              />
              <div class="input-icon">
                <i class="fas fa-ruler-vertical"></i>
              </div>
            </div>
            <asp:RegularExpressionValidator
              ID="revHeight"
              runat="server"
              ControlToValidate="txtHeight"
              ValidationExpression="^\d+$"
              ErrorMessage="Lütfen geçerli bir sayı girin."
              CssClass="validation-error"
              Display="Dynamic"
            />
          </div>

          <div class="form-group">
            <label class="form-label">Kilo (kg)</label>
            <div class="input-wrapper">
              <asp:TextBox
                ID="txtWeight"
                runat="server"
                CssClass="form-control"
                Placeholder="Kilonuzu girin"
              />
              <div class="input-icon">
                <i class="fas fa-weight"></i>
              </div>
            </div>
            <asp:RegularExpressionValidator
              ID="revWeight"
              runat="server"
              ControlToValidate="txtWeight"
              ValidationExpression="^\d+$"
              ErrorMessage="Lütfen geçerli bir sayı girin."
              CssClass="validation-error"
              Display="Dynamic"
            />
          </div>

          <div class="form-group">
            <label class="form-label">Fitness Hedefi</label>
            <div class="input-wrapper">
              <asp:DropDownList
                ID="ddlGoal"
                runat="server"
                CssClass="form-select"
              >
                <asp:ListItem Text="-- Hedef Secin --" Value="" />
                <asp:ListItem Text="Kas Yap" Value="Kas Yap" />
                <asp:ListItem Text="Kilo Ver" Value="Kilo Ver" />
                <asp:ListItem Text="Fit Kal" Value="Fit Kal" />
              </asp:DropDownList>
              <div class="input-icon">
                <i class="fas fa-bullseye"></i>
              </div>
            </div>
            <asp:RequiredFieldValidator
              ID="rfvGoal"
              runat="server"
              ControlToValidate="ddlGoal"
              InitialValue=""
              ErrorMessage="Lutfen bir hedef secin."
              CssClass="validation-error"
              Display="Dynamic"
            />
          </div>

          <asp:Button
            ID="btnUpdate"
            runat="server"
            Text="Bilgilerimi Guncelle"
            OnClick="btnUpdate_Click"
            CssClass="btn btn-update"
          />

          <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="success-message"
          />

          <!-- BMI Kart Bölümü -->
          <asp:Panel ID="pnlBMI" runat="server" CssClass="bmi-card">
            <h3>Vucut Kitle Indeksi (BMI)</h3>

            <div class="bmi-result">
              <div class="bmi-value" id="bmiValue">
                <asp:Literal ID="litBMIValue" runat="server"></asp:Literal>
              </div>
              <asp:Panel
                ID="pnlCategory"
                runat="server"
                CssClass="bmi-category"
                ClientIDMode="Static"
              >
                <asp:Literal ID="litBMICategory" runat="server"></asp:Literal>
              </asp:Panel>
            </div>

            <div class="bmi-details">
              Boy: <asp:Literal ID="litHeight" runat="server"></asp:Literal> cm
              | Kilo:
              <asp:Literal ID="litWeight" runat="server"></asp:Literal> kg
            </div>

            <!-- BMI Çubuğu -->
            <div class="bmi-progress" id="bmiProgress">
              <!-- Progress Bar - Inline style attributu sunucu tarafından ayarlanacak -->
              <asp:Panel
                ID="pnlProgressBar"
                runat="server"
                CssClass="bmi-progress-bar"
                ClientIDMode="Static"
                style="width: 0%; height: 100%"
              ></asp:Panel>

              <!-- BMI Göstergesi -->
              <div class="bmi-indicator" id="bmiIndicator" data-value=""></div>
            </div>

            <div class="bmi-scale">
              <div class="bmi-scale-item">18.5</div>
              <div class="bmi-scale-item">25</div>
              <div class="bmi-scale-item">30</div>
            </div>

            <div class="bmi-scale">
              <div class="bmi-scale-item">Zayif</div>
              <div class="bmi-scale-item">Normal</div>
              <div class="bmi-scale-item">Fazla Kilolu</div>
              <div class="bmi-scale-item">Obez</div>
            </div>
          </asp:Panel>
        </div>
      </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // BMI değerleri için global değişkenler
      var currentBMI = 0;
      var currentBMICategory = "";
      var currentBMIColor = "";
      var currentBMIPosition = 0;

      document.addEventListener("DOMContentLoaded", function () {
        // Sayfa yüklendiğinde server tarafından gelen BMI değerlerini alalım
        currentBMI = parseFloat(
          '<%= CalculatedBMI.ToString("F1").Replace(",", ".") %>'
        );
        currentBMICategory = "<%= BMICategory %>";
        currentBMIColor = "<%= BMIColor %>";
        currentBMIPosition = parseInt("<%= BMIPosition %>");

        console.log("DOM loaded. BMI values:", {
          bmi: currentBMI,
          category: currentBMICategory,
          position: currentBMIPosition,
        });

        const successMessage = document.getElementById(
          "<%= lblMessage.ClientID %>"
        );
        if (successMessage && successMessage.textContent.trim() !== "") {
          successMessage.classList.add("show");

          // 5 saniye sonra mesajı gizle
          setTimeout(function () {
            successMessage.classList.remove("show");
          }, 5000);
        }

        var updateBtn = document.getElementById("<%= btnUpdate.ClientID %>");
        if (updateBtn) {
          updateBtn.onclick = function (e) {
            // Doğrulama kontrollerini kontrol et
            var isValid = true;
            var validators = Page_Validators;

            for (var i = 0; i < validators.length; i++) {
              if (!validators[i].isvalid) {
                isValid = false;
                break;
              }
            }

            if (!isValid) {
              return true; // Normal validasyon hataları gösterilsin
            }

            e.preventDefault();

            Swal.fire({
              title: "Emin misiniz?",
              text: "Degisiklikleri kaydetmek istediginize emin misiniz?",
              icon: "question",
              showCancelButton: true,
              confirmButtonColor: "#3085d6",
              cancelButtonColor: "#d33",
              confirmButtonText: "Evet, guncelle!",
              cancelButtonText: "Vazgec",
            }).then((result) => {
              if (result.isConfirmed) {
                // Doğrudan __doPostBack fonksiyonunu kullanarak ASP.NET postback'i yap
                __doPostBack("<%= btnUpdate.UniqueID %>", "");
              }
            });
            return false;
          };
        }

        // Sayfa yüklendiğinde BMI kartı varsa animasyonu başlat
        const bmiCard = document.getElementById("<%= pnlBMI.ClientID %>");
        if (bmiCard && window.getComputedStyle(bmiCard).display !== "none") {
          console.log("BMI card is visible, animation will start soon.");

          // BMI elementlerini hemen ayarla
          let bmiProgressBar = document.getElementById("pnlProgressBar");
          let bmiIndicator = document.getElementById("bmiIndicator");

          if (bmiProgressBar && currentBMIPosition > 0) {
            console.log(
              "Setting initial BMI progress bar: " + currentBMIPosition + "%"
            );
            bmiProgressBar.style.cssText =
              "width: " +
              currentBMIPosition +
              "% !important; background-color: " +
              currentBMIColor +
              " !important; height: 100% !important; display: block !important; visibility: visible !important; transition: none !important;";
          }

          if (bmiIndicator && currentBMIPosition > 0) {
            bmiIndicator.style.left = currentBMIPosition + "%";
            bmiIndicator.style.borderColor = currentBMIColor;
            bmiIndicator.setAttribute(
              "data-value",
              currentBMI + " - " + currentBMICategory
            );
          }
        }

        // Elementleri doğrudan yakalamayı dene
        updateBMIIndicator();
      });

      // BMI göstergesini güncelle ve animasyonu başlat
      function animateBMI(isUpdate, oldBMI, newBMI) {
        console.log(
          "animateBMI fonksiyonu cagrildi:",
          isUpdate,
          oldBMI,
          newBMI
        );

        // DOM elementlerini al
        var bmiValue = document.getElementById("bmiValue");
        var bmiCategory = document.getElementById("pnlCategory");
        var bmiProgressBar = document.getElementById("pnlProgressBar");
        var bmiIndicator = document.getElementById("bmiIndicator");

        // Global değerleri logla
        console.log("Global BMI degerleri:", {
          currentBMI: currentBMI,
          currentBMICategory: currentBMICategory,
          currentBMIColor: currentBMIColor,
          currentBMIPosition: currentBMIPosition,
        });

        if (!bmiProgressBar || !bmiIndicator) {
          console.error("BMI elementleri bulunamadı!");
          // Elementleri querySelector ile de bulmaya çalış
          if (!bmiProgressBar)
            bmiProgressBar = document.querySelector(".bmi-progress-bar");
          if (!bmiIndicator)
            bmiIndicator = document.querySelector(".bmi-indicator");
          if (!bmiProgressBar || !bmiIndicator) return;
        }

        // Pozisyon belirle - Global değişkenlerden al veya parametrelerden hesapla
        var newPosition = currentBMIPosition;
        var color = currentBMIColor;
        var bmiValueToUse = currentBMI;
        var categoryToUse = currentBMICategory;

        // Eğer animasyon güncelleme ise ve yeni BMI değeri varsa, bu değeri kullan
        if (isUpdate && newBMI > 0) {
          bmiValueToUse = newBMI;
        }

        // Değerler 0 veya boş ise sorun gider
        if (newPosition <= 0 || !color || bmiValueToUse <= 0) {
          console.warn(
            "Deger hatasi tespit edildi, manuel hesaplama yapiliyor..."
          );

          // BMI değerini kullanarak pozisyonu manuel hesapla
          if (bmiValueToUse > 0) {
            // BMI'dan pozisyon hesapla
            if (bmiValueToUse < 15) newPosition = 0;
            else if (bmiValueToUse > 40) newPosition = 100;
            else newPosition = Math.round((bmiValueToUse - 15) * 4);

            // Kategori ve renk kontrolü
            if (bmiValueToUse < 18.5) {
              categoryToUse = "Zayif";
              color = "#f1c40f"; // Sarı
            } else if (bmiValueToUse < 25) {
              categoryToUse = "Normal";
              color = "#2ecc71"; // Yeşil
            } else if (bmiValueToUse < 30) {
              categoryToUse = "Fazla Kilolu";
              color = "#e67e22"; // Turuncu
            } else {
              categoryToUse = "Obez";
              color = "#e74c3c"; // Kırmızı
            }
            console.log(
              "Manuel hesaplama sonucu: Pozisyon =",
              newPosition,
              "Renk =",
              color,
              "BMI =",
              bmiValueToUse,
              "Kategori =",
              categoryToUse
            );
          } else if (oldBMI > 0) {
            // Eğer mevcut BMI yoksa ama eski BMI değeri varsa, onu kullan
            bmiValueToUse = oldBMI;
            if (bmiValueToUse < 15) newPosition = 0;
            else if (bmiValueToUse > 40) newPosition = 100;
            else newPosition = Math.round((bmiValueToUse - 15) * 4);

            // Kategori ve renk kontrolü
            if (bmiValueToUse < 18.5) {
              categoryToUse = "Zayif";
              color = "#f1c40f"; // Sarı
            } else if (bmiValueToUse < 25) {
              categoryToUse = "Normal";
              color = "#2ecc71"; // Yeşil
            } else if (bmiValueToUse < 30) {
              categoryToUse = "Fazla Kilolu";
              color = "#e67e22"; // Turuncu
            } else {
              categoryToUse = "Obez";
              color = "#e74c3c"; // Kırmızı
            }
          }
        }

        console.log(
          "BMI animasyon: Yeni pozisyon =",
          newPosition + "%",
          "Renk =",
          color,
          "BMI =",
          bmiValueToUse,
          "Kategori =",
          categoryToUse
        );

        // Değerleri direkt uygula - !important ile güçlendirilmiş stil
        if (bmiProgressBar) {
          bmiProgressBar.style.cssText =
            "width: " +
            newPosition +
            "% !important; background-color: " +
            color +
            " !important; height: 100% !important; display: block !important; visibility: visible !important; transition: none !important;";

          // Ayrıca setAttribute ile de uygula
          bmiProgressBar.setAttribute(
            "style",
            "width: " +
              newPosition +
              "% !important; background-color: " +
              color +
              " !important; height: 100% !important; display: block !important; visibility: visible !important; transition: none !important;"
          );

          // jQuery ile de uygula
          if (typeof jQuery !== "undefined") {
            try {
              jQuery(bmiProgressBar).css({
                width: newPosition + "%",
                "background-color": color,
                height: "100%",
                display: "block",
                visibility: "visible",
              });
              console.log("jQuery ile stil uygulandı");
            } catch (e) {
              console.error("jQuery hatası:", e);
            }
          }
        }

        if (bmiIndicator) {
          bmiIndicator.style.left = newPosition + "%";
          bmiIndicator.style.borderColor = color;
          bmiIndicator.setAttribute(
            "data-value",
            bmiValueToUse + " - " + categoryToUse
          );
        }

        if (isUpdate && oldBMI !== newBMI && bmiValue && bmiCategory) {
          // Değer değiştiğinde animasyon ekle
          bmiValue.classList.add("animate");
          bmiCategory.classList.add("animate");

          setTimeout(function () {
            bmiValue.classList.remove("animate");
            bmiCategory.classList.remove("animate");
          }, 1000);

          // Pulse animasyonu
          if (bmiIndicator) {
            bmiIndicator.classList.add("pulse-animation");
            setTimeout(function () {
              bmiIndicator.classList.remove("pulse-animation");
            }, 2000);
          }
        }

        // Son bir kontrol
        setTimeout(function () {
          if (
            bmiProgressBar &&
            (bmiProgressBar.offsetWidth === 0 ||
              parseFloat(bmiProgressBar.style.width) < 1)
          ) {
            console.warn(
              "BMI cubugu genisligi hala cok dusuk, tekrar deneniyor"
            );
            bmiProgressBar.style.cssText =
              "width: " +
              newPosition +
              "% !important; background-color: " +
              color +
              " !important; height: 100% !important; display: block !important; visibility: visible !important; transition: none !important;";

            // jQuery ile de dene
            if (typeof jQuery !== "undefined") {
              try {
                jQuery(bmiProgressBar).css({
                  width: newPosition + "%",
                  "background-color": color,
                  height: "100%",
                  display: "block",
                  visibility: "visible",
                });
                console.log("jQuery ile stil uygulandı");
              } catch (e) {
                console.error("jQuery hatası:", e);
              }
            }
          }
        }, 100);
      }

      // BMI göstergesini güncelle
      function updateBMIIndicator() {
        // DOM elementlerini al
        var indicator = document.getElementById("bmiIndicator");
        var progressBar = document.getElementById("pnlProgressBar");

        if (!indicator || !progressBar) {
          console.error("BMI indicator veya progress bar bulunamadı");
          return;
        }

        // Direkt stil uygula
        progressBar.style.width = currentBMIPosition + "%";
        progressBar.style.backgroundColor = currentBMIColor;
        indicator.style.left = currentBMIPosition + "%";
        indicator.style.borderColor = currentBMIColor;

        console.log("BMI degerleri guncellendi: ", {
          position: currentBMIPosition + "%",
          color: currentBMIColor,
          bmi: currentBMI,
        });

        // Tooltip değerini güncelle
        indicator.setAttribute(
          "data-value",
          currentBMI + " - " + currentBMICategory
        );
      }

      // BMI değerine göre skala üzerindeki pozisyonu hesapla (JavaScript versiyonu)
      function calculatePositionOnScale(bmi) {
        // BMI değerini 0-100 arasında bir pozisyona dönüştür
        if (bmi < 15) return 0;
        if (bmi > 40) return 100;

        // 15-40 arası BMI değerlerini 0-100 arasına dönüştür
        return Math.round((bmi - 15) * 4); // Her BMI birimi 4% ilerletir
      }
    </script>
  </body>
</html>
