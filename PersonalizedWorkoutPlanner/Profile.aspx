<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="PersonalizedWorkoutPlanner.Profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profil - Kişiselleştirilmiş Egzersiz Planlayıcı</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
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
        
        .profile-wrapper {
            width: 100%;
            max-width: 900px;
            display: flex;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.2);
            border-radius: 20px;
            overflow: hidden;
        }
        
        .profile-sidebar {
            width: 35%;
            background: url('https://images.unsplash.com/photo-1545389336-cf090694435e?q=80&w=1964&auto=format&fit=crop') center/cover;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 2.5rem;
            color: white;
        }
        
        .profile-sidebar::before {
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
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }
        
        .sidebar-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 2rem;
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
            margin-right: 0.8rem;
            font-size: 1.1rem;
        }
        
        .profile-container {
            background: white;
            padding: 3rem;
            width: 65%;
            display: flex;
            flex-direction: column;
        }
        
        .profile-header {
            margin-bottom: 2.5rem;
            position: relative;
        }
        
        .profile-header h2 {
            color: #1e3c72;
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 0.8rem;
            position: relative;
            display: inline-block;
        }
        
        .profile-header h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            border-radius: 3px;
        }
        
        .profile-header p {
            color: #666;
            font-size: 1.1rem;
        }
        
        .form-group {
            margin-bottom: 1.8rem;
            position: relative;
        }
        
        .form-label {
            font-weight: 600;
            color: #1e3c72;
            margin-bottom: 0.7rem;
            display: block;
        }
        
        .input-wrapper {
            position: relative;
            width: 100%;
        }
        
        .input-icon {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            left: 1rem;
            color: #1e3c72;
            font-size: 1.2rem;
            z-index: 10;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 20px;
            text-align: center;
            pointer-events: none;
        }
        
        .form-control {
            border-radius: 12px;
            padding: 1rem 1rem 1rem 3rem;
            border: 2px solid #e1e8f3;
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
            border-radius: 12px;
            padding: 1rem 1rem 1rem 3rem;
            border: 2px solid #e1e8f3;
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
        
        .btn-update {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 1.2rem 2rem;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 8px 20px rgba(30, 60, 114, 0.3);
            margin-top: 1rem;
            position: relative;
            overflow: hidden;
        }
        
        .btn-update::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: all 0.6s ease;
        }
        
        .btn-update:hover {
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(30, 60, 114, 0.4);
        }
        
        .btn-update:hover::before {
            left: 100%;
        }
        
        .validation-error {
            color: #dc3545;
            font-size: 0.85rem;
            margin-top: 0.5rem;
            padding-left: 0.5rem;
            display: block;
        }
        
        .success-message {
            color: #155724;
            font-weight: 600;
            text-align: center;
            margin-top: 1.5rem;
            padding: 1rem;
            border-radius: 12px;
            background: #d4edda;
            border: 1px solid #c3e6cb;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            font-size: 1rem;
            display: none;
            animation: fadeIn 0.3s ease-out;
        }
        
        .success-message.show {
            display: block;
        }
        
        .error-message {
            background-color: #f8d7da !important;
            border-color: #f5c6cb !important;
            color: #721c24 !important;
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes scaleIn {
            from { transform: scale(0); }
            to { transform: scale(1); }
        }
        
        @media (max-width: 992px) {
            .profile-wrapper {
                flex-direction: column;
                max-width: 600px;
            }
            
            .profile-sidebar,
            .profile-container {
                width: 100%;
            }
            
            .profile-sidebar {
                height: 200px;
                padding: 1.5rem;
            }
        }
        
        @media (max-width: 576px) {
            .profile-container {
                padding: 2rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="profile-wrapper">
            <div class="profile-sidebar">
                <div class="sidebar-content">
                    <div class="sidebar-header">
                        <h2>Profil Bilgileri</h2>
                        <p>Kişisel bilgilerinizi yönetin ve hedeflerinizi güncelleyin</p>
                    </div>
                    
                    <div class="sidebar-nav">
                        <a href="Program.aspx" class="nav-btn">
                            <i class="fas fa-plus-circle"></i> Yeni Program Oluştur
                        </a>
                        <a href="MyProgram.aspx" class="nav-btn">
                            <i class="fas fa-list-alt"></i> Programlarımı Görüntüle
                        </a>
                        <a href="Default.aspx" class="nav-btn">
                            <i class="fas fa-home"></i> Ana Sayfa
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="profile-container">
                <div class="profile-header">
                    <h2>Profil Bilgilerimi Güncelle</h2>
                    <p>Egzersiz için gerekli istatistiklerinizi yönetin</p>
                </div>

                <div class="form-group">
                    <label class="form-label">Boy (cm)</label>
                    <div class="input-wrapper">
                        <asp:TextBox ID="txtHeight" runat="server" CssClass="form-control" Placeholder="Boyunuzu girin" />
                        <div class="input-icon">
                            <i class="fas fa-ruler-vertical"></i>
                        </div>
                    </div>
                    <asp:RegularExpressionValidator ID="revHeight" runat="server" ControlToValidate="txtHeight"
                        ValidationExpression="^\d+$" ErrorMessage="Lütfen geçerli bir sayı girin."
                        CssClass="validation-error" Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label class="form-label">Kilo (kg)</label>
                    <div class="input-wrapper">
                        <asp:TextBox ID="txtWeight" runat="server" CssClass="form-control" Placeholder="Kilonuzu girin" />
                        <div class="input-icon">
                            <i class="fas fa-weight"></i>
                        </div>
                    </div>
                    <asp:RegularExpressionValidator ID="revWeight" runat="server" ControlToValidate="txtWeight"
                        ValidationExpression="^\d+$" ErrorMessage="Lütfen geçerli bir sayı girin."
                        CssClass="validation-error" Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label class="form-label">Fitness Hedefi</label>
                    <div class="input-wrapper">
                        <asp:DropDownList ID="ddlGoal" runat="server" CssClass="form-select">
                            <asp:ListItem Text="-- Hedef Seçin --" Value="" />
                            <asp:ListItem Text="Kas Yap" Value="Kas Yap" />
                            <asp:ListItem Text="Kilo Ver" Value="Kilo Ver" />
                            <asp:ListItem Text="Fit Kal" Value="Fit Kal" />
                        </asp:DropDownList>
                        <div class="input-icon">
                            <i class="fas fa-bullseye"></i>
                        </div>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvGoal" runat="server"
                        ControlToValidate="ddlGoal" InitialValue=""
                        ErrorMessage="Lütfen bir hedef seçin."
                        CssClass="validation-error" Display="Dynamic" />
                </div>

                <asp:Button ID="btnUpdate" runat="server" Text="Bilgilerimi Güncelle"
                    OnClick="btnUpdate_Click" CssClass="btn btn-update" />

                <asp:Label ID="lblMessage" runat="server" CssClass="success-message" />
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const successMessage = document.getElementById('<%= lblMessage.ClientID %>');
            if (successMessage && successMessage.textContent.trim() !== '') {
                successMessage.classList.add('show');
                
                // Hide message after 5 seconds
                setTimeout(function() {
                    successMessage.classList.remove('show');
                }, 5000);
            }
        });
    </script>
</body>
</html> 