<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Program.aspx.cs"
Inherits="PersonalizedWorkoutPlanner.Program" %>

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
      body {
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        min-height: 100vh;
        padding: 2rem 0;
      }
      .program-container {
        background: white;
        padding: 2rem;
        border-radius: 15px;
        box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
      }
      .program-header {
        text-align: center;
        margin-bottom: 2rem;
        padding-bottom: 1rem;
        border-bottom: 2px solid #f0f0f0;
      }
      .program-header h2 {
        color: #1e3c72;
        font-weight: 600;
        margin-bottom: 0.5rem;
      }
      .program-header p {
        color: #666;
        font-size: 1.1rem;
      }
      .form-group {
        margin-bottom: 1.5rem;
      }
      .form-label {
        font-weight: 500;
        color: #1e3c72;
        margin-bottom: 0.5rem;
      }
      .form-control {
        border-radius: 8px;
        padding: 0.8rem;
        border: 1px solid #ddd;
        transition: all 0.3s ease;
      }
      .form-control:focus {
        border-color: #1e3c72;
        box-shadow: 0 0 0 0.2rem rgba(30, 60, 114, 0.25);
      }
      .muscle-group-cards {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        margin-bottom: 20px;
      }
      .muscle-card {
        border: 2px solid #ddd;
        border-radius: 10px;
        padding: 10px;
        width: calc(25% - 15px);
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        background-color: #fff;
        overflow: hidden;
      }
      .muscle-card:hover {
        border-color: #1e3c72;
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
      }
      .muscle-card.active {
        border-color: #1e3c72;
        background-color: #f0f7ff;
        box-shadow: 0 5px 15px rgba(30, 60, 114, 0.3);
        position: relative;
      }
      .muscle-card.active::after {
        content: "✓";
        position: absolute;
        top: 10px;
        right: 10px;
        background: #1e3c72;
        color: white;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
      }
      .muscle-card img {
        width: 100%;
        height: 120px;
        object-fit: cover;
        border-radius: 8px;
        margin-bottom: 10px;
      }
      .muscle-card h5 {
        color: #1e3c72;
        margin: 0;
      }
      .workout-cards {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        margin-top: 20px;
      }
      .workout-card {
        border: 1px solid #ddd;
        border-radius: 10px;
        overflow: hidden;
        width: calc(33.333% - 14px);
        transition: all 0.3s ease;
        position: relative;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 5px;
      }
      .workout-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
      }
      .workout-card-selected {
        border: 3px solid #28a745;
        box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
      }
      .workout-card img {
        width: 100%;
        height: 160px;
        object-fit: cover;
      }
      .workout-card-body {
        padding: 15px;
      }
      .workout-card-title {
        font-weight: 600;
        color: #1e3c72;
        margin-bottom: 5px;
      }
      .workout-card-text {
        color: #666;
        font-size: 0.9rem;
        margin-bottom: 10px;
      }
      .workout-card-footer {
        background-color: #f8f9fa;
        padding: 10px 15px;
        border-top: 1px solid #ddd;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
      .select-badge {
        position: absolute;
        top: 10px;
        right: 10px;
        background-color: #28a745;
        color: white;
        padding: 8px 12px;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: bold;
        display: none;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        z-index: 2;
      }
      .workout-list {
        display: none;
      }
      .btn-save {
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        color: white;
        padding: 1rem 2rem;
        border-radius: 8px;
        font-weight: 700;
        font-size: 1.1rem;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        width: 100%;
        margin-top: 2rem;
        box-shadow: 0 4px 10px rgba(30, 60, 114, 0.3);
        border: none;
        position: relative;
        overflow: hidden;
      }
      .btn-save:hover {
        background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
        color: white;
        transform: translateY(-3px);
        box-shadow: 0 6px 15px rgba(30, 60, 114, 0.4);
      }
      .btn-save:active {
        transform: translateY(1px);
        box-shadow: 0 2px 5px rgba(30, 60, 114, 0.4);
      }
      .success-message {
        color: #155724;
        font-weight: 600;
        text-align: center;
        margin-top: 1.5rem;
        padding: 1rem;
        border-radius: 8px;
        background: #d4edda;
        border: 1px solid #c3e6cb;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.1rem;
      }
      .success-message:before {
        content: "✓";
        display: inline-block;
        margin-right: 10px;
        background: #28a745;
        color: white;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
      }
      .nav-buttons {
        display: flex;
        justify-content: space-between;
        margin-bottom: 1rem;
      }
      .nav-btn {
        color: #1e3c72;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s ease;
      }
      .nav-btn:hover {
        color: #2a5298;
      }
      .workout-difficulty {
        display: flex;
        align-items: center;
        gap: 5px;
      }
      .difficulty-dot {
        height: 10px;
        width: 10px;
        background-color: #ccc;
        border-radius: 50%;
      }
      .difficulty-dot.active {
        background-color: #1e3c72;
      }
      @media (max-width: 992px) {
        .muscle-card {
          width: calc(50% - 10px);
        }
        .workout-card {
          width: calc(50% - 10px);
        }
      }
      @media (max-width: 576px) {
        .muscle-card, .workout-card {
          width: 100%;
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
      // Kas grubu seçimi
      function selectMuscleGroup(element, value) {
        // Tüm kartlardan active sınıfını kaldır
        document.querySelectorAll('.muscle-card').forEach(card => {
          card.classList.remove('active');
        });
        
        // Seçilen karta active sınıfını ekle
        element.classList.add('active');
        
        // DropDownList'i güncelle ve postback tetikle
        const dropdown = document.getElementById('<%= ddlMuscleGroup.ClientID %>');
        dropdown.value = value;
        
        // ASP.NET DropDownList'in değişimini tetikle
        if (typeof(__doPostBack) === 'function') {
          __doPostBack('<%= ddlMuscleGroup.ClientID %>', '');
        }
      }
      
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
          image: 'https://images.unsplash.com/photo-1598971639058-fab3c3109a00?q=80&w=1074&auto=format&fit=crop',
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
          image: 'https://images.unsplash.com/photo-1581009137042-c552e485697a?q=80&w=1170&auto=format&fit=crop',
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
      
      // Egzersiz kartlarını oluştur
      function createWorkoutCards() {
        const listBox = document.getElementById('<%= lstWorkouts.ClientID %>');
        const container = document.getElementById('workoutCardsContainer');
        container.innerHTML = '';
        
        // ListBox'ta seçili olan değerleri al
        const selectedWorkouts = [];
        for (let i = 0; i < listBox.options.length; i++) {
          if (listBox.options[i].selected) {
            selectedWorkouts.push(listBox.options[i].text);
          }
        }
        
        // Tüm egzersizler için kartlar oluştur
        for (let i = 0; i < listBox.options.length; i++) {
          const workoutName = listBox.options[i].text;
          const details = workoutDetails[workoutName] || {
            image: 'https://cdn.pixabay.com/photo/2017/05/25/15/08/jogging-2343558_1280.jpg',
            description: 'Bu egzersiz hakkında detaylı bilgi',
            difficulty: 2
          };
          
          // Egzersiz kartı oluştur
          const card = document.createElement('div');
          card.className = 'workout-card';
          card.dataset.workoutIndex = i;
          
          // Eğer bu egzersiz seçiliyse, seçili sınıfını ekle
          if (selectedWorkouts.includes(workoutName)) {
            card.classList.add('workout-card-selected');
          }
          
          card.innerHTML = `
            <div class="select-badge" style="${selectedWorkouts.includes(workoutName) ? 'display: block;' : ''}">
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
              <button type="button" class="btn btn-sm btn-outline-primary" onclick="toggleWorkoutSelection(${i}, '${workoutName}')">
                ${selectedWorkouts.includes(workoutName) ? 'Kaldır' : 'Seç'}
              </button>
            </div>
          `;
          
          container.appendChild(card);
        }
      }
      
      // Egzersiz seçimini aç/kapat
      function toggleWorkoutSelection(index, workoutName) {
        const listBox = document.getElementById('<%= lstWorkouts.ClientID %>');
        const option = listBox.options[index];
        
        // Seçimi değiştir
        option.selected = !option.selected;
        
        // Kartı güncelle
        const card = document.querySelector(`.workout-card[data-workout-index="${index}"]`);
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
      
      // Sayfa yüklendiğinde veya postback sonrası egzersiz kartlarını oluştur
      document.addEventListener('DOMContentLoaded', function() {
        createWorkoutCards();
      });
      
      // ASP.NET AJAX istek tamamlandığında
      if (typeof(Sys) !== 'undefined') {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function() {
          createWorkoutCards();
        });
      }
    </script>
  </body>
</html>
