<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyProgram.aspx.cs"
Inherits="PersonalizedWorkoutPlanner.MyProgram" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Programlarım - Kişiselleştirilmiş Egzersiz Planlayıcı</title>
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
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      }
      
      .programs-wrapper {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        border-radius: 20px;
        overflow: hidden;
      }
      
      .programs-sidebar {
        width: 30%;
        background: url('https://images.unsplash.com/photo-1599058917212-d750089bc07e?q=80&w=1169&auto=format&fit=crop') center/cover;
        position: relative;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        padding: 2rem;
        color: white;
      }
      
      .programs-sidebar::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(0deg, rgba(30, 60, 114, 0.9) 0%, rgba(42, 82, 152, 0.7) 100%);
      }
      
      .sidebar-content {
        position: relative;
        z-index: 2;
      }
      
      .sidebar-header h2 {
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 1.5rem;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
      }
      
      .sidebar-stats {
        margin-top: 2rem;
      }
      
      .stat-card {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 15px;
        padding: 1.5rem;
        margin-bottom: 1rem;
        backdrop-filter: blur(5px);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      }
      
      .stat-card h3 {
        font-size: 1.4rem;
        margin-bottom: 0.5rem;
        font-weight: 600;
      }
      
      .stat-card p {
        margin: 0;
        font-size: 2.2rem;
        font-weight: 700;
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
        margin-right: 0.5rem;
        font-size: 1.1rem;
      }
      
      .btn-create {
        background: white;
        color: #1e3c72;
        border: none;
      }
      
      .btn-create:hover {
        background: white;
        color: #1e3c72;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
      }
      
      .programs-container {
        background: white;
        padding: 2.5rem;
        width: 70%;
        overflow-y: auto;
      }
      
      .programs-header {
        margin-bottom: 2rem;
        position: relative;
      }
      
      .programs-header h2 {
        color: #1e3c72;
        font-weight: 700;
        font-size: 1.8rem;
        margin-bottom: 0.8rem;
        position: relative;
        display: inline-block;
      }
      
      .programs-header h2::after {
        content: '';
        position: absolute;
        bottom: -10px;
        left: 0;
        width: 50px;
        height: 3px;
        background: linear-gradient(90deg, #1e3c72, #2a5298);
        border-radius: 3px;
      }
      
      .programs-header p {
        color: #666;
        font-size: 1.1rem;
      }
      
      .filter-section {
        background: linear-gradient(to right, #f8f9fa, #f0f4f8);
        padding: 1.5rem;
        border-radius: 15px;
        margin-bottom: 2rem;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.03);
        border: 1px solid #eaeef3;
      }
      
      .filter-row {
        display: flex;
        gap: 1.5rem;
        align-items: center;
        flex-wrap: wrap;
      }
      
      .filter-group {
        flex: 1;
        min-width: 200px;
      }
      
      .form-label {
        font-weight: 600;
        color: #1e3c72;
        margin-bottom: 0.7rem;
        font-size: 0.95rem;
      }
      
      .custom-select {
        background-color: white;
        border: 2px solid #e1e8f3;
        border-radius: 10px;
        padding: 0.8rem 1rem;
        font-weight: 500;
        color: #555;
        transition: all 0.3s ease;
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.02);
      }
      
      .custom-select:focus {
        border-color: #1e3c72;
        box-shadow: 0 0 0 0.2rem rgba(30, 60, 114, 0.15);
      }
      
      .export-buttons {
        display: flex;
        gap: 1rem;
      }
      
      .btn-export {
        flex: 1;
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        color: white;
        border: none;
        padding: 0.8rem 1rem;
        border-radius: 10px;
        font-weight: 600;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        box-shadow: 0 4px 10px rgba(30, 60, 114, 0.2);
      }
      
      .btn-export:hover {
        background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
        transform: translateY(-3px);
        box-shadow: 0 6px 15px rgba(30, 60, 114, 0.3);
      }
      
      .grid-container {
        background: white;
        border-radius: 15px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        overflow: hidden;
        border: 1px solid #eaeef3;
      }
      
      .grid-view {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
      }
      
      .grid-view th {
        background: linear-gradient(to right, #f0f4f8, #f8f9fa);
        color: #1e3c72;
        font-weight: 600;
        padding: 1.2rem 1rem;
        text-align: left;
        border-bottom: 2px solid #e1e8f3;
        font-size: 1rem;
      }
      
      .grid-view td {
        padding: 1.2rem 1rem;
        border-bottom: 1px solid #eaeef3;
        color: #444;
        vertical-align: middle;
      }
      
      .grid-view tr:nth-child(even) {
        background-color: #f8fafd;
      }
      
      .grid-view tr:last-child td {
        border-bottom: none;
      }
      
      .grid-view tr:hover {
        background: #f0f6ff;
      }
      
      .empty-message {
        text-align: center;
        padding: 3rem 2rem;
        color: #666;
        font-style: italic;
        font-size: 1.1rem;
      }
      
      .muscle-group-badge {
        background: linear-gradient(135deg, #e3f2fd 0%, #dae9fb 100%);
        color: #1e3c72;
        padding: 0.5rem 1rem;
        border-radius: 30px;
        font-size: 0.9rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        box-shadow: 0 3px 8px rgba(30, 60, 114, 0.1);
      }
      
      .muscle-group-badge i {
        margin-right: 0.5rem;
      }
      
      .date-badge {
        background: #f5f5f5;
        color: #555;
        padding: 0.5rem 1rem;
        border-radius: 30px;
        font-size: 0.9rem;
        display: inline-flex;
        align-items: center;
      }
      
      .date-badge i {
        margin-right: 0.5rem;
        color: #777;
      }
      
      .action-buttons {
        display: flex;
        gap: 0.8rem;
      }
      
      .btn-action {
        padding: 0.7rem 1rem;
        border-radius: 10px;
        font-size: 0.9rem;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border: none;
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
      }
      
      .btn-action i {
        margin-right: 0.5rem;
      }
      
      .btn-delete {
        background: linear-gradient(135deg, #ff4a4a 0%, #dc3545 100%);
        color: white;
      }
      
      .btn-delete:hover {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 5px 10px rgba(220, 53, 69, 0.2);
      }
      
      .confirmation-dialog {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        padding: 2.5rem;
        border-radius: 15px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        z-index: 1000;
        display: none;
        width: 400px;
        text-align: center;
      }
      
      .confirmation-dialog h4 {
        color: #1e3c72;
        font-weight: 700;
        margin-bottom: 1rem;
        font-size: 1.4rem;
      }
      
      .confirmation-dialog p {
        color: #555;
        font-size: 1.1rem;
        margin-bottom: 1.5rem;
      }
      
      .dialog-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.6);
        z-index: 999;
        display: none;
        backdrop-filter: blur(3px);
      }
      
      .dialog-buttons {
        display: flex;
        justify-content: center;
        gap: 1rem;
        margin-top: 1.5rem;
      }
      
      .dialog-buttons .btn {
        padding: 0.8rem 1.5rem;
        border-radius: 10px;
        font-weight: 600;
        min-width: 120px;
      }
      
      @media (max-width: 992px) {
        .programs-wrapper {
          flex-direction: column;
          max-width: 800px;
        }
        
        .programs-sidebar,
        .programs-container {
          width: 100%;
        }
        
        .programs-sidebar {
          padding: 2.5rem;
        }
        
        .sidebar-stats {
          display: flex;
          flex-wrap: wrap;
          gap: 1rem;
        }
        
        .stat-card {
          flex: 1;
          min-width: 150px;
          margin-bottom: 0;
        }
        
        .sidebar-nav {
          display: flex;
          gap: 1rem;
          margin-top: 2rem;
        }
        
        .nav-btn {
          flex: 1;
          margin-bottom: 0;
        }
      }
      
      @media (max-width: 768px) {
        .programs-container {
          padding: 2rem;
        }
        
        .sidebar-stats {
          flex-direction: column;
        }
        
        .sidebar-nav {
          flex-direction: column;
        }
        
        .grid-view td, 
        .grid-view th {
          padding: 1rem 0.8rem;
        }
      }
      
      @media (max-width: 576px) {
        .programs-sidebar {
          padding: 1.5rem;
        }
        
        .grid-view {
          font-size: 0.9rem;
        }
      }
    </style>
  </head>
  <body>
    <form id="form1" runat="server">
      <div class="programs-wrapper">
        <div class="programs-sidebar">
          <div class="sidebar-content">
            <div class="sidebar-header">
              <h2>Fitness Programlarım</h2>
              <p>Antrenman programlarınızı düzenleyin ve takip edin</p>
            </div>
            
            <div class="sidebar-stats">
              <div class="stat-card">
                <h3>Toplam Egzersiz</h3>
                <p><asp:Literal ID="litTotalWorkouts" runat="server" /></p>
              </div>
              <div class="stat-card">
                <h3>Kas Grupları</h3>
                <p><asp:Literal ID="litMuscleGroups" runat="server" /></p>
              </div>
            </div>
            
            <div class="sidebar-nav">
              <a href="Program.aspx" class="nav-btn btn-create">
                <i class="fas fa-plus"></i> Yeni Program Oluştur
              </a>
              <a href="Default.aspx" class="nav-btn">
                <i class="fas fa-home"></i> Ana Sayfa
              </a>
            </div>
          </div>
        </div>
        
        <div class="programs-container">
          <div class="programs-header">
            <h2>Kaydedilmiş Programlarım</h2>
            <p>Oluşturduğunuz antrenman programlarını görüntüleyin ve yönetin</p>
          </div>

          <div class="filter-section">
            <div class="filter-row">
              <div class="filter-group">
                <label class="form-label">Kas Grubuna Göre Filtrele</label>
                <asp:DropDownList
                  ID="ddlFilterMuscleGroup"
                  runat="server"
                  CssClass="form-control custom-select"
                  AutoPostBack="true"
                  OnSelectedIndexChanged="ddlFilterMuscleGroup_SelectedIndexChanged"
                >
                  <asp:ListItem Text="Tümü" Value="" />
                  <asp:ListItem Text="Göğüs" Value="Göğüs" />
                  <asp:ListItem Text="Bacak" Value="Bacak" />
                  <asp:ListItem Text="Sırt" Value="Sırt" />
                  <asp:ListItem Text="Omuz" Value="Omuz" />
                  <asp:ListItem Text="Kol" Value="Kol" />
                  <asp:ListItem Text="Karın" Value="Karın" />
                  <asp:ListItem Text="Kardiyo" Value="Kardiyo" />
                </asp:DropDownList>
              </div>
              <div class="filter-group">
                <label class="form-label">Tarihe Göre Sırala</label>
                <asp:DropDownList
                  ID="ddlSortByDate"
                  runat="server"
                  CssClass="form-control custom-select"
                  AutoPostBack="true"
                  OnSelectedIndexChanged="ddlSortByDate_SelectedIndexChanged"
                >
                  <asp:ListItem Text="En Yeni" Value="DESC" />
                  <asp:ListItem Text="En Eski" Value="ASC" />
                </asp:DropDownList>
              </div>
              <div class="filter-group">
                <label class="form-label">Dışa Aktar</label>
                <div class="export-buttons">
                  <asp:Button
                    ID="btnExportCSV"
                    runat="server"
                    Text="CSV İndir"
                    CssClass="btn btn-export"
                    OnClick="btnExportCSV_Click"
                  />
                  <asp:Button
                    ID="btnExportPDF"
                    runat="server"
                    Text="PDF İndir"
                    CssClass="btn btn-export"
                    OnClick="btnExportPDF_Click"
                  />
                </div>
              </div>
            </div>
          </div>

          <div class="grid-container">
            <asp:GridView
              ID="gvPrograms"
              runat="server"
              AutoGenerateColumns="False"
              CssClass="grid-view"
              GridLines="None"
              ShowHeaderWhenEmpty="true"
              OnRowCommand="gvPrograms_RowCommand"
            >
              <Columns>
                <asp:TemplateField HeaderText="Kas Grubu">
                  <ItemTemplate>
                    <span class="muscle-group-badge">
                      <i class="fas fa-dumbbell"></i> <%# Eval("MuscleGroup") %>
                    </span>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="WorkoutName" HeaderText="Egzersiz" />
                <asp:TemplateField HeaderText="Tarih">
                  <ItemTemplate>
                    <span class="date-badge">
                      <i class="far fa-calendar-alt"></i> <%# Eval("DateCreated",
                      "{0:dd.MM.yyyy HH:mm}") %>
                    </span>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="İşlemler">
                  <ItemTemplate>
                    <div class="action-buttons">
                      <asp:LinkButton
                        ID="btnDelete"
                        runat="server"
                        CssClass="btn btn-action btn-delete"
                        CommandName="DeleteProgram"
                        CommandArgument='<%# Eval("Id") %>'
                      >
                        <i class="fas fa-trash"></i> Sil
                      </asp:LinkButton>
                    </div>
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
              <EmptyDataTemplate>
                <div class="empty-message">
                  <i class="fas fa-info-circle me-2"></i> Henüz kaydedilmiş antrenman programınız bulunmamaktadır.
                </div>
              </EmptyDataTemplate>
            </asp:GridView>
          </div>

          <asp:Label ID="lblEmpty" runat="server" CssClass="empty-message" />
        </div>
      </div>

      <!-- Silme Onay Dialog -->
      <div id="deleteConfirmationDialog" class="confirmation-dialog">
        <h4>Programı Sil</h4>
        <p>Bu programı silmek istediğinizden emin misiniz?</p>
        <div class="dialog-buttons">
          <asp:Button
            ID="btnConfirmDelete"
            runat="server"
            Text="Evet, Sil"
            CssClass="btn btn-delete"
            OnClick="btnConfirmDelete_Click"
          />
          <asp:Button
            ID="btnCancelDelete"
            runat="server"
            Text="İptal"
            CssClass="btn btn-secondary"
            OnClientClick="hideDeleteDialog(); return false;"
          />
        </div>
      </div>
      <div id="dialogOverlay" class="dialog-overlay"></div>
      
      <!-- Hidden field to store program ID to delete -->
      <asp:HiddenField ID="hdnProgramIdToDelete" runat="server" />
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
      function hideDeleteDialog() {
        document.getElementById("deleteConfirmationDialog").style.display = "none";
        document.getElementById("dialogOverlay").style.display = "none";
      }
    </script>
  </body>
</html>
