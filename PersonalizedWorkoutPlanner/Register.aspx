<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs"
Inherits="PersonalizedWorkoutPlanner.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Kayıt Ol - Kişiselleştirilmiş Egzersiz Planlayıcı</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem 0;
      }
      .register-container {
        background: white;
        padding: 2rem;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 500px;
      }
      .register-header {
        text-align: center;
        margin-bottom: 2rem;
      }
      .register-header h2 {
        color: #1e3c72;
        font-weight: 600;
      }
      .form-control {
        border-radius: 5px;
        padding: 0.8rem;
        margin-bottom: 1rem;
      }
      .btn-register {
        background: #1e3c72;
        color: white;
        padding: 0.8rem;
        border-radius: 5px;
        width: 100%;
        font-weight: 600;
        margin-top: 1rem;
      }
      .btn-register:hover {
        background: #2a5298;
        color: white;
      }
      .login-link {
        text-align: center;
        margin-top: 1rem;
      }
      .validation-error {
        color: #dc3545;
        font-size: 0.875rem;
        margin-top: -0.5rem;
        margin-bottom: 0.5rem;
      }
      .form-label {
        font-weight: 500;
        color: #1e3c72;
        margin-bottom: 0.5rem;
      }
      .form-group {
        margin-bottom: 1rem;
      }
    </style>
  </head>
  <body>
    <form id="form1" runat="server">
      <div class="register-container">
        <div class="register-header">
          <h2>Kayıt Ol</h2>
          <p class="text-muted">
            Kişiselleştirilmiş egzersiz programınızı oluşturmaya başlayın
          </p>
        </div>

        <div class="form-group">
          <label class="form-label">Kullanıcı Adı</label>
          <asp:TextBox
            ID="txtUsername"
            runat="server"
            CssClass="form-control"
            Placeholder="Kullanıcı adınızı girin"
          />
          <asp:RequiredFieldValidator
            ID="rfvUsername"
            runat="server"
            ControlToValidate="txtUsername"
            ErrorMessage="Kullanıcı adı zorunludur."
            CssClass="validation-error"
            Display="Dynamic"
          />
        </div>

        <div class="form-group">
          <label class="form-label">Şifre</label>
          <asp:TextBox
            ID="txtPassword"
            runat="server"
            TextMode="Password"
            CssClass="form-control"
            Placeholder="Şifrenizi girin"
          />
          <asp:RequiredFieldValidator
            ID="rfvPassword"
            runat="server"
            ControlToValidate="txtPassword"
            ErrorMessage="Şifre zorunludur."
            CssClass="validation-error"
            Display="Dynamic"
          />
        </div>

        <div class="form-group">
          <label class="form-label">Boy (cm)</label>
          <asp:TextBox
            ID="txtHeight"
            runat="server"
            CssClass="form-control"
            Placeholder="Boyunuzu girin"
          />
          <asp:RequiredFieldValidator
            ID="rfvHeight"
            runat="server"
            ControlToValidate="txtHeight"
            ErrorMessage="Boy gerekli."
            CssClass="validation-error"
            Display="Dynamic"
          />
        </div>

        <div class="form-group">
          <label class="form-label">Kilo (kg)</label>
          <asp:TextBox
            ID="txtWeight"
            runat="server"
            CssClass="form-control"
            Placeholder="Kilonuzu girin"
          />
          <asp:RequiredFieldValidator
            ID="rfvWeight"
            runat="server"
            ControlToValidate="txtWeight"
            ErrorMessage="Kilo gerekli."
            CssClass="validation-error"
            Display="Dynamic"
          />
        </div>

        <div class="form-group">
          <label class="form-label">Fitness Hedefi</label>
          <asp:DropDownList ID="ddlGoal" runat="server" CssClass="form-control">
            <asp:ListItem Text="-- Hedef Seçin --" Value="" />
            <asp:ListItem Text="Kas Yap" Value="Kas Yap" />
            <asp:ListItem Text="Kilo Ver" Value="Kilo Ver" />
            <asp:ListItem Text="Fit Kal" Value="Fit Kal" />
          </asp:DropDownList>
          <asp:RequiredFieldValidator
            ID="rfvGoal"
            runat="server"
            ControlToValidate="ddlGoal"
            InitialValue=""
            ErrorMessage="Hedef seçiniz."
            CssClass="validation-error"
            Display="Dynamic"
          />
        </div>

        <asp:Button
          ID="btnRegister"
          runat="server"
          Text="Kayıt Ol"
          OnClick="btnRegister_Click"
          CssClass="btn btn-register"
        />

        <div class="login-link">
          <p>Zaten hesabınız var mı? <a href="Login.aspx">Giriş Yapın</a></p>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="validation-error" />
      </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
