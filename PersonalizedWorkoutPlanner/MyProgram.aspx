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
      }
      .programs-container {
        background: white;
        padding: 2rem;
        border-radius: 15px;
        box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 1000px;
        margin: 0 auto;
      }
      .programs-header {
        text-align: center;
        margin-bottom: 2rem;
        padding-bottom: 1rem;
        border-bottom: 2px solid #f0f0f0;
      }
      .programs-header h2 {
        color: #1e3c72;
        font-weight: 600;
        margin-bottom: 0.5rem;
      }
      .programs-header p {
        color: #666;
        font-size: 1.1rem;
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
        padding: 0.5rem 1rem;
        border-radius: 5px;
      }
      .nav-btn:hover {
        color: #2a5298;
        background: #f8f9fa;
      }
      .btn-create {
        background: #1e3c72;
        color: white;
        padding: 0.8rem 2rem;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
      }
      .btn-create:hover {
        background: #2a5298;
        color: white;
        transform: translateY(-2px);
      }
      .grid-container {
        margin-top: 2rem;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
      }
      .grid-view {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
      }
      .grid-view th {
        background: #1e3c72;
        color: white;
        padding: 1rem;
        font-weight: 500;
        text-align: left;
      }
      .grid-view td {
        padding: 1rem;
        border-bottom: 1px solid #eee;
      }
      .grid-view tr:hover {
        background: #f8f9fa;
      }
      .empty-message {
        text-align: center;
        padding: 2rem;
        color: #666;
        font-style: italic;
      }
      .muscle-group-badge {
        background: #e3f2fd;
        color: #1e3c72;
        padding: 0.3rem 0.8rem;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 500;
      }
      .date-badge {
        background: #f5f5f5;
        color: #666;
        padding: 0.3rem 0.8rem;
        border-radius: 20px;
        font-size: 0.9rem;
      }
      .action-buttons {
        display: flex;
        gap: 0.5rem;
      }
      .btn-action {
        padding: 0.3rem 0.8rem;
        border-radius: 5px;
        font-size: 0.9rem;
        transition: all 0.3s ease;
      }
      .btn-delete {
        background: #dc3545;
        color: white;
      }
      .btn-delete:hover {
        background: #c82333;
        color: white;
      }
      .btn-export {
        background: #28a745;
        color: white;
      }
      .btn-export:hover {
        background: #218838;
        color: white;
      }
      .filter-section {
        background: #f8f9fa;
        padding: 1rem;
        border-radius: 8px;
        margin-bottom: 1.5rem;
      }
      .filter-row {
        display: flex;
        gap: 1rem;
        align-items: center;
        flex-wrap: wrap;
      }
      .filter-group {
        flex: 1;
        min-width: 200px;
      }
      .export-options {
        display: flex;
        gap: 0.5rem;
      }
      .confirmation-dialog {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        padding: 2rem;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
        z-index: 1000;
        display: none;
      }
      .dialog-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.5);
        z-index: 999;
        display: none;
      }
      .dialog-buttons {
        display: flex;
        justify-content: flex-end;
        gap: 1rem;
        margin-top: 1.5rem;
      }
    </style>
  </head>
  <body>
    <form id="form1" runat="server">
      <div class="programs-container">
        <div class="nav-buttons">
          <a href="Default.aspx" class="nav-btn"
            ><i class="fas fa-home"></i> Ana Sayfa</a
          >
          <a href="Program.aspx" class="btn-create"
            ><i class="fas fa-plus"></i> Yeni Program Oluştur</a
          >
        </div>

        <div class="programs-header">
          <h2>Kaydedilmiş Programlarım</h2>
          <p>Oluşturduğunuz antrenman programlarını görüntüleyin</p>
        </div>

        <div class="filter-section">
          <div class="filter-row">
            <div class="filter-group">
              <label class="form-label">Kas Grubuna Göre Filtrele</label>
              <asp:DropDownList
                ID="ddlFilterMuscleGroup"
                runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlFilterMuscleGroup_SelectedIndexChanged"
              >
                <asp:ListItem Text="Tümü" Value="" />
                <asp:ListItem Text="Göğüs" Value="Göğüs" />
                <asp:ListItem Text="Bacak" Value="Bacak" />
                <asp:ListItem Text="Sırt" Value="Sırt" />
                <asp:ListItem Text="Kardiyo" Value="Kardiyo" />
              </asp:DropDownList>
            </div>
            <div class="filter-group">
              <label class="form-label">Tarihe Göre Sırala</label>
              <asp:DropDownList
                ID="ddlSortByDate"
                runat="server"
                CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlSortByDate_SelectedIndexChanged"
              >
                <asp:ListItem Text="En Yeni" Value="DESC" />
                <asp:ListItem Text="En Eski" Value="ASC" />
              </asp:DropDownList>
            </div>
            <div class="filter-group">
              <label class="form-label">Dışa Aktar</label>
              <div class="export-options">
                <asp:Button
                  ID="btnExportCSV"
                  runat="server"
                  Text="CSV"
                  CssClass="btn btn-action btn-export"
                  OnClick="btnExportCSV_Click"
                />
                <asp:Button
                  ID="btnExportPDF"
                  runat="server"
                  Text="PDF"
                  CssClass="btn btn-action btn-export"
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
                      OnClientClick="return confirmDelete();"
                    >
                      <i class="fas fa-trash"></i> Sil
                    </asp:LinkButton>
                  </div>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
          </asp:GridView>
        </div>

        <asp:Label ID="lblEmpty" runat="server" CssClass="empty-message" />
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
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
      function confirmDelete() {
        document.getElementById("deleteConfirmationDialog").style.display =
          "block";
        document.getElementById("dialogOverlay").style.display = "block";
        return false;
      }

      function hideDeleteDialog() {
        document.getElementById("deleteConfirmationDialog").style.display =
          "none";
        document.getElementById("dialogOverlay").style.display = "none";
      }
    </script>
  </body>
</html>
