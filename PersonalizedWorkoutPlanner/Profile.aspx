<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="PersonalizedWorkoutPlanner.Profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profil - Kişiselleştirilmiş Egzersiz Planlayıcı</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
        }
        .profile-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }
        .profile-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .profile-header h2 {
            color: #1e3c72;
            font-weight: 600;
        }
        .form-control {
            border-radius: 5px;
            padding: 0.8rem;
            margin-bottom: 1rem;
        }
        .btn-update {
            background: #1e3c72;
            color: white;
            padding: 0.8rem;
            border-radius: 5px;
            width: 100%;
            font-weight: 600;
            margin-top: 1rem;
        }
        .btn-update:hover {
            background: #2a5298;
            color: white;
        }
        .nav-links {
            text-align: center;
            margin-top: 1.5rem;
            display: flex;
            justify-content: space-around;
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
        .success-message {
            color: #28a745;
            text-align: center;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="profile-container">
            <div class="profile-header">
                <h2>Profil Bilgilerim</h2>
                <p class="text-muted">Kişisel bilgilerinizi güncelleyin</p>
            </div>

            <div class="form-group">
                <label class="form-label">Boy (cm)</label>
                <asp:TextBox ID="txtHeight" runat="server" CssClass="form-control" Placeholder="Boyunuzu girin" />
                <asp:RegularExpressionValidator ID="revHeight" runat="server" ControlToValidate="txtHeight"
                    ValidationExpression="^\d+$" ErrorMessage="Lütfen geçerli bir sayı girin."
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label class="form-label">Kilo (kg)</label>
                <asp:TextBox ID="txtWeight" runat="server" CssClass="form-control" Placeholder="Kilonuzu girin" />
                <asp:RegularExpressionValidator ID="revWeight" runat="server" ControlToValidate="txtWeight"
                    ValidationExpression="^\d+$" ErrorMessage="Lütfen geçerli bir sayı girin."
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label class="form-label">Fitness Hedefi</label>
                <asp:DropDownList ID="ddlGoal" runat="server" CssClass="form-control">
                    <asp:ListItem Text="-- Hedef Seçin --" Value="" />
                    <asp:ListItem Text="Kas Yap" Value="Kas Yap" />
                    <asp:ListItem Text="Kilo Ver" Value="Kilo Ver" />
                    <asp:ListItem Text="Fit Kal" Value="Fit Kal" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvGoal" runat="server"
                    ControlToValidate="ddlGoal" InitialValue=""
                    ErrorMessage="Hedef seçiniz."
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <asp:Button ID="btnUpdate" runat="server" Text="Bilgilerimi Güncelle"
                OnClick="btnUpdate_Click" CssClass="btn btn-update" />

            <div class="nav-links">
                <a href="Program.aspx" class="btn btn-outline-primary">Program Oluştur</a>
                <a href="MyProgram.aspx" class="btn btn-outline-primary">Programlarım</a>
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="success-message" />
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 