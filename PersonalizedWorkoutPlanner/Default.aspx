<%@ Page Title="Ana Sayfa" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PersonalizedWorkoutPlanner._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .hero-section {
            background: linear-gradient(135deg, rgba(30, 60, 114, 0.9) 0%, rgba(42, 82, 152, 0.85) 100%), url('https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=1170&auto=format&fit=crop') center/cover no-repeat;
            padding: 5rem 0;
            margin-bottom: 4rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            color: white;
            text-align: center;
        }
        
        .hero-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }
        
        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 2.5rem;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
            opacity: 0.9;
        }
        
        .hero-buttons {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .btn-hero {
            padding: 1rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: white;
            color: #1e3c72;
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-primary:hover {
            background: white;
            color: #1e3c72;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        
        .btn-outline-primary {
            background: transparent;
            color: white;
            border: 2px solid white;
        }
        
        .btn-outline-primary:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border-color: white;
            transform: translateY(-3px);
        }
        
        .feature-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.05);
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }
        
        .feature-img {
            height: 200px;
            object-fit: cover;
        }
        
        .card-body {
            padding: 2rem;
        }
        
        .card-title {
            color: #1e3c72;
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 1rem;
            position: relative;
            display: inline-block;
        }
        
        .card-title::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 40px;
            height: 3px;
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            border-radius: 3px;
        }
        
        .card-text {
            color: #555;
            font-size: 1rem;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        
        .card-footer {
            padding: 1.5rem 2rem;
            background: linear-gradient(to right, #f8f9fa, #f0f4f8);
            border-top: 1px solid #eaeef3;
        }
        
        .btn-card {
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            border: none;
        }
        
        .btn-card:hover {
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(30, 60, 114, 0.2);
            color: white;
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 3rem;
            color: #1e3c72;
            font-weight: 700;
            font-size: 2.2rem;
            position: relative;
            display: inline-block;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            border-radius: 3px;
        }
        
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-subtitle {
                font-size: 1.1rem;
            }
            
            .hero-buttons {
                flex-direction: column;
                gap: 1rem;
            }
            
            .btn-hero {
                width: 100%;
                max-width: 300px;
                margin: 0 auto;
            }
        }
    </style>

    <main>
        <section class="hero-section">
            <div class="container">
                <h1 class="hero-title">Kişiselleştirilmiş Egzersiz Planlayıcı</h1>
                <p class="hero-subtitle">Fitness hedeflerinize ulaşmak için profesyonel olarak tasarlanmış, kişiselleştirilmiş antrenman programları oluşturun ve sağlıklı bir yaşam için ilk adımı atın.</p>
                
                <div class="hero-buttons">
                    <a href="Register.aspx" class="btn btn-hero btn-primary">Hemen Başla</a>
                    <a href="Login.aspx" class="btn btn-hero btn-outline-primary">Giriş Yap</a>
                </div>
            </div>
        </section>

        <div class="container">
            <h2 class="section-title mb-5">Fitness Hedefleriniz</h2>
            
            <div class="row g-4 mb-5">
                <div class="col-md-4">
                    <div class="card feature-card">
                        <img src="https://images.unsplash.com/photo-1532029837206-abbe2b7620e3?q=80&w=1170&auto=format&fit=crop" class="card-img-top feature-img" alt="Kas Yapma">
                        <div class="card-body">
                            <h2 class="card-title">Kas Yapın</h2>
                            <p class="card-text">
                                Profesyonel antrenörler tarafından hazırlanan egzersiz programlarımızla kas kütlenizi artırın. İhtiyacınıza uygun şekilde tasarlanmış kas geliştirme programları ile vücudunuzu şekillendirin.
                            </p>
                        </div>
                        <div class="card-footer bg-transparent">
                            <a class="btn btn-card" href="Program.aspx">Program Oluştur</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card feature-card">
                        <img src="https://images.unsplash.com/photo-1486739985386-d4fae04ca6f7?q=80&w=1072&auto=format&fit=crop" class="card-img-top feature-img" alt="Kilo Verme">
                        <div class="card-body">
                            <h2 class="card-title">Kilo Verin</h2>
                            <p class="card-text">
                                Etkili kilo verme programları ile fazla kilolarınızdan kurtulun. Kardiyovasküler egzersizler ve yüksek yoğunluklu antrenmanlar ile yağ yakımını hızlandırın.
                            </p>
                        </div>
                        <div class="card-footer bg-transparent">
                            <a class="btn btn-card" href="Program.aspx">Program Oluştur</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card feature-card">
                        <img src="https://images.unsplash.com/photo-1599058917212-d750089bc07e?q=80&w=1169&auto=format&fit=crop" class="card-img-top feature-img" alt="Fit Kalma">
                        <div class="card-body">
                            <h2 class="card-title">Fit Kalın</h2>
                            <p class="card-text">
                                Düzenli egzersiz programlarıyla formunuzu koruyun. Dengeli ve sürdürülebilir antrenman rutinleriyle her gün enerjik hissedin ve sağlıklı bir yaşam sürün.
                            </p>
                        </div>
                        <div class="card-footer bg-transparent">
                            <a class="btn btn-card" href="Program.aspx">Program Oluştur</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

</asp:Content>
