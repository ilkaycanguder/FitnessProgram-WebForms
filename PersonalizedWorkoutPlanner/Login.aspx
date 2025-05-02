<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs"
Inherits="PersonalizedWorkoutPlanner.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Giriş Yap - Kişiselleştirilmiş Egzersiz Planlayıcı</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
      }
      .login-container {
        background: white;
        padding: 2rem;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px;
      }
      .login-header {
        text-align: center;
        margin-bottom: 2rem;
      }
      .login-header h2 {
        color: #1e3c72;
        font-weight: 600;
      }
      .form-control {
        border-radius: 5px;
        padding: 0.8rem;
        margin-bottom: 1rem;
      }
      .btn-login {
        background: #1e3c72;
        color: white;
        padding: 0.8rem;
        border-radius: 5px;
        width: 100%;
        font-weight: 600;
        margin-top: 1rem;
      }
      .btn-login:hover {
        background: #2a5298;
        color: white;
      }
      .register-link {
        text-align: center;
        margin-top: 1rem;
      }
      .validation-error {
        color: #dc3545;
        font-size: 0.875rem;
        margin-top: -0.5rem;
        margin-bottom: 0.5rem;
      }
    </style>
  </head>
  <body>
    <form id="form1" runat="server">
      <div class="login-container">
        <div class="login-header">
          <h2>Giriş Yap</h2>
          <p class="text-muted">
            Kişiselleştirilmiş egzersiz programınıza erişin
          </p>
        </div>

        <div class="form-group">
          <asp:TextBox
            ID="txtUsername"
            runat="server"
            CssClass="form-control"
            Placeholder="Kullanıcı Adı"
          />
          <asp:RequiredFieldValidator
            ID="rfvUsername"
            runat="server"
            ControlToValidate="txtUsername"
            ErrorMessage="Kullanıcı adı gerekli."
            CssClass="validation-error"
            Display="Dynamic"
          />
        </div>

        <div class="form-group">
          <asp:TextBox
            ID="txtPassword"
            runat="server"
            TextMode="Password"
            CssClass="form-control"
            Placeholder="Şifre"
          />
          <asp:RequiredFieldValidator
            ID="rfvPassword"
            runat="server"
            ControlToValidate="txtPassword"
            ErrorMessage="Şifre gerekli."
            CssClass="validation-error"
            Display="Dynamic"
          />
        </div>

        <asp:Button
          ID="btnLogin"
          runat="server"
          Text="Giriş Yap"
          OnClick="btnLogin_Click"
          CssClass="btn btn-login"
        />

        <div class="register-link">
          <p>Hesabınız yok mu? <a href="Register.aspx">Kayıt Olun</a></p>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="validation-error" />
      </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
