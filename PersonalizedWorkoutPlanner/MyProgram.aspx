<%@ Page Title="Programlarım" Language="C#" MasterPageFile="~/Site.Master"
AutoEventWireup="true" CodeBehind="MyProgram.aspx.cs"
Inherits="PersonalizedWorkoutPlanner.MyProgram" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- HTML to PDF Kütüphanesi -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
  <style>
    .program-container {
      margin-top: 2rem;
    }

    .program-days-row {
      display: flex;
      flex-wrap: nowrap;
      gap: 1.5rem;
      justify-content: flex-start;
      margin-bottom: 2rem;
      overflow-x: auto;
      padding-bottom: 1rem;
    }

    .day-section {
      flex: 0 0 200px;
      min-width: 200px;
      max-width: 220px;
      background: #fff;
      border-radius: 15px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
      padding: 1rem 0.5rem 0.5rem 0.5rem;
      margin: 0;
      display: flex;
      flex-direction: column;
      align-items: stretch;
    }

    .day-title {
      color: #1e3c72;
      font-size: 1rem;
      font-weight: 700;
      margin-bottom: 0.7rem;
      text-align: center;
      border-bottom: 2px solid #1e3c72;
      padding-bottom: 0.3rem;
    }

    .program-card {
      background: #f8f9fa;
      border-radius: 10px;
      box-shadow: none;
      margin-bottom: 0.7rem;
      padding: 0.7rem;
      transition: box-shadow 0.2s;
      position: relative;
    }

    .program-card:hover {
      box-shadow: 0 4px 16px rgba(30, 60, 114, 0.1);
    }

    .program-header {
      display: flex;
      flex-direction: column;
      align-items: flex-start;
      margin-bottom: 0.5rem;
    }

    .program-date {
      font-size: 0.8rem;
      padding: 0.1rem 0.5rem;
      background: #e9ecef;
      border-radius: 50px;
      color: #888;
      margin-bottom: 0.2rem;
      display: inline-block;
    }

    .program-title {
      font-size: 0.95rem;
      font-weight: 600;
      margin: 0 0 0.2rem 0;
      color: #1e3c72;
      word-break: break-word;
    }

    .program-days {
      font-size: 0.9rem;
      color: #666;
      margin-bottom: 0.5rem;
    }

    .workout-item {
      display: flex;
      align-items: center;
      margin-bottom: 0.5rem;
    }

    .workout-icon {
      width: 32px;
      height: 32px;
      background: #e3eafc;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 0.7rem;
      color: #1e3c72;
      font-weight: bold;
      font-size: 1.1rem;
    }

    .workout-details {
      flex: 1;
    }

    .workout-name {
      font-weight: 600;
      color: #1e3c72;
      margin: 0;
      font-size: 0.95rem;
    }

    .workout-group {
      font-size: 0.75rem;
      color: #666;
      margin: 0;
    }

    .no-program {
      text-align: center;
      padding: 3rem;
      background: #f8f9fa;
      border-radius: 15px;
      color: #666;
    }

    .no-program h3 {
      color: #1e3c72;
      margin-bottom: 1rem;
    }

    .btn-create {
      display: inline-block;
      padding: 0.8rem 2rem;
      background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
      color: white;
      border-radius: 50px;
      text-decoration: none;
      transition: all 0.3s ease;
      margin-top: 1rem;
    }

    .btn-create:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(30, 60, 114, 0.2);
      color: white;
    }

    .btn-delete {
      background: none;
      border: none;
      color: #e74c3c;
      font-size: 1.3rem;
      cursor: pointer;
      padding: 0;
      transition: color 0.2s;
      position: absolute;
      top: 10px;
      right: 10px;
      z-index: 2;
      line-height: 1;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .btn-delete:hover {
      color: #c0392b;
    }

    .btn-print {
      background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
      color: white;
      border: none;
      border-radius: 8px;
      padding: 10px 20px;
      font-size: 0.9rem;
      cursor: pointer;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      margin: 0 auto 20px auto;
      box-shadow: 0 4px 10px rgba(30, 60, 114, 0.2);
    }
    
    .btn-print:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 15px rgba(30, 60, 114, 0.3);
    }
    
    .btn-print i {
      font-size: 1.1rem;
    }

    @media (max-width: 900px) {
      .program-days-row {
        /* flex-direction: column; */
        gap: 1rem;
      }
      .day-section {
        max-width: 200px;
      }
    }
    
    @media print {
      .no-print {
        display: none !important;
      }
    }
  </style>

  <div class="container program-container">
    <h1 class="text-center mb-4" style="display: flex; align-items: center; justify-content: center; gap: 0.7rem;">
      Programlarım
      <i class="fas fa-dumbbell" style="font-size: 2rem; color: #1e3c72;"></i>
    </h1>

    <asp:Panel
      ID="pnlNoProgram"
      runat="server"
      CssClass="no-program"
      Visible="false"
    >
      <h3>Henüz Program Oluşturmadınız</h3>
      <p>
        Kişiselleştirilmiş antrenman programınızı oluşturmak için hemen
        başlayın!
      </p>
      <a href="Program.aspx" class="btn-create">Program Oluştur</a>
    </asp:Panel>

    <!-- Görünmez form alanları -->
    <asp:HiddenField ID="hdnWorkoutId" runat="server" />
    <asp:HiddenField ID="hdnNewDay" runat="server" />
    <asp:Button ID="btnUpdateDay" runat="server" CssClass="d-none" OnClick="btnUpdateDay_Click" Text="Güncelle" />

    <asp:Panel ID="pnlPrograms" runat="server">
      <button type="button" id="btnDownloadPDF" class="btn-print">
        <i class="fas fa-file-pdf"></i> Programı PDF Olarak İndir
      </button>
      
      <div id="programContent" class="program-days-row">
        <!-- Pazartesi -->
        <div
          class="day-section"
          ondragover="onDragOver(event)"
          ondrop="onDrop(event, 'Pazartesi')"
        >
          <div class="day-title">Pazartesi</div>
          <asp:Repeater
            ID="rptPazartesi"
            runat="server"
            OnItemCommand="ProgramSil_ItemCommand"
          >
            <ItemTemplate>
              <div
                class="program-card"
                draggable="true"
                data-id='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                data-day="Pazartesi"
                ondragstart="onDragStart(event, this)"
              >
                <div class="program-header">
                  <span class="program-title"
                    ><%#
                    ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                    %></span
                  >
                  <span class="program-date">
                    <i class="fas fa-calendar"></i>
                    <%#
                    Convert.ToDateTime(((System.Data.DataRow)Container.DataItem)["CreatedDate"]).ToString("dd.MM.yyyy")
                    %>
                  </span>
                  <asp:Button
                    runat="server"
                    CssClass="btn-delete"
                    CommandName="Sil"
                    CommandArgument='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                    Text="&#128465;"
                    ToolTip="Sil"
                    OnClientClick="return confirmDelete(this);"
                  />
                </div>
                <div class="program-days">
                  <i class="fas fa-clock"></i> <%#
                  ((System.Data.DataRow)Container.DataItem)["Days"] %>
                </div>
                <div class="workout-item">
                  <div class="workout-icon">
                    <i class="fas fa-dumbbell"></i>
                  </div>
                  <div class="workout-details">
                    <span class="workout-name"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                      %></span
                    >
                    <span class="workout-group"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["MuscleGroup"]
                      %></span
                    >
                  </div>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
        <!-- Salı -->
        <div
          class="day-section"
          ondragover="onDragOver(event)"
          ondrop="onDrop(event, 'Salı')"
        >
          <div class="day-title">Salı</div>
          <asp:Repeater
            ID="rptSali"
            runat="server"
            OnItemCommand="ProgramSil_ItemCommand"
          >
            <ItemTemplate>
              <div
                class="program-card"
                draggable="true"
                data-id='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                data-day="Salı"
                ondragstart="onDragStart(event, this)"
              >
                <div class="program-header">
                  <span class="program-title"
                    ><%#
                    ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                    %></span
                  >
                  <span class="program-date">
                    <i class="fas fa-calendar"></i>
                    <%#
                    Convert.ToDateTime(((System.Data.DataRow)Container.DataItem)["CreatedDate"]).ToString("dd.MM.yyyy")
                    %>
                  </span>
                  <asp:Button
                    runat="server"
                    CssClass="btn-delete"
                    CommandName="Sil"
                    CommandArgument='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                    Text="&#128465;"
                    ToolTip="Sil"
                    OnClientClick="return confirmDelete(this);"
                  />
                </div>
                <div class="program-days">
                  <i class="fas fa-clock"></i> <%#
                  ((System.Data.DataRow)Container.DataItem)["Days"] %>
                </div>
                <div class="workout-item">
                  <div class="workout-icon">
                    <i class="fas fa-dumbbell"></i>
                  </div>
                  <div class="workout-details">
                    <span class="workout-name"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                      %></span
                    >
                    <span class="workout-group"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["MuscleGroup"]
                      %></span
                    >
                  </div>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
        <!-- Çarşamba -->
        <div
          class="day-section"
          ondragover="onDragOver(event)"
          ondrop="onDrop(event, 'Çarşamba')"
        >
          <div class="day-title">Çarşamba</div>
          <asp:Repeater
            ID="rptCarsamba"
            runat="server"
            OnItemCommand="ProgramSil_ItemCommand"
          >
            <ItemTemplate>
              <div
                class="program-card"
                draggable="true"
                data-id='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                data-day="Çarşamba"
                ondragstart="onDragStart(event, this)"
              >
                <div class="program-header">
                  <span class="program-title"
                    ><%#
                    ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                    %></span
                  >
                  <span class="program-date">
                    <i class="fas fa-calendar"></i>
                    <%#
                    Convert.ToDateTime(((System.Data.DataRow)Container.DataItem)["CreatedDate"]).ToString("dd.MM.yyyy")
                    %>
                  </span>
                  <asp:Button
                    runat="server"
                    CssClass="btn-delete"
                    CommandName="Sil"
                    CommandArgument='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                    Text="&#128465;"
                    ToolTip="Sil"
                    OnClientClick="return confirmDelete(this);"
                  />
                </div>
                <div class="program-days">
                  <i class="fas fa-clock"></i> <%#
                  ((System.Data.DataRow)Container.DataItem)["Days"] %>
                </div>
                <div class="workout-item">
                  <div class="workout-icon">
                    <i class="fas fa-dumbbell"></i>
                  </div>
                  <div class="workout-details">
                    <span class="workout-name"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                      %></span
                    >
                    <span class="workout-group"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["MuscleGroup"]
                      %></span
                    >
                  </div>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
        <!-- Perşembe -->
        <div
          class="day-section"
          ondragover="onDragOver(event)"
          ondrop="onDrop(event, 'Perşembe')"
        >
          <div class="day-title">Perşembe</div>
          <asp:Repeater
            ID="rptPersembe"
            runat="server"
            OnItemCommand="ProgramSil_ItemCommand"
          >
            <ItemTemplate>
              <div
                class="program-card"
                draggable="true"
                data-id='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                data-day="Perşembe"
                ondragstart="onDragStart(event, this)"
              >
                <div class="program-header">
                  <span class="program-title"
                    ><%#
                    ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                    %></span
                  >
                  <span class="program-date">
                    <i class="fas fa-calendar"></i>
                    <%#
                    Convert.ToDateTime(((System.Data.DataRow)Container.DataItem)["CreatedDate"]).ToString("dd.MM.yyyy")
                    %>
                  </span>
                  <asp:Button
                    runat="server"
                    CssClass="btn-delete"
                    CommandName="Sil"
                    CommandArgument='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                    Text="&#128465;"
                    ToolTip="Sil"
                    OnClientClick="return confirmDelete(this);"
                  />
                </div>
                <div class="program-days">
                  <i class="fas fa-clock"></i> <%#
                  ((System.Data.DataRow)Container.DataItem)["Days"] %>
                </div>
                <div class="workout-item">
                  <div class="workout-icon">
                    <i class="fas fa-dumbbell"></i>
                  </div>
                  <div class="workout-details">
                    <span class="workout-name"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                      %></span
                    >
                    <span class="workout-group"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["MuscleGroup"]
                      %></span
                    >
                  </div>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
        <!-- Cuma -->
        <div
          class="day-section"
          ondragover="onDragOver(event)"
          ondrop="onDrop(event, 'Cuma')"
        >
          <div class="day-title">Cuma</div>
          <asp:Repeater
            ID="rptCuma"
            runat="server"
            OnItemCommand="ProgramSil_ItemCommand"
          >
            <ItemTemplate>
              <div
                class="program-card"
                draggable="true"
                data-id='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                data-day="Cuma"
                ondragstart="onDragStart(event, this)"
              >
                <div class="program-header">
                  <span class="program-title"
                    ><%#
                    ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                    %></span
                  >
                  <span class="program-date">
                    <i class="fas fa-calendar"></i>
                    <%#
                    Convert.ToDateTime(((System.Data.DataRow)Container.DataItem)["CreatedDate"]).ToString("dd.MM.yyyy")
                    %>
                  </span>
                  <asp:Button
                    runat="server"
                    CssClass="btn-delete"
                    CommandName="Sil"
                    CommandArgument='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                    Text="&#128465;"
                    ToolTip="Sil"
                    OnClientClick="return confirmDelete(this);"
                  />
                </div>
                <div class="program-days">
                  <i class="fas fa-clock"></i> <%#
                  ((System.Data.DataRow)Container.DataItem)["Days"] %>
                </div>
                <div class="workout-item">
                  <div class="workout-icon">
                    <i class="fas fa-dumbbell"></i>
                  </div>
                  <div class="workout-details">
                    <span class="workout-name"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                      %></span
                    >
                    <span class="workout-group"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["MuscleGroup"]
                      %></span
                    >
                  </div>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
        <!-- Cumartesi -->
        <div
          class="day-section"
          ondragover="onDragOver(event)"
          ondrop="onDrop(event, 'Cumartesi')"
        >
          <div class="day-title">Cumartesi</div>
          <asp:Repeater
            ID="rptCumartesi"
            runat="server"
            OnItemCommand="ProgramSil_ItemCommand"
          >
            <ItemTemplate>
              <div
                class="program-card"
                draggable="true"
                data-id='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                data-day="Cumartesi"
                ondragstart="onDragStart(event, this)"
              >
                <div class="program-header">
                  <span class="program-title"
                    ><%#
                    ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                    %></span
                  >
                  <span class="program-date">
                    <i class="fas fa-calendar"></i>
                    <%#
                    Convert.ToDateTime(((System.Data.DataRow)Container.DataItem)["CreatedDate"]).ToString("dd.MM.yyyy")
                    %>
                  </span>
                  <asp:Button
                    runat="server"
                    CssClass="btn-delete"
                    CommandName="Sil"
                    CommandArgument='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                    Text="&#128465;"
                    ToolTip="Sil"
                    OnClientClick="return confirmDelete(this);"
                  />
                </div>
                <div class="program-days">
                  <i class="fas fa-clock"></i> <%#
                  ((System.Data.DataRow)Container.DataItem)["Days"] %>
                </div>
                <div class="workout-item">
                  <div class="workout-icon">
                    <i class="fas fa-dumbbell"></i>
                  </div>
                  <div class="workout-details">
                    <span class="workout-name"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                      %></span
                    >
                    <span class="workout-group"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["MuscleGroup"]
                      %></span
                    >
                  </div>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
        <!-- Pazar -->
        <div
          class="day-section"
          ondragover="onDragOver(event)"
          ondrop="onDrop(event, 'Pazar')"
        >
          <div class="day-title">Pazar</div>
          <asp:Repeater
            ID="rptPazar"
            runat="server"
            OnItemCommand="ProgramSil_ItemCommand"
          >
            <ItemTemplate>
              <div
                class="program-card"
                draggable="true"
                data-id='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                data-day="Pazar"
                ondragstart="onDragStart(event, this)"
              >
                <div class="program-header">
                  <span class="program-title"
                    ><%#
                    ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                    %></span
                  >
                  <span class="program-date">
                    <i class="fas fa-calendar"></i>
                    <%#
                    Convert.ToDateTime(((System.Data.DataRow)Container.DataItem)["CreatedDate"]).ToString("dd.MM.yyyy")
                    %>
                  </span>
                  <asp:Button
                    runat="server"
                    CssClass="btn-delete"
                    CommandName="Sil"
                    CommandArgument='<%# ((System.Data.DataRow)Container.DataItem)["Id"] %>'
                    Text="&#128465;"
                    ToolTip="Sil"
                    OnClientClick="return confirmDelete(this);"
                  />
                </div>
                <div class="program-days">
                  <i class="fas fa-clock"></i> <%#
                  ((System.Data.DataRow)Container.DataItem)["Days"] %>
                </div>
                <div class="workout-item">
                  <div class="workout-icon">
                    <i class="fas fa-dumbbell"></i>
                  </div>
                  <div class="workout-details">
                    <span class="workout-name"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["WorkoutName"]
                      %></span
                    >
                    <span class="workout-group"
                      ><%#
                      ((System.Data.DataRow)Container.DataItem)["MuscleGroup"]
                      %></span
                    >
                  </div>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
    </asp:Panel>
  </div>

  <script>
    let draggedId = null;
    let draggedDay = null;

    // Sayfa yüklendiğinde çalışacak kod
    $(document).ready(function() {
      console.log("Sayfa yüklendi ve hazır");
      
      // PDF İndirme butonu
      $("#btnDownloadPDF").click(function() {
        generatePDF();
      });
    });

    function onDragStart(e, el) {
      draggedId = el.getAttribute("data-id");
      draggedDay = el.getAttribute("data-day");
      e.dataTransfer.effectAllowed = "move";
    }
    
    function onDragOver(e) {
      e.preventDefault();
      e.dataTransfer.dropEffect = "move";
    }
    
    function onDrop(e, newDay) {
      e.preventDefault();
      if (draggedId && draggedDay !== newDay) {
        console.log("Sürükleme başladı - ID: " + draggedId + ", Eski gün: " + draggedDay + ", Yeni gün: " + newDay);
        
        // Form değerlerini doldur ve gönder
        try {
          document.getElementById('<%= hdnWorkoutId.ClientID %>').value = draggedId;
          document.getElementById('<%= hdnNewDay.ClientID %>').value = newDay;
          console.log("Hidden field değerleri ayarlandı: ID=" + draggedId + ", NewDay=" + newDay);
          
          // Form gönderme düğmesine tıkla
          document.getElementById('<%= btnUpdateDay.ClientID %>').click();
          
          // Sayfa güncellenmesini zorla (5 saniye içinde güncelleme olmazsa)
          setTimeout(function() {
            window.location.reload();
          }, 5000);
        } catch (e) {
          console.error("Form gönderme hatası:", e);
          alert("Egzersiz günü güncellenirken bir hata oluştu. Lütfen sayfayı yenileyip tekrar deneyin.");
          // Hata durumunda da sayfayı yenile
          window.location.reload();
        }
      }
      
      draggedId = null;
      draggedDay = null;
    }
    
    // Silme işleminin ardından sayfayı yenileme
    function confirmDelete(button) {
      if (confirm('Bu hareketi silmek istediğinize emin misiniz?')) {
        // Silme işleminden sonra sayfayı yenile
        setTimeout(function() {
          window.location.reload();
        }, 2000);
        return true;
      }
      return false;
    }
    
    // Tüm silme butonlarına click event listener ekle
    $(document).ready(function() {
      $('.btn-delete').each(function() {
        const originalClick = this.onclick;
        this.onclick = function(e) {
          const result = originalClick ? originalClick.call(this, e) : true;
          if (result !== false) {
            setTimeout(function() {
              window.location.reload();
            }, 2000);
          }
          return result;
        };
      });
    });

    // PDF Oluşturma ve İndirme Fonksiyonu
    function generatePDF() {
      // Navbar ve diğer yazdırılmayacak elementleri geçici olarak gizle
      $(".navbar, .footer, .btn-print, .btn-delete").addClass("no-print");
      
      // PDF ayarları
      const element = document.getElementById('programContent');
      const opt = {
        margin: [10, 10, 10, 10],
        filename: 'antrenman-programim.pdf',
        image: { type: 'jpeg', quality: 0.98 },
        html2canvas: { scale: 2, useCORS: true },
        jsPDF: { unit: 'mm', format: 'a4', orientation: 'landscape' }
      };
      
      // PDF oluştur ve indir
      html2pdf().set(opt).from(element).save().then(function() {
        // İşlem tamamlandıktan sonra gizlenen elementleri göster
        setTimeout(function() {
          $(".navbar, .footer, .btn-print, .btn-delete").removeClass("no-print");
        }, 1000);
      });
    }
  </script>
</asp:Content>
