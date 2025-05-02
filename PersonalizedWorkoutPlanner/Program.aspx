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
        max-width: 800px;
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
      .workout-list {
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 0.5rem;
        background: #f8f9fa;
      }
      .btn-save {
        background: #1e3c72;
        color: white;
        padding: 0.8rem 2rem;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s ease;
        width: 100%;
        margin-top: 1rem;
      }
      .btn-save:hover {
        background: #2a5298;
        color: white;
        transform: translateY(-2px);
      }
      .success-message {
        color: #28a745;
        font-weight: 500;
        text-align: center;
        margin-top: 1rem;
        padding: 0.5rem;
        border-radius: 5px;
        background: #e8f5e9;
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
          <p>Hedeflerinize uygun egzersizleri seçin</p>
        </div>

        <div class="form-group">
          <label class="form-label">Kas Grubu</label>
          <asp:DropDownList
            ID="ddlMuscleGroup"
            runat="server"
            CssClass="form-control"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlMuscleGroup_SelectedIndexChanged"
          >
            <asp:ListItem Text="-- Kas Grubu Seçin --" Value="" />
            <asp:ListItem Text="Göğüs" Value="Göğüs" />
            <asp:ListItem Text="Bacak" Value="Bacak" />
            <asp:ListItem Text="Sırt" Value="Sırt" />
            <asp:ListItem Text="Kardiyo" Value="Kardiyo" />
          </asp:DropDownList>
        </div>

        <div class="form-group">
          <label class="form-label">Egzersizler</label>
          <div class="workout-list">
            <asp:ListBox
              ID="lstWorkouts"
              runat="server"
              CssClass="form-control"
              SelectionMode="Multiple"
              Height="200px"
            />
          </div>
          <small class="text-muted"
            >Birden fazla egzersiz seçmek için CTRL tuşuna basılı tutun</small
          >
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
  </body>
</html>
