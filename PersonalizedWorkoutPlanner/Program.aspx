<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Program.aspx.cs"
Inherits="PersonalizedWorkoutPlanner.Program" EnableEventValidation="false" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Antrenman Programı - Kişiselleştirilmiş Egzersiz Planlayıcı</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      :root {
        --primary-color: #1a2f5e;
        --secondary-color: #2e4d9b;
        --accent-color: #4264b7;
        --accent-secondary: #9d4edd;
        --success-color: #34a853;
        --gradient-primary: linear-gradient(
          135deg,
          var(--primary-color) 0%,
          var(--secondary-color) 100%
        );
        --gradient-accent: linear-gradient(
          135deg,
          var(--accent-color) 0%,
          var(--accent-secondary) 60%
        );
        --gradient-special: linear-gradient(
          90deg,
          var(--primary-color),
          var(--secondary-color),
          var(--accent-secondary)
        );
      }

      body {
        background: var(--gradient-accent);
        min-height: 100vh;
        padding: 1.5rem 0;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }

      .program-container {
        background: white;
        padding: 2.5rem;
        border-radius: 20px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2),
          0 10px 25px rgba(0, 0, 0, 0.15);
        width: 98%;
        max-width: 1500px;
        margin: 0 auto;
        position: relative;
        overflow: hidden;
        animation: fadeIn 0.6s ease-out;
      }

      .program-container::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 8px;
        background: var(--gradient-special);
        z-index: 1;
      }

      .program-container::after {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: radial-gradient(
          circle at top right,
          rgba(157, 78, 221, 0.05),
          transparent 60%
        );
        pointer-events: none;
      }

      .program-header {
        text-align: center;
        margin-bottom: 2.5rem;
        padding-bottom: 1.5rem;
        border-bottom: 2px solid #f0f0f0;
        position: relative;
      }

      .program-header::after {
        content: "";
        position: absolute;
        bottom: -2px;
        left: 50%;
        transform: translateX(-50%);
        width: 100px;
        height: 2px;
        background: var(--gradient-special);
      }

      .program-header h2 {
        color: var(--primary-color);
        font-weight: 700;
        margin-bottom: 0.8rem;
        font-size: 2.2rem;
        position: relative;
        display: inline-block;
      }

      .program-header h2::before,
      .program-header h2::after {
        content: "";
        position: absolute;
        width: 10px;
        height: 10px;
        border-radius: 50%;
        background: var(--accent-secondary);
        opacity: 0.6;
        top: 50%;
        transform: translateY(-50%);
      }

      .program-header h2::before {
        left: -25px;
      }

      .program-header h2::after {
        right: -25px;
      }

      .program-header p {
        color: #666;
        font-size: 1.2rem;
      }

      .form-group {
        margin-bottom: 2rem;
      }

      .form-label {
        font-weight: 600;
        color: var(--primary-color);
        margin-bottom: 1rem;
        font-size: 1.1rem;
        display: block;
        position: relative;
        padding-left: 1rem;
      }

      .form-label::before {
        content: "";
        position: absolute;
        left: 0;
        top: 0;
        height: 100%;
        width: 3px;
        background: var(--accent-secondary);
        border-radius: 3px;
      }

      .form-control {
        border-radius: 10px;
        padding: 0.8rem;
        border: 1px solid #ddd;
        transition: all 0.3s ease;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
      }

      .form-control:focus {
        border-color: var(--accent-secondary);
        box-shadow: 0 0 0 0.2rem rgba(157, 78, 221, 0.25);
      }

      .muscle-group-cards {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        margin-bottom: 30px;
      }

      .muscle-card {
        border: 2px solid #e1e8f3;
        border-radius: 15px;
        padding: 0;
        width: calc(33.333% - 14px);
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        background-color: #fff;
        overflow: hidden;
        position: relative;
      }

      .muscle-card:hover {
        border-color: var(--accent-secondary);
        transform: translateY(-7px) scale(1.02);
        box-shadow: 0 10px 25px rgba(157, 78, 221, 0.2);
      }

      .muscle-card.active {
        border-color: var(--accent-secondary);
        background-color: #f9f5fe;
        box-shadow: 0 10px 25px rgba(157, 78, 221, 0.3);
        position: relative;
        transform: translateY(-7px);
      }

      .muscle-card.active::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 5px;
        background: var(--gradient-accent);
        z-index: 5;
        border-radius: 15px 15px 0 0;
      }

      .muscle-card img {
        width: 100%;
        height: 160px;
        object-fit: cover;
        object-position: center;
        margin-bottom: 0;
        transition: all 0.4s ease;
        filter: saturate(0.9);
        max-width: 100%;
        border-radius: 15px 15px 0 0;
      }

      .muscle-card:hover img {
        transform: scale(1.05);
        filter: saturate(1.1);
      }

      .muscle-card h5 {
        color: var(--primary-color);
        margin: 0;
        padding: 15px;
        font-size: 1.1rem;
        font-weight: 600;
        background: #f8fafd;
        border-top: 1px solid #e1e8f3;
        transition: all 0.3s ease;
      }

      .muscle-card:hover h5 {
        color: var(--accent-secondary);
      }

      .workout-cards {
        display: flex;
        flex-wrap: wrap;
        gap: 25px;
        margin-top: 20px;
      }

      .workout-card {
        border: 2px solid #e1e8f3;
        border-radius: 15px;
        overflow: hidden;
        width: calc(33.333% - 17px);
        transition: all 0.3s ease;
        position: relative;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        margin-bottom: 5px;
        background-color: #fff;
      }

      .workout-card:hover {
        transform: translateY(-7px) scale(1.02);
        box-shadow: 0 15px 25px rgba(0, 0, 0, 0.1);
        border-color: #bbd0f0;
      }

      .workout-card-selected {
        border: 3px solid var(--success-color);
        box-shadow: 0 10px 20px rgba(52, 168, 83, 0.2);
      }

      .workout-card-selected::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 5px;
        background: linear-gradient(90deg, var(--success-color), #5cb85c);
        z-index: 5;
        border-radius: 15px 15px 0 0;
      }

      .workout-card img {
        width: 100%;
        height: 220px;
        object-fit: cover;
        object-position: center;
        transition: all 0.4s ease;
        filter: saturate(0.9);
        max-width: 100%;
        border-radius: 15px 15px 0 0;
      }

      .workout-card:hover img {
        transform: scale(1.05);
        filter: saturate(1.1);
      }

      .workout-card-body {
        padding: 20px;
      }

      .workout-card-title {
        font-weight: 700;
        color: var(--primary-color);
        margin-bottom: 10px;
        font-size: 1.1rem;
        transition: all 0.3s ease;
      }

      .workout-card:hover .workout-card-title {
        color: var(--accent-secondary);
      }

      .workout-card-text {
        color: #666;
        font-size: 0.95rem;
        margin-bottom: 15px;
        line-height: 1.5;
      }

      .workout-card-footer {
        background-color: #f8f9fa;
        padding: 15px 20px;
        border-top: 1px solid #ddd;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 1.05rem;
      }

      .workout-card-footer .btn {
        padding: 0.5rem 1.2rem;
        font-size: 1rem;
        font-weight: 600;
      }

      .difficulty-dot {
        height: 14px;
        width: 14px;
        background-color: #e1e8f3;
        border-radius: 50%;
        transition: all 0.2s ease;
        margin: 0 2px;
      }

      .difficulty-dot.active {
        background-color: var(--accent-secondary);
      }

      .select-badge {
        position: absolute;
        top: 15px;
        right: 15px;
        background-color: var(--success-color);
        color: white;
        padding: 8px 12px;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: bold;
        display: none;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
        z-index: 5;
        animation: fadeInScale 0.3s ease-out;
      }

      .workout-list {
        display: none;
      }

      .btn-save {
        background: var(--gradient-accent);
        color: white;
        padding: 1.2rem 2rem;
        border-radius: 15px;
        font-weight: 700;
        font-size: 1.2rem;
        letter-spacing: 0.5px;
        transition: all 0.4s ease;
        width: 100%;
        margin-top: 2.5rem;
        box-shadow: 0 8px 20px rgba(157, 78, 221, 0.3);
        border: none;
        position: relative;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .btn-save::before {
        content: "";
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(
          90deg,
          transparent,
          rgba(255, 255, 255, 0.3),
          transparent
        );
        transition: all 0.6s ease;
      }

      .btn-save:hover {
        background: linear-gradient(
          135deg,
          var(--accent-secondary) 0%,
          var(--accent-color) 100%
        );
        color: white;
        transform: translateY(-5px);
        box-shadow: 0 12px 30px rgba(157, 78, 221, 0.4);
      }

      .btn-save:hover::before {
        left: 100%;
      }

      .btn-save:active {
        transform: translateY(2px);
        box-shadow: 0 5px 10px rgba(157, 78, 221, 0.4);
      }

      .success-message {
        display: none; /* Hide by default */
        color: #155724;
        font-weight: 600;
        text-align: center;
        margin-top: 1.5rem;
        padding: 1.2rem;
        border-radius: 12px;
        background: #d4edda;
        border: 1px solid #c3e6cb;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        font-size: 1.1rem;
        animation: fadeInScale 0.3s ease-out;
      }

      .nav-buttons {
        display: flex;
        justify-content: space-between;
        margin-bottom: 2rem;
      }

      .nav-btn {
        color: var(--primary-color);
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        padding: 0.8rem 1.2rem;
        border-radius: 10px;
        display: flex;
        align-items: center;
        gap: 8px;
        background-color: #f0f7ff;
        border: 1px solid #e1e8f3;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
      }

      .nav-btn:hover {
        color: var(--accent-secondary);
        background-color: #f9f5fe;
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(157, 78, 221, 0.15);
      }

      .workout-difficulty {
        display: flex;
        align-items: center;
        gap: 5px;
      }

      .workout-difficulty .difficulty-dot {
        height: 14px;
        width: 14px;
        background-color: #e1e8f3;
        border-radius: 50%;
        transition: all 0.2s ease;
      }

      .workout-difficulty .difficulty-dot.active {
        background-color: var(--accent-secondary);
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

      @keyframes fadeInScale {
        from {
          opacity: 0;
          transform: scale(0.9);
        }
        to {
          opacity: 1;
          transform: scale(1);
        }
      }

      @keyframes slideIn {
        from {
          transform: translateY(20px);
          opacity: 0;
        }
        to {
          transform: translateY(0);
          opacity: 1;
        }
      }

      .info-card {
        flex: 1;
        background: #f8f9fa;
        border-radius: 15px;
        padding: 20px;
        text-align: center;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        border: 1px solid #e1e8f3;
        transition: all 0.4s ease;
        animation: slideIn 0.6s ease-out forwards;
        animation-delay: calc(var(--card-index) * 0.15s);
        opacity: 0;
        transform: translateY(20px);
      }

      .info-card:hover {
        background: #f9f5fe;
        transform: translateY(-5px);
        box-shadow: 0 12px 25px rgba(157, 78, 221, 0.15);
        border-color: #e1d8eb;
      }

      .info-card-icon {
        font-size: 2.2rem;
        color: var(--accent-secondary);
        margin-bottom: 15px;
        transition: all 0.4s ease;
      }

      .info-card:hover .info-card-icon {
        transform: scale(1.1);
        color: var(--primary-color);
      }

      .info-card-title {
        font-weight: 600;
        color: var(--primary-color);
        margin-bottom: 10px;
        font-size: 1.2rem;
      }

      .info-card-text {
        color: #666;
        font-size: 0.95rem;
        line-height: 1.5;
      }

      .program-info-cards {
        display: flex;
        justify-content: space-between;
        margin-bottom: 2.5rem;
        gap: 25px;
      }

      /* Haftanın Günleri için özel stiller */
      .weekday-container {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        margin-top: 15px;
      }

      .weekday-item {
        position: relative;
        transition: all 0.3s ease;
        flex: 1;
        min-width: 120px;
      }

      .weekday-checkbox {
        position: absolute;
        opacity: 0;
        width: 0;
        height: 0;
      }

      .weekday-label {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 60px;
        border-radius: 12px;
        border: 2px solid #e1e8f3;
        background-color: #f8fafd;
        color: var(--primary-color);
        font-weight: 600;
        transition: all 0.3s ease;
        cursor: pointer;
        font-size: 1rem;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        user-select: none;
        padding: 10px;
      }

      .weekday-checkbox:checked + .weekday-label {
        background: var(--gradient-accent);
        color: white;
        border-color: transparent;
        box-shadow: 0 8px 15px rgba(157, 78, 221, 0.25);
        transform: translateY(-3px);
      }

      .weekday-checkbox:focus + .weekday-label {
        box-shadow: 0 0 0 2px rgba(157, 78, 221, 0.3), 0 8px 15px rgba(157, 78, 221, 0.25);
      }

      .weekday-label:hover {
        transform: translateY(-3px);
        border-color: #bcd0f7;
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
      }
      
      /* Style for active day state */
      .weekday-label.active-day {
        background: var(--gradient-accent);
        color: white;
        border-color: transparent;
        box-shadow: 0 8px 15px rgba(157, 78, 221, 0.25);
        transform: translateY(-3px);
      }

      .weekday-label .day-abbr {
        display: none;
      }

      .weekday-label .day-full {
        display: block;
        font-size: 1rem;
        font-weight: 600;
      }

      @media (max-width: 992px) {
        .weekday-container {
          gap: 10px;
        }
        
        .weekday-item {
          min-width: 110px;
        }
      }

      @media (max-width: 768px) {
        .weekday-container {
          gap: 8px;
        }
        
        .weekday-item {
          min-width: 90px;
        }
      }

      @media (max-width: 576px) {
        .weekday-container {
          gap: 6px;
        }
        
        .weekday-item {
          min-width: 30%;
          margin-bottom: 8px;
        }
        
        .weekday-label {
          height: 50px;
          padding: 5px;
        }
        
        .weekday-label .day-full {
          font-size: 0.9rem;
        }
      }

      @media (max-width: 992px) {
        .muscle-card {
          width: calc(50% - 10px);
        }
        .workout-card {
          width: calc(50% - 12.5px);
        }
        .program-header h2 {
          font-size: 1.8rem;
        }
      }
      @media (max-width: 576px) {
        .muscle-card,
        .workout-card {
          width: 100%;
        }
        .program-container {
          padding: 1.5rem;
          width: 98%;
        }
        .nav-buttons {
          flex-direction: column;
          gap: 10px;
        }
        .program-info-cards {
          flex-direction: column;
        }
      }
    </style>
  </head>
  <body>
    <form id="form1" runat="server">
      <div class="program-container">
        <div class="nav-buttons">
          <a href="MyProgram.aspx" class="nav-btn"
            ><i class="fas fa-arrow-left"></i> Programlarım</a
          >
          <a href="Default.aspx" class="nav-btn"
            >Ana Sayfa <i class="fas fa-home"></i
          ></a>
        </div>

        <div class="program-header">
          <h2>Antrenman Programı Oluştur</h2>
          <p>Hedeflerinize uygun kas grubu ve egzersizleri seçin</p>
        </div>

        <!-- Program info cards -->
        <div class="program-info-cards">
          <div class="info-card" style="--card-index: 0">
            <div class="info-card-icon">
              <i class="fas fa-dumbbell"></i>
            </div>
            <h3 class="info-card-title">Doğru Kas Grubu</h3>
            <p class="info-card-text">
              Hedeflerinize uygun kas grupları seçerek kişiselleştirilmiş
              antrenman programı oluşturun.
            </p>
          </div>

          <div class="info-card" style="--card-index: 1">
            <div class="info-card-icon">
              <i class="fas fa-chart-line"></i>
            </div>
            <h3 class="info-card-title">İlerleme Takibi</h3>
            <p class="info-card-text">
              Oluşturduğunuz programlar ile gelişiminizi adım adım takip edin.
            </p>
          </div>

          <div class="info-card" style="--card-index: 2">
            <div class="info-card-icon">
              <i class="fas fa-award"></i>
            </div>
            <h3 class="info-card-title">Profesyonel Egzersizler</h3>
            <p class="info-card-text">
              Uzman antrenörler tarafından belirlenen etkili egzersizler ile
              hedefinize ulaşın.
            </p>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label">Kas Grubu Seçin</label>
          <div class="muscle-group-cards">
            <div class="muscle-card" data-value="Göğüs">
              <img
                src="https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?q=80&w=1170&auto=format&fit=crop"
                alt="Göğüs Antrenmanı"
              />
              <h5>Göğüs</h5>
            </div>
            <div class="muscle-card" data-value="Bacak">
              <img
                src="https://images.unsplash.com/photo-1574680178050-55c6a6a96e0a?q=80&w=1169&auto=format&fit=crop"
                alt="Bacak Antrenmanı"
              />
              <h5>Bacak</h5>
            </div>
            <div class="muscle-card" data-value="Sırt">
              <img
                src="https://images.unsplash.com/photo-1599058917765-a780eda07a3e?q=80&w=1169&auto=format&fit=crop"
                alt="Sırt Antrenmanı"
              />
              <h5>Sırt</h5>
            </div>
            <div class="muscle-card" data-value="Kardiyo">
              <img
                src="https://cdn.pixabay.com/photo/2014/11/11/15/24/gym-526995_1280.jpg"
                alt="Kardiyo Antrenmanı"
              />
              <h5>Kardiyo</h5>
            </div>
            <div class="muscle-card" data-value="Kol">
              <img
                src="https://cdn.pixabay.com/photo/2015/07/02/10/22/training-828726_1280.jpg"
                alt="Kol Antrenmanı"
              />
              <h5>Kol</h5>
            </div>
            <div class="muscle-card" data-value="Omuz">
              <img
                src="https://cdn.pixabay.com/photo/2014/11/17/13/17/crossfit-534615_1280.jpg"
                alt="Omuz Antrenmanı"
              />
              <h5>Omuz</h5>
            </div>
          </div>

          <asp:DropDownList
            ID="ddlMuscleGroup"
            runat="server"
            CssClass="form-control d-none"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlMuscleGroup_SelectedIndexChanged"
          >
            <asp:ListItem Text="-- Kas Grubu Seçin --" Value="" />
            <asp:ListItem Text="Göğüs" Value="Göğüs" />
            <asp:ListItem Text="Bacak" Value="Bacak" />
            <asp:ListItem Text="Sırt" Value="Sırt" />
            <asp:ListItem Text="Kardiyo" Value="Kardiyo" />
            <asp:ListItem Text="Kol" Value="Kol" />
            <asp:ListItem Text="Omuz" Value="Omuz" />
          </asp:DropDownList>
        </div>

        <div class="form-group">
          <label class="form-label">Haftanın Günleri <small>(Birden fazla gün seçebilirsiniz)</small></label>
          <div class="weekday-container">
            <div class="weekday-item">
              <asp:CheckBox 
                ID="chkPazartesi" 
                runat="server" 
                CssClass="weekday-checkbox" 
              />
              <label class="weekday-label" for="<%= chkPazartesi.ClientID %>">
                <span class="day-abbr">Pzt</span>
                <span class="day-full">Pazartesi</span>
              </label>
            </div>
            
            <div class="weekday-item">
              <asp:CheckBox 
                ID="chkSali" 
                runat="server" 
                CssClass="weekday-checkbox" 
              />
              <label class="weekday-label" for="<%= chkSali.ClientID %>">
                <span class="day-abbr">Salı</span>
                <span class="day-full">Salı</span>
              </label>
            </div>
            
            <div class="weekday-item">
              <asp:CheckBox 
                ID="chkCarsamba" 
                runat="server" 
                CssClass="weekday-checkbox" 
              />
              <label class="weekday-label" for="<%= chkCarsamba.ClientID %>">
                <span class="day-abbr">Çarş</span>
                <span class="day-full">Çarşamba</span>
              </label>
            </div>
            
            <div class="weekday-item">
              <asp:CheckBox 
                ID="chkPersembe" 
                runat="server" 
                CssClass="weekday-checkbox" 
              />
              <label class="weekday-label" for="<%= chkPersembe.ClientID %>">
                <span class="day-abbr">Perş</span>
                <span class="day-full">Perşembe</span>
              </label>
            </div>
            
            <div class="weekday-item">
              <asp:CheckBox 
                ID="chkCuma" 
                runat="server" 
                CssClass="weekday-checkbox" 
              />
              <label class="weekday-label" for="<%= chkCuma.ClientID %>">
                <span class="day-abbr">Cuma</span>
                <span class="day-full">Cuma</span>
              </label>
            </div>
            
            <div class="weekday-item">
              <asp:CheckBox 
                ID="chkCumartesi" 
                runat="server" 
                CssClass="weekday-checkbox" 
              />
              <label class="weekday-label" for="<%= chkCumartesi.ClientID %>">
                <span class="day-abbr">Cmt</span>
                <span class="day-full">Cumartesi</span>
              </label>
            </div>
            
            <div class="weekday-item">
              <asp:CheckBox 
                ID="chkPazar" 
                runat="server" 
                CssClass="weekday-checkbox" 
              />
              <label class="weekday-label" for="<%= chkPazar.ClientID %>">
                <span class="day-abbr">Pzr</span>
                <span class="day-full">Pazar</span>
              </label>
            </div>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label"
            >Egzersizler <small>(Birden fazla seçebilirsiniz)</small></label
          >

          <div id="workoutCardsContainer" class="workout-cards">
            <!-- Egzersiz kartları JavaScript ile eklenecek -->
          </div>

          <div class="workout-list">
            <asp:ListBox
              ID="lstWorkouts"
              runat="server"
              CssClass="form-control"
              SelectionMode="Multiple"
              Height="200px"
            />
          </div>
        </div>

        <asp:Button
          ID="btnSave"
          runat="server"
          Text="Programı Kaydet"
          OnClick="btnSave_Click"
          CssClass="btn btn-save"
        />

        <asp:Label ID="lblMessage" runat="server" CssClass="success-message" />
      </div>
    </form>

    <!-- Egzersiz Görsel Modal -->
    <div class="modal fade" id="exerciseImageModal" tabindex="-1" aria-labelledby="exerciseImageModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exerciseImageModalLabel">Egzersiz Detayı</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
          </div>
          <div class="modal-body text-center">
            <img id="modalExerciseImage" class="img-fluid rounded" src="" alt="Egzersiz Görseli" style="max-height: 70vh; width: auto;" />
            <h4 id="modalExerciseTitle" class="mt-3 mb-2"></h4>
            <p id="modalExerciseDescription" class="text-muted"></p>
            <div class="mt-3">
              <span class="me-2">Zorluk:</span>
              <div id="modalDifficultyDots" class="d-inline-block">
                <div class="difficulty-dot d-inline-block"></div>
                <div class="difficulty-dot d-inline-block"></div>
                <div class="difficulty-dot d-inline-block"></div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
      // Server'dan gelen JSON verisini al
      let workoutsByMuscleGroup = {};
      try {
        const jsonData = <%= WorkoutPlansJson %>;
        workoutsByMuscleGroup = jsonData;
        console.log('JSON parse başarılı:', workoutsByMuscleGroup);
      } catch (e) {
        console.error('JSON parse hatası:', e);
        workoutsByMuscleGroup = {
          "Göğüs": ["Bench Press", "Incline Dumbbell Press", "Push-up", "Dumbbell Fly", "Cable Crossover", "Chest Dip"],
          "Bacak": ["Squat", "Lunge", "Leg Press", "Leg Extension", "Hamstring Curl", "Calf Raise"],
          "Sırt": ["Deadlift", "Lat Pulldown", "Barbell Row", "Pull-up", "T-Bar Row"],
          "Kardiyo": ["HIIT", "Burpee"],
          "Kol": ["Preacher Curl"],
          "Omuz": ["Shoulder Press", "Reverse Fly", "Face Pull", "Upright Row", "Arnold Press"]
        };
      }

      // Egzersiz detayları
      const workoutDetails = {
        // Göğüs hareketleri
        "Bench Press": {
          image: "https://uk.gymshark.com/_next/image?url=https%3A%2F%2Fimages.ctfassets.net%2F8urtyqugdt2l%2F2bMyO0jZaRJjfRptw60iwG%2F17c391156dd01ae6920c672cc2744fb1%2Fdesktop-bench-press.jpg&w=3840&q=85",
          description: "Göğüs kaslarını çalıştıran temel bir egzersiz. Barbell veya dumbbell ile yapılabilir.",
          difficulty: 3
        },
        "Incline Dumbbell Press": {
          image: "https://www.dmoose.com/cdn/shop/articles/1_8c4ca767-1b7d-4981-9c20-c7d0b744dca5.jpg?v=1648733684",
          description: "Üst göğüs kaslarını hedefleyen bir egzersiz. Eğimli bir bench üzerinde yapılır.",
          difficulty: 3
        },
        "Push-up": {
          image: "https://www.fitnesseducation.edu.au/wp-content/uploads/2020/10/Pushups.jpg",
          description: "Vücut ağırlığı ile yapılan, göğüs, omuz ve triceps kaslarını çalıştıran temel bir egzersiz.",
          difficulty: 2
        },
        "Dumbbell Fly": {
          image: "https://swolverine.com/cdn/shop/articles/Dumbbell_Chest_Fly_825bd98f-7e67-4b98-ba86-3db39e835290_600x600_crop_center.jpg?v=1739510458",
          description: "Göğüs kaslarının dış kısmını hedefleyen izole bir egzersiz.",
          difficulty: 2
        },
        "Cable Crossover": {
          image: "https://www.macfit.com/wp-content/uploads/2024/11/cable-crossover-egzersizi-nasil-yapilir.jpg",
          description: "Göğüs kaslarının iç kısmını çalıştıran, kablolu bir makinede yapılan egzersiz.",
          difficulty: 2
        },
        "Chest Dip": {
          image: "https://cdn.muscleandstrength.com/sites/default/files/chest-dip.jpg",
          description: "Göğüs ve triceps kaslarını çalıştıran, paralel bar üzerinde yapılan bir egzersiz.",
          difficulty: 3
        },
        "Decline Bench Press": {
          image: "Images/Exercises/Göğüs/decline-bench-press.jpg",
          description: "Alt göğüs kaslarını çalıştıran bir bench press varyasyonu.",
          difficulty: 3
        },
        "Machine Chest Press": {
          image: "Images/Exercises/Göğüs/machine-chest-press.jpg",
          description: "Göğüs kaslarını çalıştıran makine egzersizi.",
          difficulty: 2
        },
        "Pec Deck Fly": {
          image: "Images/Exercises/Göğüs/pec-deck-fly.jpg",
          description: "Göğüs kaslarını izole eden makine egzersizi.",
          difficulty: 2
        },
        "Incline Cable Fly": {
          image: "Images/Exercises/Göğüs/incline-cable-fly.jpg",
          description: "Üst göğüs kaslarını hedefleyen kablo egzersizi.",
          difficulty: 2
        },
        "Smith Machine Bench Press": {
          image: "Images/Exercises/Göğüs/smith-machine-bench-press.jpg",
          description: "Smith makinesi kullanılarak yapılan bench press.",
          difficulty: 3
        },
        "Wide Grip Push-up": {
          image: "Images/Exercises/Göğüs/wide-grip-push-up.jpg",
          description: "Göğüs kaslarının dış kısımlarını daha fazla hedefleyen şınav varyasyonu.",
          difficulty: 2
        },
        "Diamond Push-up": {
          image: "Images/Exercises/Göğüs/diamond-push-up.jpg",
          description: "Triceps ve iç göğüs kaslarını vurgulayan şınav varyasyonu.",
          difficulty: 3
        },
        "Medicine Ball Push-up": {
          image: "Images/Exercises/Göğüs/medicine-ball-push-up.jpg",
          description: "Denge ve güç geliştiren, medicine ball üzerinde yapılan şınav.",
          difficulty: 3
        },
        "Resistance Band Chest Press": {
          image: "Images/Exercises/Göğüs/resistance-band-chest-press.jpg",
          description: "Direnç bandı kullanarak göğüs kaslarını çalıştıran egzersiz.",
          difficulty: 2
        },
        
        // Bacak hareketleri
        "Squat": {
          image: "https://www.fizyodemi.com/wp-content/uploads/2024/07/squat-kinetik-ve-kinematigi-egzersiz-performansinda-kullanilisi-1556610860.jpg",
          description: "Bacak kaslarını çalıştıran temel bir egzersiz. Barbell veya vücut ağırlığı ile yapılabilir.",
          difficulty: 4
        },
        "Lunge": {
          image: "https://hips.hearstapps.com/hmg-prod/images/walking-lunge-6401e3ab937d2.jpg",
          description: "Bacak kaslarını dengeli bir şekilde çalıştıran, tek bacak üzerinde yapılan bir egzersiz.",
          difficulty: 2
        },
        "Leg Press": {
          image: "https://image.hurimg.com/i/hurriyet/75/0x0/61543cfc4e3fe11708b330fd.jpg",
          description: "Bacak kaslarını çalıştıran, makinede yapılan bir egzersiz.",
          difficulty: 3
        },
        "Leg Extension": {
          image: "https://149874912.v2.pressablecdn.com/wp-content/uploads/2024/08/leg-press-vs-leg-extension-for-quads.jpg",
          description: "Quadriceps kaslarını izole olarak çalıştıran bir makine egzersizi.",
          difficulty: 2
        },
        "Hamstring Curl": {
          image: "https://ik.imagekit.io/02fmeo4exvw/exercise-library/large/153-2.jpg",
          description: "Hamstring kaslarını izole olarak çalıştıran bir makine egzersizi.",
          difficulty: 2
        },
        "Calf Raise": {
          image: "Images/Exercises/Bacak/calf-raise.jpg",
          description: "Baldır kaslarını çalıştıran temel bir egzersiz.",
          difficulty: 1
        },
        "Romanian Deadlift": {
          image: "Images/Exercises/Bacak/romanian-deadlift.jpg",
          description: "Hamstring ve kalça kaslarını çalıştıran deadlift varyasyonu.",
          difficulty: 3
        },
        "Bulgarian Split Squat": {
          image: "Images/Exercises/Bacak/bulgarian-split-squat.jpg",
          description: "Tek bacak squat varyasyonu, quadriceps ve gluteus kaslarını güçlendirir.",
          difficulty: 3
        },
        "Hip Thrust": {
          image: "Images/Exercises/Bacak/hip-thrust.jpg",
          description: "Kalça kaslarını güçlendiren bir egzersiz.",
          difficulty: 3
        },
        "Step Up": {
          image: "Images/Exercises/Bacak/step-up.jpg",
          description: "Yükseltilmiş bir platform üzerine adım atarak yapılan bacak egzersizi.",
          difficulty: 2
        },
        "Goblet Squat": {
          image: "Images/Exercises/Bacak/goblet-squad.jpg",
          description: "Dumbbell veya kettlebell ile yapılan squat varyasyonu.",
          difficulty: 2
        },
        "Front Squat": {
          image: "Images/Exercises/Bacak/front-squat.jpg",
          description: "Ön uyluk ve core kaslarını güçlendiren squat varyasyonu.",
          difficulty: 3
        },
        "Hack Squat": {
          image: "Images/Exercises/Bacak/hack-squat.jpg",
          description: "Quadriceps kaslarını geliştirmek için makine üzerinde yapılan squat varyasyonu.",
          difficulty: 3
        },
        "Leg Press Calf Raise": {
          image: "Images/Exercises/Bacak/leg-press-calf-raise.jpg",
          description: "Leg press makinesinde baldır kaslarını çalıştıran egzersiz.",
          difficulty: 2
        },
        "Seated Calf Raise": {
          image: "Images/Exercises/Bacak/seated-calf-raise.jpg",
          description: "Baldırın soleus kasını izole eden oturarak yapılan egzersiz.",
          difficulty: 2
        },
        "Walking Lunge": {
          image: "Images/Exercises/Bacak/walking-lunge.jpg",
          description: "İleriye doğru yürüyerek yapılan, alt vücudu çalıştıran lunge varyasyonu.",
          difficulty: 3
        },
        "Box Jump": {
          image: "Images/Exercises/Bacak/box-jump.jpg",
          description: "Patlayıcı güç ve koordinasyon geliştiren pliometrik egzersiz.",
          difficulty: 3
        },
        "Glute Bridge": {
          image: "Images/Exercises/Bacak/glute-bridge.jpg",
          description: "Kalça kaslarını güçlendiren egzersiz.",
          difficulty: 2
        },
        
        // Sırt hareketleri
        "Deadlift": {
          image: "https://hips.hearstapps.com/hmg-prod/images/deadlift-1651142430.jpg?crop=1.00xw:0.845xh;0,0.0510xh&resize=980:*",
          description: "Sırt, bacak ve core kaslarını çalıştıran kompleks bir egzersiz.",
          difficulty: 4
        },
        "Lat Pulldown": {
          image: "https://i0.wp.com/www.muscleandfitness.com/wp-content/uploads/2020/01/widegrippulldown2.jpg?quality=86&strip=all",
          description: "Sırt kaslarını çalıştıran, kablolu bir makinede yapılan egzersiz.",
          difficulty: 2
        },
        "Barbell Row": {
          image: "https://images.ctfassets.net/8urtyqugdt2l/3MfxpieTD4IprS0zIktKZl/c94589eb28081d5ed3086e21cd5faeb7/desktop-barbell-row.jpg",
          description: "Sırt kaslarını çalıştıran, barbell ile yapılan bir egzersiz.",
          difficulty: 3
        },
        "Pull-up": {
          image: "https://shreddedbrothers.com/uploads/blogs/ckeditor/files/pull-up-2.jpg",
          description: "Sırt ve biceps kaslarını çalıştıran, vücut ağırlığı ile yapılan bir egzersiz.",
          difficulty: 4
        },
        "T-Bar Row": {
          image: "https://cdn.muscleandstrength.com/sites/default/files/t-bar-row.jpg",
          description: "Sırt kaslarını çalıştıran, özel bir makinede yapılan egzersiz.",
          difficulty: 3
        },
        "Face Pull": {
          image: "Images/Exercises/Sırt/face-pull.jpg",
          description: "Omuz arka kaslarını ve rotator cuff'ı çalıştıran kablo egzersizi.",
          difficulty: 2
        },
        "Seated Cable Row": {
          image: "Images/Exercises/Sırt/seated-cable-row.jpg",
          description: "Orta sırt kaslarını çalıştıran kablo egzersizi.",
          difficulty: 2
        },
        "Single Arm Dumbbell Row": {
          image: "Images/Exercises/Sırt/single-arm-dumbbell-row.jpg",
          description: "Tek kol ile yapılan, lat ve orta sırt kaslarını hedefleyen egzersiz.",
          difficulty: 2
        },
        "Bent Over Row": {
          image: "Images/Exercises/Sırt/bent-over-row.jpg",
          description: "Eğilerek yapılan, sırt genişliğini geliştiren row hareketi.",
          difficulty: 3
        },
        "Chin-up": {
          image: "Images/Exercises/Sırt/chin-up.jpg",
          description: "Biceps ve sırt kaslarını çalıştıran vücut ağırlığı egzersizi.",
          difficulty: 3
        },
        "Wide Grip Pull-up": {
          image: "Images/Exercises/Sırt/wide-grip-pulldown.jpg",
          description: "Geniş tutuşla yapılan, lat kaslarını daha fazla hedefleyen pull-up varyasyonu.",
          difficulty: 4
        },
        "Close Grip Lat Pulldown": {
          image: "Images/Exercises/Sırt/close-grip-lat-pull-down.jpg",
          description: "Dar tutuşla yapılan lat pulldown, orta sırt kaslarını daha fazla çalıştırır.",
          difficulty: 2
        },
        "Straight Arm Pulldown": {
          image: "Images/Exercises/Sırt/straight-arm-pulldown.jpg",
          description: "Latissimus dorsi kaslarını izole eden kablo egzersizi.",
          difficulty: 2
        },
        "Machine Row": {
          image: "Images/Exercises/Sırt/machine-row.jpg",
          description: "Sırt kaslarını çalıştıran oturarak yapılan makine egzersizi.",
          difficulty: 2
        },
        "Inverted Row": {
          image: "Images/Exercises/Sırt/inverted-row.jpg",
          description: "Vücut ağırlığı ile yapılan, üst sırt ve orta trapez kaslarını çalıştıran egzersiz.",
          difficulty: 3
        },
        "Rack Pull": {
          image: "Images/Exercises/Sırt/rack-pull.jpg",
          description: "Deadlift varyasyonu, üst sırt ve trapez kaslarını hedefler.",
          difficulty: 3
        },
        "Sırt Reverse Fly": {
          image: "Images/Exercises/Sırt/reverse-fly.jpg",
          description: "Arka omuz ve üst sırt kaslarını çalıştıran egzersiz.",
          difficulty: 2
        },
        
        // Kardiyo hareketleri
        "Koşu Bandı": {
          image: "Images/Exercises/Kardiyo/kosu-bandi.jpg",
          description: "Kapalı ortamda koşu için uygun kardiyovasküler egzersiz.",
          difficulty: 2
        },
        "Bisiklet": {
          image: "Images/Exercises/Kardiyo/bisiklet.jpg",
          description: "Bacak kaslarını çalıştıran ve eklemlere minimum yük bindiren kardiyovasküler egzersiz.",
          difficulty: 2
        },
        "İp Atlama": {
          image: "Images/Exercises/Kardiyo/ip-atlama.jpg",
          description: "Koordinasyon ve dayanıklılık geliştiren, yağ yakımı için etkili egzersiz.",
          difficulty: 2
        },
        "Eliptik Bisiklet": {
          image: "Images/Exercises/Kardiyo/eliptik-bisiklet.jpg",
          description: "Eklem dostu, tam vücut kardiyovasküler çalışması sunan makine.",
          difficulty: 2
        },
        "Kürek Çekme": {
          image: "Images/Exercises/Kardiyo/kurek-cekme.jpg",
          description: "Hem üst hem alt vücudu çalıştıran, yağ yakımı için etkili egzersiz makinesi.",
          difficulty: 3
        },
        "Yüzme": {
          image: "Images/Exercises/Kardiyo/yuzme.jpg",
          description: "Tüm vücudu çalıştıran, eklemlere minimum yük bindiren kardiyovasküler egzersiz.",
          difficulty: 3
        },
        "Stair Master": {
          image: "Images/Exercises/Kardiyo/stairmaster.jpg",
          description: "Merdiven tırmanışı simüle eden, alt vücut odaklı kardiyovasküler egzersiz makinesi.",
          difficulty: 3
        },
        "Mountain Climber": {
          image: "Images/Exercises/Kardiyo/mountain-climber.jpg",
          description: "Core ve kardiyovasküler sistemi çalıştıran dinamik egzersiz.",
          difficulty: 2
        },
        "Jumping Jack": {
          image: "Images/Exercises/Kardiyo/jumping-jack.jpg",
          description: "Kardiyovasküler kapasiteyi artıran, kollar ve bacakların koordinasyonunu sağlayan egzersiz.",
          difficulty: 1
        },
        "High Knees": {
          image: "Images/Exercises/Kardiyo/high-knees.jpg",
          description: "Yerinde koşu hareketi, kardiyovasküler dayanıklılığı artırır ve core kaslarını çalıştırır.",
          difficulty: 2
        },
        "Battle Ropes": {
          image: "Images/Exercises/Kardiyo/battle-ropes.jpg",
          description: "Üst vücut güç ve dayanıklılığını geliştiren yüksek yoğunluklu egzersiz.",
          difficulty: 3
        },
        "Assault Bike": {
          image: "Images/Exercises/Kardiyo/assault-bike.jpg",
          description: "Kol ve bacakları birlikte çalıştıran, yüksek yoğunluklu kardiyovasküler egzersiz bisikleti.",
          difficulty: 4
        },
        
        // Kol hareketleri
        "Preacher Curl": {
          image: "Images/Exercises/Kol/concentration-curl.jpg",
          description: "Biceps kaslarını izole olarak çalıştıran bir egzersiz.",
          difficulty: 2
        },
        "Barbell Curl": {
          image: "Images/Exercises/Kol/bicep-curl.jpg",
          description: "Biceps kaslarını çalıştıran temel egzersiz.",
          difficulty: 2
        },
        "Hammer Curl": {
          image: "Images/Exercises/Kol/hammer-curl.jpg",
          description: "Biceps brachialis ve önkol kaslarını hedefleyen curl varyasyonu.",
          difficulty: 2
        },
        "Triceps Pushdown": {
          image: "Images/Exercises/Kol/rope-pushdown.jpg",
          description: "Triceps kaslarını çalıştıran kablo egzersizi.",
          difficulty: 2
        },
        "Skull Crusher": {
          image: "Images/Exercises/Kol/skull-crusher.jpg",
          description: "Lying triceps extension olarak da bilinen, triceps kaslarını geliştiren egzersiz.",
          difficulty: 3
        },
        "Concentration Curl": {
          image: "Images/Exercises/Kol/concentration-curl.jpg",
          description: "Biceps kasını izole eden, oturarak yapılan bir egzersiz.",
          difficulty: 2
        },
        "Dips": {
          image: "Images/Exercises/Kol/dips.jpg",
          description: "Göğüs, omuz ve triceps kaslarını çalıştıran bileşik bir hareket.",
          difficulty: 3
        },
        "Overhead Tricep Extension": {
          image: "Images/Exercises/Kol/overhead-tricep-extension.jpg",
          description: "Triceps kaslarını geliştiren dumbbell egzersizi.",
          difficulty: 2
        },
        "Rope Pushdown": {
          image: "Images/Exercises/Kol/rope-pushdown.jpg",
          description: "Triceps kaslarını izole eden kablo egzersizi.",
          difficulty: 2
        },
        "Tricep Kickback": {
          image: "Images/Exercises/Kol/tricep-kickback.jpg",
          description: "Triceps kaslarını izole eden, dumbbell ile yapılan egzersiz.",
          difficulty: 2
        },
        "Reverse Curl": {
          image: "Images/Exercises/Kol/reverse-curl.jpg",
          description: "Önkol kaslarını çalıştıran curl varyasyonu.",
          difficulty: 2
        },
        "Spider Curl": {
          image: "Images/Exercises/Kol/spider-curl.jpg",
          description: "Biceps kaslarını maksimum şekilde izole eden, eğimli bench üzerinde yapılan curl varyasyonu.",
          difficulty: 2
        },
        "Incline Dumbbell Curl": {
          image: "Images/Exercises/Kol/incline-dumbbell-curl.jpg",
          description: "Biceps kaslarını farklı açıdan çalıştıran, eğimli bench üzerinde yapılan curl varyasyonu.",
          difficulty: 2
        },
        "21s": {
          image: "Images/Exercises/Kol/21s.jpg",
          description: "Biceps kaslarını yoğun şekilde çalıştıran, parçalı teknik ile yapılan curl çeşidi.",
          difficulty: 3
        },
        "Zottman Curl": {
          image: "Images/Exercises/Kol/zottman-curl.jpg",
          description: "Biceps ve önkol kaslarını birlikte çalıştıran, rotasyonlu curl hareketi.",
          difficulty: 3
        },
        "Bicep Curl": {
          image: "Images/Exercises/Kol/bicep-curl.jpg",
          description: "Biceps kaslarını çalıştıran temel egzersiz.",
          difficulty: 2
        },
        "Cable Curl": {
          image: "Images/Exercises/Kol/cable-curl.jpg",
          description: "Kablo ile yapılan, sürekli direnç sağlayan biceps egzersizi.",
          difficulty: 2
        },
        "Close Grip Bench Press": {
          image: "Images/Exercises/Kol/close-grip-bench-press.jpg",
          description: "Triceps kaslarını geliştiren, dar tutuşla yapılan bench press varyasyonu.",
          difficulty: 3
        },
        
        // Omuz hareketleri
        "Shoulder Press": {
          image: "Images/Exercises/Omuz/shoulder-press.jpg",
          description: "Omuz kaslarını çalıştıran temel bir egzersiz.",
          difficulty: 3
        },
        "Reverse Fly": {
          image: "Images/Exercises/Omuz/reverse-fly.jpg",
          description: "Omuz arka kaslarını çalıştıran bir egzersiz.",
          difficulty: 2
        },
        "Face Pull": {
          image: "Images/Exercises/Omuz/face-pull.jpg",
          description: "Omuz arka kaslarını ve rotator cuff'ı çalıştıran kablo egzersizi.",
          difficulty: 2
        },
        "Upright Row": {
          image: "Images/Exercises/Omuz/upright-row.jpg",
          description: "Omuz ve trapez kaslarını çalıştıran kablo ile yapılan bir egzersiz.",
          difficulty: 2
        },
        "Arnold Press": {
          image: "Images/Exercises/Omuz/arnold-press.jpg",
          description: "Omuz kaslarını farklı açılardan çalıştıran bir egzersiz.",
          difficulty: 3
        },
        "Dumbbell Shrug": {
          image: "Images/Exercises/Omuz/dumbbell-shrug.jpg",
          description: "Trapez kaslarını çalıştıran dumbbell egzersizi.",
          difficulty: 2
        },
        "Lateral Raise": {
          image: "Images/Exercises/Omuz/lateral-raise.jpg",
          description: "Omuz yan deltoid kaslarını geliştiren izolasyon egzersizi.",
          difficulty: 2
        },
        "Front Raise": {
          image: "Images/Exercises/Omuz/front-raise.jpg",
          description: "Ön deltoid kaslarını hedefleyen izolasyon egzersizi.",
          difficulty: 2
        },
        "Military Press": {
          image: "Images/Exercises/Omuz/military-press.jpg",
          description: "Omuz ve üst sırt kaslarını geliştiren temel press hareketi.",
          difficulty: 3
        },
        "Reverse Pec Deck": {
          image: "Images/Exercises/Omuz/reverse-pec-deck.jpg",
          description: "Arka deltoid kaslarını çalıştıran makine egzersizi.",
          difficulty: 2
        },
        "Cable Lateral Raise": {
          image: "Images/Exercises/Omuz/cable-lateral-raise.jpg",
          description: "Kablo ile yapılan, sabit direnç sağlayan lateral raise varyasyonu.",
          difficulty: 2
        },
        "Push Press": {
          image: "Images/Exercises/Omuz/push-press.jpg",
          description: "Bacak gücünden de yararlanarak yapılan patlayıcı omuz press egzersizi.",
          difficulty: 3
        },
        "Plate Front Raise": {
          image: "Images/Exercises/Omuz/plate-front-raise.jpg",
          description: "Ağırlık plakası ile yapılan, ön omuz kaslarını hedefleyen egzersiz.",
          difficulty: 2
        },
        "Landmine Press": {
          image: "Images/Exercises/Omuz/landmine-press.jpg",
          description: "Omuz kaslarını farklı bir açıdan çalıştıran barbell egzersizi.",
          difficulty: 3
        },
        "Cable Upright Row": {
          image: "Images/Exercises/Omuz/cable-upright-row.jpg",
          description: "Omuz ve trapez kaslarını çalıştıran kablo ile yapılan bir egzersiz.",
          difficulty: 2
        }
      };

      // Seçili egzersizleri saklamak için global değişken
      const selectedExercises = {};

      // Kas grubu seçimi
      function selectMuscleGroup(element, value) {
        try {
          // Clear any existing success message
          const successMessage = document.querySelector(".success-message");
          if (successMessage) {
            successMessage.style.display = "none";
          }

          // Önceki seçilen kas grubundaki seçili egzersizleri kaydet
          const previousMuscleGroup = document.getElementById(
            "<%= ddlMuscleGroup.ClientID %>"
          ).value;
          if (previousMuscleGroup) {
            const listBox = document.getElementById(
              "<%= lstWorkouts.ClientID %>"
            );
            selectedExercises[previousMuscleGroup] = [];

            for (let i = 0; i < listBox.options.length; i++) {
              if (listBox.options[i].selected) {
                selectedExercises[previousMuscleGroup].push(
                  listBox.options[i].text
                );
              }
            }
          }

          // Tüm kartlardan active sınıfını kaldır
          document.querySelectorAll(".muscle-card").forEach((card) => {
            card.classList.remove("active");
          });

          // Seçilen karta active sınıfını ekle
          element.classList.add("active");

          // DropDownList'i güncelle
          const dropdown = document.getElementById(
            "<%= ddlMuscleGroup.ClientID %>"
          );
          dropdown.value = value;

          // Hidden field oluştur veya güncelle
          let hiddenField = document.getElementById("hiddenMuscleGroup");
          if (!hiddenField) {
            hiddenField = document.createElement("input");
            hiddenField.type = "hidden";
            hiddenField.id = "hiddenMuscleGroup";
            hiddenField.name = "hiddenMuscleGroup";
            document.getElementById("form1").appendChild(hiddenField);
          }
          hiddenField.value = value;

          // Egzersiz listesini güncelle
          updateWorkoutsList(value);
        } catch (error) {
          console.error("selectMuscleGroup hatası:", error);
        }
      }

      // Sayfa yüklendiğinde çalışacak kodlar
      document.addEventListener("DOMContentLoaded", function () {
        try {
          // Success message kontrolü
          const successMessage = document.querySelector(".success-message");
          if (successMessage && successMessage.textContent.trim() !== "") {
            successMessage.style.display = "block";
            
            // Başarılı kayıt durumunda, haftanın günleri checkbox'larını temizle
            if (successMessage.textContent.indexOf("başarıyla kaydedildi") !== -1) {
              var checkboxes = document.querySelectorAll('input[type="checkbox"]');
              for (var i = 0; i < checkboxes.length; i++) {
                var checkbox = checkboxes[i];
                if (checkbox.id && checkbox.id.indexOf('chk') === 0) {
                  checkbox.checked = false;
                }
              }
              console.log("Haftanın günleri checkbox'ları sıfırlandı");
            }
            
            setTimeout(function () {
              successMessage.style.display = "none";
            }, 5000);
          }

          // Workouts listbox'ı doldur
          populateWorkoutsListBox();

          // Kas grubu kartlarına click event listener ekle
          document.querySelectorAll(".muscle-card").forEach((card) => {
            card.addEventListener("click", function () {
              const value = this.getAttribute("data-value");
              selectMuscleGroup(this, value);
            });
          });
          
          // Haftanın günleri için tıklama olayları ekle
          setupWeekdayButtons();
          
        } catch (error) {
          console.error("DOMContentLoaded hatası:", error);
        }
      });
      
      // Haftanın günleri butonları için işlevsellik
      function setupWeekdayButtons() {
        // Tüm gün etiketlerine tıklama olayı ekle
        document.querySelectorAll(".weekday-label").forEach(function(label) {
          label.addEventListener("click", function(e) {
            // Label'a tıklandığında, ilgili checkbox'ı bul
            const checkboxId = this.getAttribute("for");
            const checkbox = document.getElementById(checkboxId);
            
            if (checkbox) {
              // Checkbox durumunu değiştir (çoklu seçim için toggle)
              checkbox.checked = !checkbox.checked;
              
              // Seçili güne göre görsel stil değişikliği
              if (checkbox.checked) {
                this.style.background = "var(--gradient-accent)";
                this.style.color = "white";
                this.style.borderColor = "transparent";
                this.style.boxShadow = "0 8px 15px rgba(157, 78, 221, 0.25)";
                this.style.transform = "translateY(-3px)";
              } else {
                this.style.background = "#f8fafd";
                this.style.color = "var(--primary-color)";
                this.style.borderColor = "#e1e8f3";
                this.style.boxShadow = "0 4px 10px rgba(0, 0, 0, 0.05)";
                this.style.transform = "none";
              }
            }
            
            // Default davranışı engelle
            e.preventDefault();
          });
        });
        
        // Başlangıçta seçili olan günlerin stilini ayarla
        document.querySelectorAll(".weekday-checkbox").forEach(function(checkbox) {
          if (checkbox.checked) {
            const label = document.querySelector(`label[for="${checkbox.id}"]`);
            if (label) {
              label.style.background = "var(--gradient-accent)";
              label.style.color = "white";
              label.style.borderColor = "transparent";
              label.style.boxShadow = "0 8px 15px rgba(157, 78, 221, 0.25)";
              label.style.transform = "translateY(-3px)";
            }
          }
        });
      }

      // Populate the ListBox with all exercises initially (hidden from user)
      function populateWorkoutsListBox() {
        try {
          const listBox = document.getElementById(
            "<%= lstWorkouts.ClientID %>"
          );
          if (!listBox) return;

          // Clear existing options
          listBox.innerHTML = "";

          // Add all exercises from all muscle groups
          for (const muscleGroup in workoutsByMuscleGroup) {
            if (Array.isArray(workoutsByMuscleGroup[muscleGroup])) {
              workoutsByMuscleGroup[muscleGroup].forEach((workout) => {
                const option = document.createElement("option");
                option.text = workout;
                option.value = workout;
                listBox.add(option);
              });
            }
          }
        } catch (error) {
          console.error("populateWorkoutsListBox hatası:", error);
        }
      }

      // Update exercises based on selected muscle group
      function updateWorkoutsList(muscleGroup) {
        try {
          const listBox = document.getElementById(
            "<%= lstWorkouts.ClientID %>"
          );
          const container = document.getElementById("workoutCardsContainer");
          if (!listBox || !container) return;

          // Clear the container
          container.innerHTML = "";

          // Clear the listbox
          listBox.innerHTML = "";

          // Get the workouts for the selected muscle group
          const workouts = workoutsByMuscleGroup[muscleGroup] || [];

          // Create workout cards
          workouts.forEach((workoutName, index) => {
            const details = workoutDetails[workoutName] || {
              image:
                "https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_1280.jpg",
              description: "Bu egzersiz hakkında detaylı bilgi",
              difficulty: 2,
            };

            // Add option to the listbox
            const option = document.createElement("option");
            option.text = workoutName;
            option.value = workoutName;

            // Eğer bu kas grubu için önceden seçilmiş egzersiz varsa, tekrar seçili yap
            if (
              selectedExercises[muscleGroup] &&
              selectedExercises[muscleGroup].includes(workoutName)
            ) {
              option.selected = true;
            }

            listBox.add(option);
            const optionIndex = listBox.options.length - 1;

            // Check if this workout is selected
            const isSelected = listBox.options[optionIndex].selected;

            // Create workout card
            const card = document.createElement("div");
            card.className = "workout-card";
            card.dataset.workoutIndex = optionIndex;
            card.dataset.workoutName = workoutName;

            if (isSelected) {
              card.classList.add("workout-card-selected");
            }

            card.innerHTML = `
              <div class="select-badge" style="${
                isSelected ? "display: block;" : ""
              }">
                <i class="fas fa-check"></i> Seçildi
              </div>
              <img src="${details.image}" alt="${workoutName}" onclick="showExerciseModal('${encodeURIComponent(workoutName)}', '${encodeURIComponent(details.image)}', '${encodeURIComponent(details.description)}', ${details.difficulty})" style="cursor: pointer" />
              <div class="workout-card-body">
                <h5 class="workout-card-title">${workoutName}</h5>
                <p class="workout-card-text">${details.description}</p>
              </div>
              <div class="workout-card-footer">
                <div class="workout-difficulty">
                  Zorluk:
                  <div class="difficulty-dot ${
                    details.difficulty >= 1 ? "active" : ""
                  }"></div>
                  <div class="difficulty-dot ${
                    details.difficulty >= 2 ? "active" : ""
                  }"></div>
                  <div class="difficulty-dot ${
                    details.difficulty >= 3 ? "active" : ""
                  }"></div>
                </div>
                <button type="button" class="btn btn-sm btn-outline-primary"
                        onclick="toggleWorkoutSelection('${workoutName}', ${optionIndex})">
                  ${isSelected ? "Kaldır" : "Seç"}
                </button>
              </div>
            `;

            container.appendChild(card);
          });

          // Add animation effect
          container.style.opacity = "0";
          container.style.transform = "translateY(20px)";

          setTimeout(() => {
            container.style.transition = "all 0.5s ease-out";
            container.style.opacity = "1";
            container.style.transform = "translateY(0)";
          }, 50);

          // Seçili egzersizleri güncelle
          saveSelectedWorkouts();
        } catch (error) {
          console.error("updateWorkoutsList hatası:", error);
        }
      }

      // Egzersiz seçimini aç/kapat
      function toggleWorkoutSelection(workoutName, index) {
        try {
          const listBox = document.getElementById(
            "<%= lstWorkouts.ClientID %>"
          );
          const option = listBox.options[index];

          // Seçimi değiştir
          option.selected = !option.selected;

          // Kartı güncelle
          const card = document.querySelector(
            `.workout-card[data-workout-name="${workoutName}"]`
          );
          if (card) {
            const badge = card.querySelector(".select-badge");
            const selectButton = card.querySelector(".btn");

            if (option.selected) {
              card.classList.add("workout-card-selected");
              badge.style.display = "block";
              selectButton.textContent = "Kaldır";
            } else {
              card.classList.remove("workout-card-selected");
              badge.style.display = "none";
              selectButton.textContent = "Seç";
            }
          }

          // Seçili egzersizleri kaydet
          saveSelectedWorkouts();
        } catch (error) {
          console.error("toggleWorkoutSelection hatası:", error);
        }
      }

      // Seçili egzersizleri gizli bir input alanına kaydet
      function saveSelectedWorkouts() {
        try {
          const listBox = document.getElementById(
            "<%= lstWorkouts.ClientID %>"
          );
          const selectedWorkouts = [];
          const currentMuscleGroup = document.getElementById(
            "<%= ddlMuscleGroup.ClientID %>"
          ).value;

          for (let i = 0; i < listBox.options.length; i++) {
            if (listBox.options[i].selected) {
              selectedWorkouts.push({
                muscleGroup: currentMuscleGroup,
                workoutName: listBox.options[i].text,
              });

              if (!selectedExercises[currentMuscleGroup]) {
                selectedExercises[currentMuscleGroup] = [];
              }
              if (
                !selectedExercises[currentMuscleGroup].includes(
                  listBox.options[i].text
                )
              ) {
                selectedExercises[currentMuscleGroup].push(
                  listBox.options[i].text
                );
              }
            }
          }

          // Gizli input oluştur veya güncelle
          let hiddenField = document.getElementById("selectedWorkoutsHidden");
          if (!hiddenField) {
            hiddenField = document.createElement("input");
            hiddenField.type = "hidden";
            hiddenField.id = "selectedWorkoutsHidden";
            hiddenField.name = "selectedWorkoutsHidden";
            document.getElementById("form1").appendChild(hiddenField);
          }

          // JSON formatında sakla
          hiddenField.value = JSON.stringify(selectedWorkouts);
        } catch (error) {
          console.error("saveSelectedWorkouts hatası:", error);
        }
      }

      // Kaydet butonuna tıklamadan önce sunucu tarafı değerleri güncelle
      document.getElementById("form1").addEventListener("submit", function (e) {
        try {
          // Seçili kas grubunu kontrol et
          const muscleGroupDropdown = document.getElementById(
            "<%= ddlMuscleGroup.ClientID %>"
          );
          if (!muscleGroupDropdown.value) {
            e.preventDefault();
            alert("Lütfen bir kas grubu seçin.");
            return false;
          }

          // Seçili egzersizleri kontrol et
          const listBox = document.getElementById(
            "<%= lstWorkouts.ClientID %>"
          );
          let anySelected = false;
          for (let i = 0; i < listBox.options.length; i++) {
            if (listBox.options[i].selected) {
              anySelected = true;
              break;
            }
          }

          if (!anySelected) {
            e.preventDefault();
            alert("Lütfen en az bir egzersiz seçin.");
            return false;
          }

          // Son bir kez dropdown değerini güncelle
          let hiddenField = document.getElementById("hiddenMuscleGroup");
          if (hiddenField) {
            muscleGroupDropdown.value = hiddenField.value;
          }

          // Seçili egzersizleri güncelle
          saveSelectedWorkouts();

          return true;
        } catch (error) {
          console.error("Form submit hatası:", error);
          return true;
        }
      });

      // Egzersiz modali gösterme fonksiyonu
      function showExerciseModal(workoutName, imageSrc, description, difficulty) {
        try {
          // Tıklama olayının yayılmasını durdur (kartın seçilmesini engelle)
          event.stopPropagation();
          
          workoutName = decodeURIComponent(workoutName);
          imageSrc = decodeURIComponent(imageSrc);
          description = decodeURIComponent(description);
          
          // Modal içeriğini ayarla
          document.getElementById('modalExerciseImage').src = imageSrc;
          document.getElementById('modalExerciseTitle').textContent = workoutName;
          document.getElementById('modalExerciseDescription').textContent = description;
          
          // Zorluk noktalarını ayarla
          const dots = document.getElementById('modalDifficultyDots').children;
          for (let i = 0; i < dots.length; i++) {
            if (i < difficulty) {
              dots[i].classList.add('active');
            } else {
              dots[i].classList.remove('active');
            }
          }
          
          // Modalı göster
          const exerciseModal = new bootstrap.Modal(document.getElementById('exerciseImageModal'));
          exerciseModal.show();
        } catch (error) {
          console.error("showExerciseModal hatası:", error);
        }
      }
    </script>
  </body>
</html>
