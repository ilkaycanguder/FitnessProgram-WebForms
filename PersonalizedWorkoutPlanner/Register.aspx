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
      
      .register-wrapper {
        width: 100%;
        max-width: 1000px;
        display: flex;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        border-radius: 20px;
        overflow: hidden;
      }
      
      .register-image {
        width: 40%;
        background: url('https://images.unsplash.com/photo-1571019613576-2b22c76fd955?q=80&w=1170&auto=format&fit=crop') center/cover;
        position: relative;
        display: flex;
        flex-direction: column;
        justify-content: flex-end;
        padding: 2rem;
        color: white;
      }
      
      .register-image::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(0deg, rgba(30, 60, 114, 0.8) 0%, rgba(42, 82, 152, 0.4) 100%);
      }
      
      .image-content {
        position: relative;
        z-index: 2;
      }
      
      .register-image h2 {
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 1rem;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
      }
      
      .register-image p {
        font-size: 1.1rem;
        opacity: 0.9;
        max-width: 80%;
      }
      
      .register-container {
        background: white;
        padding: 3rem;
        width: 60%;
        display: flex;
        flex-direction: column;
        justify-content: center;
      }
      
      .register-header {
        text-align: center;
        margin-bottom: 2.5rem;
      }
      
      .register-header h3 {
        color: #1e3c72;
        font-weight: 700;
        font-size: 2rem;
        margin-bottom: 0.5rem;
        position: relative;
        display: inline-block;
      }
      
      .register-header h3::after {
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
      
      .register-header p {
        color: #666;
        font-size: 1.1rem;
        margin-top: 1rem;
      }
      
      .register-form {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
      }
      
      .form-row {
        display: flex;
        gap: 1.5rem;
      }
      
      .form-group {
        flex: 1;
        position: relative;
      }
      
      .form-label {
        font-weight: 600;
        color: #1e3c72;
        margin-bottom: 0.7rem;
        display: block;
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
        font-size: 1rem;
        transition: all 0.3s ease;
        box-shadow: none;
        width: 100%;
      }
      
      .form-control:focus {
        border-color: #1e3c72;
        box-shadow: 0 0 0 0.25rem rgba(30, 60, 114, 0.15);
      }
      
      .form-select {
        border-radius: 10px;
        padding: 1rem 1rem 1rem 3rem;
        border: 2px solid #e1e5eb;
        font-size: 1rem;
        transition: all 0.3s ease;
        box-shadow: none;
        width: 100%;
        cursor: pointer;
        appearance: none;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%231e3c72' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 1rem center;
        background-size: 16px 12px;
      }
      
      .form-select:focus {
        border-color: #1e3c72;
        box-shadow: 0 0 0 0.25rem rgba(30, 60, 114, 0.15);
      }
      
      .btn-register {
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
      
      .btn-register:hover {
        background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(30, 60, 114, 0.4);
      }
      
      .btn-register:active {
        transform: translateY(1px);
        box-shadow: 0 2px 10px rgba(30, 60, 114, 0.4);
      }
      
      .login-link {
        text-align: center;
        margin-top: 2rem;
        color: #666;
        font-size: 1.1rem;
      }
      
      .login-link a {
        color: #1e3c72;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
      }
      
      .login-link a:hover {
        color: #2a5298;
        text-decoration: underline;
      }
      
      .validation-error {
        color: #dc3545;
        font-size: 0.85rem;
        padding-left: 0.5rem;
        display: block;
      }
      
      @media (max-width: 992px) {
        .register-wrapper {
          flex-direction: column;
          max-width: 600px;
        }
        
        .register-image,
        .register-container {
          width: 100%;
        }
        
        .register-image {
          height: 250px;
        }
        
        .form-row {
          flex-direction: column;
          gap: 1.5rem;
        }
      }
      
      @media (max-width: 576px) {
        .register-container {
          padding: 2rem;
        }
        
        .register-image {
          height: 200px;
          padding: 1.5rem;
        }
        
        .register-image h2 {
          font-size: 2rem;
        }
      }
    </style>
  </head>
  <body>
    <form id="form1" runat="server">
      <div class="register-wrapper">
        <div class="register-image">
          <div class="image-content">
            <h2>Başarıya Adım Atın</h2>
            <p>Kişiselleştirilmiş fitness programınızla hedeflerinize ulaşmak artık daha kolay.</p>
          </div>
        </div>
        
        <div class="register-container">
          <div class="register-header">
            <h3>Kayıt Ol</h3>
            <p>Kişisel bilgilerinizi girerek fitness yolculuğunuza başlayın</p>
          </div>

          <div class="register-form">
            <div class="form-group">
              <label class="form-label">Kullanıcı Adı</label>
              <div class="input-icon">
                <i class="fas fa-user"></i>
              </div>
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
              <div class="input-icon">
                <i class="fas fa-lock"></i>
              </div>
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

            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Boy (cm)</label>
                <div class="input-icon">
                  <i class="fas fa-ruler-vertical"></i>
                </div>
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
                <div class="input-icon">
                  <i class="fas fa-weight"></i>
                </div>
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
            </div>

            <div class="form-group">
              <label class="form-label">Fitness Hedefi</label>
              <div class="input-icon">
                <i class="fas fa-bullseye"></i>
              </div>
              <asp:DropDownList ID="ddlGoal" runat="server" CssClass="form-select">
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

            <asp:Label ID="lblMessage" runat="server" CssClass="validation-error text-center mt-3" />
          </div>
        </div>
      </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
