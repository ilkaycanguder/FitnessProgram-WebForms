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
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
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
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      }
      
      .login-wrapper {
        width: 100%;
        max-width: 1000px;
        display: flex;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        border-radius: 20px;
        overflow: hidden;
      }
      
      .login-image {
        width: 50%;
        background: url('https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=1170&auto=format&fit=crop') center/cover;
        position: relative;
        display: flex;
        flex-direction: column;
        justify-content: flex-end;
        padding: 2rem;
        color: white;
      }
      
      .login-image::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(0deg, rgba(30, 60, 114, 0.8) 0%, rgba(42, 82, 152, 0.4) 100%);
      }
      
      .login-image-content {
        position: relative;
        z-index: 2;
      }
      
      .login-image h2 {
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 1rem;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
      }
      
      .login-image p {
        font-size: 1.1rem;
        opacity: 0.9;
        max-width: 80%;
      }
      
      .login-container {
        background: white;
        padding: 3rem;
        width: 50%;
        display: flex;
        flex-direction: column;
        justify-content: center;
      }
      
      .login-header {
        text-align: center;
        margin-bottom: 2.5rem;
      }
      
      .login-header h3 {
        color: #1e3c72;
        font-weight: 700;
        font-size: 2rem;
        margin-bottom: 0.5rem;
        position: relative;
        display: inline-block;
      }
      
      .login-header h3::after {
        content: '';
        position: absolute;
        bottom: -10px;
        left: 50%;
        transform: translateX(-50%);
        width: 50px;
        height: 3px;
        background: linear-gradient(90deg, #1e3c72, #2a5298);
        border-radius: 3px;
      }
      
      .login-header p {
        color: #666;
        font-size: 1.1rem;
        margin-top: 1rem;
      }
      
      .input-group {
        margin-bottom: 1.5rem;
        position: relative;
      }
      
      .input-icon {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        left: 1rem;
        color: #1e3c72;
        font-size: 1.2rem;
        z-index: 10;
      }
      
      .form-control {
        border-radius: 10px;
        padding: 1rem 1rem 1rem 3rem;
        border: 2px solid #e1e5eb;
        font-size: 1.1rem;
        transition: all 0.3s ease;
        box-shadow: none;
      }
      
      .form-control:focus {
        border-color: #1e3c72;
        box-shadow: 0 0 0 0.25rem rgba(30, 60, 114, 0.15);
      }
      
      .btn-login {
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        color: white;
        padding: 1rem;
        border-radius: 10px;
        width: 100%;
        font-weight: 600;
        font-size: 1.1rem;
        margin-top: 1rem;
        border: none;
        box-shadow: 0 4px 15px rgba(30, 60, 114, 0.3);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
      }
      
      .btn-login:hover {
        background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(30, 60, 114, 0.4);
      }
      
      .btn-login:active {
        transform: translateY(1px);
        box-shadow: 0 2px 10px rgba(30, 60, 114, 0.4);
      }
      
      .register-link {
        text-align: center;
        margin-top: 2rem;
        color: #666;
        font-size: 1.1rem;
      }
      
      .register-link a {
        color: #1e3c72;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
      }
      
      .register-link a:hover {
        color: #2a5298;
        text-decoration: underline;
      }
      
      .validation-error {
        color: #dc3545;
        font-size: 0.9rem;
        margin-top: 0.5rem;
        padding-left: 0.5rem;
        display: block;
      }
      
      @media (max-width: 992px) {
        .login-wrapper {
          flex-direction: column;
          max-width: 600px;
        }
        
        .login-image,
        .login-container {
          width: 100%;
        }
        
        .login-image {
          height: 250px;
        }
      }
      
      @media (max-width: 576px) {
        .login-container {
          padding: 2rem;
        }
        
        .login-image {
          height: 200px;
          padding: 1.5rem;
        }
        
        .login-image h2 {
          font-size: 2rem;
        }
      }
    </style>
  </head>
  <body>
    <form id="form1" runat="server">
      <div class="login-wrapper">
        <div class="login-image">
          <div class="login-image-content">
            <h2>Fitness Programı</h2>
            <p>Kişiselleştirilmiş egzersiz planlarıyla hedeflerinize daha hızlı ulaşın ve sağlıklı bir yaşam sürün.</p>
          </div>
        </div>
        
        <div class="login-container">
          <div class="login-header">
            <h3>Giriş Yap</h3>
            <p>Kişiselleştirilmiş egzersiz programınıza erişin</p>
          </div>

          <div class="input-group">
            <div class="input-icon">
              <i class="fas fa-user"></i>
            </div>
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

          <div class="input-group">
            <div class="input-icon">
              <i class="fas fa-lock"></i>
            </div>
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

          <asp:Label ID="lblMessage" runat="server" CssClass="validation-error text-center mt-3" />
        </div>
      </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
