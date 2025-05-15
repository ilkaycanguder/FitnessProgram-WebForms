<%@ Page Title="Programlarım" Language="C#" MasterPageFile="~/Site.Master"
AutoEventWireup="true" CodeBehind="MyProgram.aspx.cs"
Inherits="PersonalizedWorkoutPlanner.MyProgram" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    .program-container {
      margin-top: 1.5rem;
      max-width: 100%;
      width: 100%;
      padding: 0;
    }

    .program-days-row {
      display: flex;
      flex-wrap: wrap;
      gap: 0.4rem;
      justify-content: center;
      margin-bottom: 1.5rem;
      padding-bottom: 1rem;
    }

    .day-section {
      flex: 1;
      min-width: 170px;
      max-width: 210px;
      background: #fff;
      border-radius: 15px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
      padding: 1rem 0.5rem 0.5rem 0.5rem;
      margin: 0 0 1rem 0;
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
      white-space: nowrap;
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

    .btn-delete-all {
      background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
      color: white;
      border: none;
      border-radius: 50px;
      padding: 0.7rem 2rem;
      font-size: 1rem;
      font-weight: 600;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(231, 76, 60, 0.2);
      margin: 0.5rem 0;
    }
    
    .btn-delete-all:hover {
      transform: translateY(-2px);
      box-shadow: 0 7px 20px rgba(231, 76, 60, 0.3);
      background: linear-gradient(135deg, #c0392b 0%, #e74c3c 100%);
      color: white;
    }
    
    .btn-delete-all i {
      margin-right: 0.5rem;
    }

    .btn-pdf-export {
      background: linear-gradient(135deg, #1565C0 0%, #0D47A1 100%);
      color: white;
      border: none;
      border-radius: 50px;
      padding: 0.7rem 2rem;
      font-size: 1rem;
      font-weight: 600;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(21, 101, 192, 0.2);
      margin: 0.5rem 0.5rem;
    }
    
    .btn-pdf-export:hover {
      transform: translateY(-2px);
      box-shadow: 0 7px 20px rgba(21, 101, 192, 0.3);
      background: linear-gradient(135deg, #0D47A1 0%, #1565C0 100%);
      color: white;
    }

    @media (max-width: 1200px) {
      .program-days-row {
        gap: 0.3rem;
      }
      .day-section {
        min-width: 160px;
        max-width: 200px;
      }
    }

    @media (max-width: 992px) {
      .program-days-row {
        gap: 0.3rem;
      }
      .day-section {
        min-width: 150px;
        max-width: 190px;
      }
    }

    @media (max-width: 768px) {
      .program-days-row {
        gap: 0.2rem;
      }
      .day-section {
        min-width: 140px;
        max-width: 180px;
        padding: 0.8rem 0.4rem 0.4rem 0.4rem;
      }
      .workout-name {
        font-size: 0.9rem;
      }
      .workout-group {
        font-size: 0.7rem;
      }
    }

    @media (max-width: 576px) {
      .program-days-row {
        flex-wrap: wrap;
        justify-content: center;
      }
      .day-section {
        min-width: 45%;
        max-width: 48%;
      }
    }
    
    @media print {
      .no-print {
        display: none !important;
      }
    }
  </style>

  <div class="container-fluid program-container">
    <h1 class="text-center mb-3" style="display: flex; align-items: center; justify-content: center; gap: 0.7rem;">
      Programlarım
      <i class="fas fa-dumbbell" style="font-size: 2rem; color: #1e3c72;"></i>
    </h1>
    
    <!-- İşlem Butonları -->
    <div class="text-center mb-4">
      <!-- PDF İndir Butonu -->
      <asp:Button 
        ID="btnExportWorkoutPDF" 
        runat="server" 
        Text="PDF Olarak İndir" 
        CssClass="btn-pdf-export" 
        OnClick="btnExportWorkoutPDF_Click"
        Visible="false"
      />
      
      <!-- Tüm Programları Silme Butonu -->
      <asp:Button 
        ID="btnDeleteAllPrograms" 
        runat="server" 
        Text="&#9888; Tüm Programları Sil" 
        CssClass="btn-delete-all" 
        OnClientClick="return confirmDeleteAll();" 
        OnClick="btnDeleteAllPrograms_Click"
        Visible="false"
      />
    </div>

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
        } catch (e) {
          console.error("Form gönderme hatası:", e);
          alert("Egzersiz günü güncellenirken bir hata oluştu. Lütfen sayfayı yenileyip tekrar deneyin.");
        }
      }
      
      draggedId = null;
      draggedDay = null;
    }
    
    // Silme işleminin ardından sayfayı yenileme
    function confirmDelete(button) {
      if (confirm('Bu hareketi silmek istediğinize emin misiniz?')) {
        // Silme işleminden sonra sayfayı yenileme kodunu kaldırıyoruz
        return true;
      }
      return false;
    }
    
    // Tüm programları silme onayı
    function confirmDeleteAll() {
      return confirm('DİKKAT: Tüm antrenman programlarınız silinecek. Bu işlem geri alınamaz! Devam etmek istediğinize emin misiniz?');
    }
    
    // Tüm silme butonlarına click event listener ekle - bu kodu da kaldırıyoruz
    $(document).ready(function() {
      // Silme butonlarına ekstra yenileme eklemeyi kaldırıyoruz
    });
  </script>
</asp:Content>
