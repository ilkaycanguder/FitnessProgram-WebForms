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
        --gradient-primary: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
        --gradient-accent: linear-gradient(135deg, var(--accent-color) 0%, var(--accent-secondary) 60%);
        --gradient-special: linear-gradient(90deg, var(--primary-color), var(--secondary-color), var(--accent-secondary));
      }
      
      body {
        background: var(--gradient-accent);
        min-height: 100vh;
        padding: 1.5rem 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      }
      
      .program-container {
        background: white;
        padding: 2.5rem;
        border-radius: 20px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2), 0 10px 25px rgba(0, 0, 0, 0.15);
        width: 98%;
        max-width: 1500px;
        margin: 0 auto;
        position: relative;
        overflow: hidden;
        animation: fadeIn 0.6s ease-out;
      }
      
      .program-container::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 8px;
        background: var(--gradient-special);
        z-index: 1;
      }
      
      .program-container::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: radial-gradient(circle at top right, rgba(157, 78, 221, 0.05), transparent 60%);
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
        content: '';
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
        content: '';
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
        content: '';
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
        content: '';
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
        margin-bottom: 0;
        transition: all 0.4s ease;
        filter: saturate(0.9);
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
        content: '';
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
        height: 180px;
        object-fit: cover;
        transition: all 0.4s ease;
        filter: saturate(0.9);
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
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: all 0.6s ease;
      }
      
      .btn-save:hover {
        background: linear-gradient(135deg, var(--accent-secondary) 0%, var(--accent-color) 100%);
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
        from { opacity: 0; }
        to { opacity: 1; }
      }
      
      @keyframes fadeInScale {
        from { opacity: 0; transform: scale(0.9); }
        to { opacity: 1; transform: scale(1); }
      }
      
      @keyframes slideIn {
        from { transform: translateY(20px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
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
        .muscle-card, .workout-card {
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
            <p class="info-card-text">Hedeflerinize uygun kas grupları seçerek kişiselleştirilmiş antrenman programı oluşturun.</p>
          </div>
          
          <div class="info-card" style="--card-index: 1">
            <div class="info-card-icon">
              <i class="fas fa-chart-line"></i>
            </div>
            <h3 class="info-card-title">İlerleme Takibi</h3>
            <p class="info-card-text">Oluşturduğunuz programlar ile gelişiminizi adım adım takip edin.</p>
          </div>
          
          <div class="info-card" style="--card-index: 2">
            <div class="info-card-icon">
              <i class="fas fa-award"></i>
            </div>
            <h3 class="info-card-title">Profesyonel Egzersizler</h3>
            <p class="info-card-text">Uzman antrenörler tarafından belirlenen etkili egzersizler ile hedefinize ulaşın.</p>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label">Kas Grubu Seçin</label>
          <div class="muscle-group-cards">
            <div class="muscle-card" data-value="Göğüs" onclick="selectMuscleGroup(this, 'Göğüs')">
              <img src="https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?q=80&w=1170&auto=format&fit=crop" alt="Göğüs Antrenmanı" />
              <h5>Göğüs</h5>
            </div>
            <div class="muscle-card" data-value="Bacak" onclick="selectMuscleGroup(this, 'Bacak')">
              <img src="https://images.unsplash.com/photo-1574680178050-55c6a6a96e0a?q=80&w=1169&auto=format&fit=crop" alt="Bacak Antrenmanı" />
              <h5>Bacak</h5>
            </div>
            <div class="muscle-card" data-value="Sırt" onclick="selectMuscleGroup(this, 'Sırt')">
              <img src="https://images.unsplash.com/photo-1599058917765-a780eda07a3e?q=80&w=1169&auto=format&fit=crop" alt="Sırt Antrenmanı" />
              <h5>Sırt</h5>
            </div>
            <div class="muscle-card" data-value="Kardiyo" onclick="selectMuscleGroup(this, 'Kardiyo')">
              <img src="https://cdn.pixabay.com/photo/2014/11/11/15/24/gym-526995_1280.jpg" alt="Kardiyo Antrenmanı" />
              <h5>Kardiyo</h5>
            </div>
            <div class="muscle-card" data-value="Kol" onclick="selectMuscleGroup(this, 'Kol')">
              <img src="https://cdn.pixabay.com/photo/2015/07/02/10/22/training-828726_1280.jpg" alt="Kol Antrenmanı" />
              <h5>Kol</h5>
            </div>
            <div class="muscle-card" data-value="Omuz" onclick="selectMuscleGroup(this, 'Omuz')">
              <img src="https://cdn.pixabay.com/photo/2014/11/17/13/17/crossfit-534615_1280.jpg" alt="Omuz Antrenmanı" />
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
          <label class="form-label">Egzersizler <small>(Birden fazla seçebilirsiniz)</small></label>
          
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // Store all workout data by muscle group
      const workoutsByMuscleGroup = {
        'Göğüs': ['Bench Press', 'Incline Dumbbell Press', 'Push-up', 'Dumbbell Fly', 'Cable Crossover', 'Chest Dip'],
        'Bacak': ['Squat', 'Lunge', 'Leg Press', 'Leg Extension', 'Hamstring Curl', 'Calf Raise'],
        'Sırt': ['Deadlift', 'Lat Pulldown', 'Barbell Row', 'Pull-up', 'T-Bar Row'],
        'Kardiyo': ['Koşu Bandı', 'Bisiklet', 'İp Atlama', 'Eliptik Bisiklet', 'Kürek Çekme', 'Yüzme'],
        'Kol': ['Bicep Curl', 'Tricep Extension', 'Hammer Curl', 'Skull Crusher', 'Concentration Curl', 'Dips'],
        'Omuz': ['Shoulder Press', 'Lateral Raise', 'Front Raise', 'Reverse Fly', 'Face Pull', 'Upright Row']
      };
      
      // Egzersiz kartları için veriler
      const workoutDetails = {
        'Bench Press': {
          image: 'https://cdn.pixabay.com/photo/2016/03/27/07/08/man-1282232_1280.jpg',
          description: 'Göğüs kaslarını geliştirmek için temel egzersiz',
          difficulty: 3
        },
        'Incline Dumbbell Press': {
          image: 'https://cdn.pixabay.com/photo/2016/03/27/23/00/weight-lifting-1284616_1280.jpg',
          description: 'Üst göğüs kaslarını hedefleyen egzersiz',
          difficulty: 2
        },
        'Push-up': {
          image: 'https://images.unsplash.com/photo-1566241142559-40e1dab266c6?q=80&w=1170&auto=format&fit=crop',
          description: 'Vücut ağırlığı ile göğüs, omuz ve triceps kaslarını çalıştırır',
          difficulty: 1
        },
        'Dumbbell Fly': {
          image: 'https://cdn.pixabay.com/photo/2013/03/09/14/38/gym-91849_1280.jpg',
          description: 'Göğüs kaslarını yana doğru açarak geliştirir',
          difficulty: 2
        },
        'Cable Crossover': {
          image: 'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?q=80&w=1169&auto=format&fit=crop',
          description: 'Kablo makinesi ile göğüs kaslarını içe doğru sıkarak çalıştırır',
          difficulty: 2
        },
        'Chest Dip': {
          image: 'https://images.unsplash.com/photo-1598266663439-2056e6900339?q=80&w=1169&auto=format&fit=crop',
          description: 'Paralel barda dip hareketi ile alt göğüs kaslarını çalıştırır',
          difficulty: 3
        },
        'Squat': {
          image: 'https://images.unsplash.com/photo-1567598508481-65985588e295?q=80&w=987&auto=format&fit=crop',
          description: 'Bacak kaslarını geliştirmek için temel egzersiz',
          difficulty: 3
        },
        'Lunge': {
          image: 'https://images.unsplash.com/photo-1434682881908-b43d0467b798?q=80&w=1174&auto=format&fit=crop',
          description: 'Bacak ve kalça kaslarını dengeli bir şekilde çalıştırır',
          difficulty: 2
        },
        'Leg Press': {
          image: 'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?q=80&w=2069&auto=format&fit=crop',
          description: 'Quadriceps ve hamstring kaslarını hedefleyen makine egzersizi',
          difficulty: 2
        },
        'Leg Extension': {
          image: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=1170&auto=format&fit=crop',
          description: 'Quadriceps (ön bacak) kaslarını izole eder',
          difficulty: 1
        },
        'Hamstring Curl': {
          image: 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?q=80&w=2069&auto=format&fit=crop',
          description: 'Hamstring (arka bacak) kaslarını izole eder',
          difficulty: 1
        },
        'Calf Raise': {
          image: 'https://images.unsplash.com/photo-1600618528240-fb9fc964b853?q=80&w=1170&auto=format&fit=crop',
          description: 'Baldır kaslarını hedefleyen egzersiz',
          difficulty: 1
        },
        'Deadlift': {
          image: 'https://images.unsplash.com/photo-1599058917765-a780eda07a3e?q=80&w=1169&auto=format&fit=crop',
          description: 'Sırt, kalça ve bacak kaslarını birlikte çalıştıran temel egzersiz',
          difficulty: 3
        },
        'Lat Pulldown': {
          image: 'https://images.unsplash.com/photo-1596357395217-80de13130e92?q=80&w=2071&auto=format&fit=crop',
          description: 'Sırt kaslarını, özellikle latissimus dorsi kasını hedefler',
          difficulty: 2
        },
        'Barbell Row': {
          image: 'https://images.unsplash.com/photo-1616803689943-5601631c7fec?q=80&w=1170&auto=format&fit=crop',
          description: 'Üst sırt kaslarını güçlendiren temel egzersiz',
          difficulty: 3
        },
        'Pull-up': {
          image: 'https://cdn.pixabay.com/photo/2017/04/22/10/15/sport-2250970_1280.jpg',
          description: 'Sırt kaslarını vücut ağırlığı ile çalıştıran etkili egzersiz',
          difficulty: 3
        },
        'T-Bar Row': {
          image: 'https://images.unsplash.com/photo-1598266663439-2056e6900339?q=80&w=1169&auto=format&fit=crop',
          description: 'Orta sırt kaslarını hedefleyen bir egzersiz',
          difficulty: 2
        },
        'Shoulder Press': {
          image: 'https://images.unsplash.com/photo-1532029837206-abbe2b7620e3?q=80&w=1170&auto=format&fit=crop',
          description: 'Omuz kaslarını geliştiren temel egzersiz',
          difficulty: 2
        },
        'Reverse Fly': {
          image: 'https://images.unsplash.com/photo-1601422407692-ec4eeec1d9b3?q=80&w=1025&auto=format&fit=crop',
          description: 'Arka deltoid kasını ve üst sırtı hedefleyen egzersiz',
          difficulty: 1
        },
        'Face Pull': {
          image: 'https://images.unsplash.com/photo-1605296867424-35fc25c9212a?q=80&w=1170&auto=format&fit=crop',
          description: 'Arka omuz kaslarını ve üst sırtı çalıştıran egzersiz',
          difficulty: 1
        },
        'Upright Row': {
          image: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=1170&auto=format&fit=crop',
          description: 'Omuz ve trapez kaslarını çalıştıran egzersiz',
          difficulty: 2
        },
        'Koşu Bandı': {
          image: 'https://images.unsplash.com/photo-1580086319619-3ed498161c77?q=80&w=2069&auto=format&fit=crop',
          description: 'Kalp-damar sistemini geliştiren temel kardiyovasküler egzersiz',
          difficulty: 2
        },
        'Bisiklet': {
          image: 'https://cdn.pixabay.com/photo/2014/09/28/19/49/fitness-465203_1280.jpg',
          description: 'Bacak kaslarını geliştirirken kalp-damar sistemini de çalıştırır',
          difficulty: 1
        },
        'İp Atlama': {
          image: 'https://images.unsplash.com/photo-1486739985386-d4fae04ca6f7?q=80&w=1072&auto=format&fit=crop',
          description: 'Tüm vücudu aynı anda çalıştıran etkili bir kardiyovasküler egzersiz',
          difficulty: 2
        },
        'Eliptik Bisiklet': {
          image: 'https://images.unsplash.com/photo-1518644961665-ed172691aaa1?q=80&w=1170&auto=format&fit=crop',
          description: 'Eklemlere minimum baskı ile kardiyovasküler egzersiz',
          difficulty: 1
        },
        'Kürek Çekme': {
          image: 'https://images.unsplash.com/photo-1521804906057-1df8fdb718b7?q=80&w=1170&auto=format&fit=crop',
          description: 'Tüm vücudu çalıştıran etkili bir kardiyovasküler egzersiz',
          difficulty: 2
        },
        'Yüzme': {
          image: 'https://images.unsplash.com/photo-1560090995-01632a28895b?q=80&w=1169&auto=format&fit=crop',
          description: 'Eklemlere baskı yapmadan tüm vücudu çalıştıran egzersiz',
          difficulty: 2
        },
        'Bicep Curl': {
          image: 'https://cdn.pixabay.com/photo/2016/11/22/22/25/abs-1850926_1280.jpg',
          description: 'Biseps kasını geliştiren temel egzersiz',
          difficulty: 1
        },
        'Tricep Extension': {
          image: 'https://images.unsplash.com/photo-1581122584612-713f89daa8eb?q=80&w=1965&auto=format&fit=crop',
          description: 'Triseps kasını geliştiren izolasyon egzersizi',
          difficulty: 1
        },
        'Hammer Curl': {
          image: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=1170&auto=format&fit=crop',
          description: 'Ön kol ve biseps kaslarını bir arada çalıştıran egzersiz',
          difficulty: 1
        },
        'Skull Crusher': {
          image: 'https://cdn.pixabay.com/photo/2017/04/27/08/29/bench-press-2264825_1280.jpg',
          description: 'Triseps kasını geliştiren etkili bir egzersiz',
          difficulty: 2
        },
        'Concentration Curl': {
          image: 'https://images.unsplash.com/photo-1606889464198-fcb18894cf50?q=80&w=1780&auto=format&fit=crop',
          description: 'Biseps kasını izole eden ve zirvede sıkışmayı artıran egzersiz',
          difficulty: 1
        },
        'Dips': {
          image: 'https://images.unsplash.com/photo-1598266663439-2056e6900339?q=80&w=1169&auto=format&fit=crop',
          description: 'Triseps ve göğüs kaslarını geliştiren etkili bir vücut ağırlığı egzersizi',
          difficulty: 2
        },
        'Lateral Raise': {
          image: 'https://cdn.pixabay.com/photo/2018/04/05/17/21/kettlebell-3293475_1280.jpg',
          description: 'Orta deltoid kasını hedefleyen izolasyon egzersizi',
          difficulty: 1
        },
        'Front Raise': {
          image: 'https://cdn.pixabay.com/photo/2017/08/07/14/02/man-2604149_1280.jpg',
          description: 'Ön deltoid kasını hedefleyen egzersiz',
          difficulty: 1
        }
      };
      
      // Show success message only when needed
      document.addEventListener('DOMContentLoaded', function() {
        const successMessage = document.querySelector('.success-message');
        if (successMessage && successMessage.textContent.trim() !== '') {
          successMessage.style.display = 'block';
          
          // Hide message after 5 seconds
          setTimeout(function() {
            successMessage.style.display = 'none';
          }, 5000);
        }
        
        // Pre-populate the workouts listbox with all exercises
        populateWorkoutsListBox();
      });
      
      // Kas grubu değiştiğinde önceki seçimleri korumak için
      var selectedExercises = {};
      
      // Kas grubu seçimi
      function selectMuscleGroup(element, value) {
        // Clear any existing success message
        const successMessage = document.querySelector('.success-message');
        if (successMessage) {
          successMessage.style.display = 'none';
        }
        
        // Önceki seçilen kas grubundaki seçili egzersizleri kaydet
        const previousMuscleGroup = document.getElementById('<%= ddlMuscleGroup.ClientID %>').value;
        if (previousMuscleGroup) {
          const listBox = document.getElementById('<%= lstWorkouts.ClientID %>');
          selectedExercises[previousMuscleGroup] = [];
          
          for (let i = 0; i < listBox.options.length; i++) {
            if (listBox.options[i].selected) {
              selectedExercises[previousMuscleGroup].push(listBox.options[i].text);
            }
          }
        }
        
        // Tüm kartlardan active sınıfını kaldır
        document.querySelectorAll('.muscle-card').forEach(card => {
          card.classList.remove('active');
        });
        
        // Seçilen karta active sınıfını ekle
        element.classList.add('active');
        
        // DropDownList'i güncelle (postback tetiklemeden)
        const dropdown = document.getElementById('<%= ddlMuscleGroup.ClientID %>');
        dropdown.value = value;
        
        // Herkese görünmeyen bir hidden field oluştur ve değeri ata
        let hiddenField = document.getElementById('hiddenMuscleGroup');
        if (!hiddenField) {
          hiddenField = document.createElement('input');
          hiddenField.type = 'hidden';
          hiddenField.id = 'hiddenMuscleGroup';
          hiddenField.name = 'hiddenMuscleGroup';
          document.getElementById('form1').appendChild(hiddenField);
        }
        hiddenField.value = value;
        
        // Egzersiz listesini güncelle
        updateWorkoutsList(value);
      }
      
      // Populate the ListBox with all exercises initially (hidden from user)
      function populateWorkoutsListBox() {
        const listBox = document.getElementById('<%= lstWorkouts.ClientID %>');
        
        // Clear existing options
        listBox.innerHTML = '';
        
        // Add all exercises from all muscle groups
        for (const muscleGroup in workoutsByMuscleGroup) {
          workoutsByMuscleGroup[muscleGroup].forEach(workout => {
            const option = document.createElement('option');
            option.text = workout;
            option.value = workout;
            listBox.add(option);
          });
        }
      }
      
      // Update exercises based on selected muscle group
      function updateWorkoutsList(muscleGroup) {
        const listBox = document.getElementById('<%= lstWorkouts.ClientID %>');
        const container = document.getElementById('workoutCardsContainer');
        
        // Clear the container
        container.innerHTML = '';
        
        // Clear the listbox
        listBox.innerHTML = '';
        
        // Get the workouts for the selected muscle group
        const workouts = workoutsByMuscleGroup[muscleGroup] || [];
        
        // Create workout cards
        workouts.forEach((workoutName, index) => {
          const details = workoutDetails[workoutName] || {
            image: 'https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_1280.jpg',
            description: 'Bu egzersiz hakkında detaylı bilgi',
            difficulty: 2
          };
          
          // Add option to the listbox
          const option = document.createElement('option');
          option.text = workoutName;
          option.value = workoutName;
          
          // Eğer bu kas grubu için önceden seçilmiş egzersiz varsa, tekrar seçili yap
          if (selectedExercises[muscleGroup] && selectedExercises[muscleGroup].includes(workoutName)) {
            option.selected = true;
          }
          
          listBox.add(option);
          const optionIndex = listBox.options.length - 1;
          
          // Check if this workout is selected
          const isSelected = listBox.options[optionIndex].selected;
          
          // Create workout card
          const card = document.createElement('div');
          card.className = 'workout-card';
          card.dataset.workoutIndex = optionIndex;
          card.dataset.workoutName = workoutName;
          
          if (isSelected) {
            card.classList.add('workout-card-selected');
          }
          
          card.innerHTML = `
            <div class="select-badge" style="${isSelected ? 'display: block;' : ''}">
              <i class="fas fa-check"></i> Seçildi
            </div>
            <img src="${details.image}" alt="${workoutName}" />
            <div class="workout-card-body">
              <h5 class="workout-card-title">${workoutName}</h5>
              <p class="workout-card-text">${details.description}</p>
            </div>
            <div class="workout-card-footer">
              <div class="workout-difficulty">
                Zorluk: 
                <div class="difficulty-dot ${details.difficulty >= 1 ? 'active' : ''}"></div>
                <div class="difficulty-dot ${details.difficulty >= 2 ? 'active' : ''}"></div>
                <div class="difficulty-dot ${details.difficulty >= 3 ? 'active' : ''}"></div>
              </div>
              <button type="button" class="btn btn-sm btn-outline-primary" 
                      onclick="toggleWorkoutSelection('${workoutName}', ${optionIndex})">
                ${isSelected ? 'Kaldır' : 'Seç'}
              </button>
            </div>
          `;
          
          container.appendChild(card);
        });
        
        // Add animation effect to simulate page transition without reload
        container.style.opacity = '0';
        container.style.transform = 'translateY(20px)';
        
        setTimeout(() => {
          container.style.transition = 'all 0.5s ease-out';
          container.style.opacity = '1';
          container.style.transform = 'translateY(0)';
        }, 50);
        
        // Seçili egzersizleri güncelle
        saveSelectedWorkouts();
      }
      
      // Egzersiz seçimini aç/kapat
      function toggleWorkoutSelection(workoutName, index) {
        const listBox = document.getElementById('<%= lstWorkouts.ClientID %>');
        const option = listBox.options[index];
        
        // Seçimi değiştir
        option.selected = !option.selected;
        
        // Kartı güncelle
        const card = document.querySelector(`.workout-card[data-workout-name="${workoutName}"]`);
        if (card) {
          const badge = card.querySelector('.select-badge');
          const selectButton = card.querySelector('.btn');
          
          if (option.selected) {
            card.classList.add('workout-card-selected');
            badge.style.display = 'block';
            selectButton.textContent = 'Kaldır';
          } else {
            card.classList.remove('workout-card-selected');
            badge.style.display = 'none';
            selectButton.textContent = 'Seç';
          }
        }
        
        // Seçili egzersizleri kaydet (gizli alan olarak)
        saveSelectedWorkouts();
      }
      
      // Seçili egzersizleri gizli bir input alanına kaydet
      function saveSelectedWorkouts() {
        const listBox = document.getElementById('<%= lstWorkouts.ClientID %>');
        const selectedWorkouts = [];
        const currentMuscleGroup = document.getElementById('<%= ddlMuscleGroup.ClientID %>').value;
        
        for (let i = 0; i < listBox.options.length; i++) {
          if (listBox.options[i].selected) {
            // Her egzersiz için, hangi kas grubuna ait olduğunu belirterek sakla
            selectedWorkouts.push({
              muscleGroup: currentMuscleGroup,
              workoutName: listBox.options[i].text
            });
            
            // Seçili egzersizleri kas grubu bazında da kaydet
            if (!selectedExercises[currentMuscleGroup]) {
              selectedExercises[currentMuscleGroup] = [];
            }
            if (!selectedExercises[currentMuscleGroup].includes(listBox.options[i].text)) {
              selectedExercises[currentMuscleGroup].push(listBox.options[i].text);
            }
          }
        }
        
        // Gizli input oluştur veya güncelle
        let hiddenField = document.getElementById('selectedWorkoutsHidden');
        if (!hiddenField) {
          hiddenField = document.createElement('input');
          hiddenField.type = 'hidden';
          hiddenField.id = 'selectedWorkoutsHidden';
          hiddenField.name = 'selectedWorkoutsHidden';
          document.getElementById('form1').appendChild(hiddenField);
        }
        
        // Debug için konsola bas
        console.log("Seçilen egzersizler:", selectedExercises);
        console.log("Gönderilecek veri:", selectedWorkouts);
        
        // JSON formatında sakla
        hiddenField.value = JSON.stringify(selectedWorkouts);
      }

      // Kaydet butonuna tıklamadan önce sunucu tarafı değerleri güncelle
      document.getElementById('form1').addEventListener('submit', function(e) {
        try {
          // Debug için konsola bilgi yazdır
          console.log('Form submit başladı');
          
          // Seçili kas grubunu kontrol et
          const muscleGroupDropdown = document.getElementById('<%= ddlMuscleGroup.ClientID %>');
          if (!muscleGroupDropdown.value) {
            e.preventDefault();
            alert('Lütfen bir kas grubu seçin.');
            return false;
          }
          console.log('Seçili kas grubu:', muscleGroupDropdown.value);
          
          // Seçili egzersizleri kontrol et
          const listBox = document.getElementById('<%= lstWorkouts.ClientID %>');
          let anySelected = false;
          let selectedItems = [];
          for (let i = 0; i < listBox.options.length; i++) {
            if (listBox.options[i].selected) {
              anySelected = true;
              selectedItems.push(listBox.options[i].text);
            }
          }
          console.log('Seçili egzersizler:', selectedItems);
          
          if (!anySelected) {
            e.preventDefault();
            alert('Lütfen en az bir egzersiz seçin.');
            return false;
          }
          
          // Son bir kez dropdown değerini güncelle (postback için)
          let hiddenField = document.getElementById('hiddenMuscleGroup');
          if (hiddenField) {
            muscleGroupDropdown.value = hiddenField.value;
            console.log('Kas grubu hidden field değeri:', hiddenField.value);
          }
          
          // Seçili egzersizleri güncelle
          saveSelectedWorkouts();
          
          // Debug için hidden field değerini yazdır
          const workoutsHidden = document.getElementById('selectedWorkoutsHidden');
          if (workoutsHidden) {
            console.log('selectedWorkoutsHidden değeri:', workoutsHidden.value);
          }
          
          // İşlemin devam etmesine izin ver
          console.log('Form submit tamamlanıyor...');
          return true;
        } 
        catch (err) {
          console.error('Form submit hatası:', err);
          return true; // Hata olsa bile devam et
        }
      });
    </script>
  </body>
</html>
