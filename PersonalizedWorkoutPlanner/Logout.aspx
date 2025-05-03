<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="PersonalizedWorkoutPlanner.Logout" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Çıkış Yapılıyor - Kişiselleştirilmiş Egzersiz Planlayıcı</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .logout-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }
        .logout-header h2 {
            color: #1e3c72;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }
        .logout-message {
            margin-bottom: 2rem;
        }
        .btn-login {
            background: #1e3c72;
            color: white;
            padding: 0.8rem 2rem;
            border-radius: 5px;
            font-weight: 600;
            text-decoration: none;
        }
        .btn-login:hover {
            background: #2a5298;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="logout-container">
            <div class="logout-header">
                <h2>Çıkış Yapılıyor</h2>
            </div>
            <div class="logout-message">
                <p>Başarıyla çıkış yaptınız.</p>
                <p>Tekrar giriş yapmak için aşağıdaki butona tıklayabilirsiniz.</p>
            </div>
            <a href="Login.aspx" class="btn btn-login">Giriş Sayfasına Dön</a>
        </div>
    </form>
</body>
</html> 