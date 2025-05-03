# Kişiselleştirilmiş Egzersiz Planlayıcı (Fitness Program Web Forms)

Bu proje, kullanıcıların kaydolarak kişisel fitness programları oluşturabilecekleri bir ASP.NET Web Forms uygulamasıdır.

## Özellikler

- Kullanıcı kaydı ve girişi
- Kullanıcı profil bilgilerini güncelleme (boy, kilo, fitness hedefi)
- Kas gruplarına göre özelleştirilmiş egzersiz programları oluşturma
- Kaydedilen programları görüntüleme ve yönetme
- Güvenli oturum yönetimi

## Veritabanı Yapısı

### Users Tablosu
```sql
CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(100) NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    Height INT,
    Weight INT,
    Goal NVARCHAR(50)  -- 'Kas Yap', 'Kilo Ver', 'Fit Kal'
);
```

### Programs Tablosu
```sql
CREATE TABLE Programs (
    Id INT PRIMARY KEY IDENTITY,
    UserId INT FOREIGN KEY REFERENCES Users(Id),
    MuscleGroup NVARCHAR(50),  -- Göğüs, Bacak, Kardiyo vs.
    WorkoutName NVARCHAR(100),
    DateCreated DATETIME DEFAULT GETDATE()
);
```

## Sayfalar ve İşlevleri

1. **Register.aspx**: Kullanıcı kaydı işlemi (Users tablosuna INSERT)
2. **Login.aspx**: Kullanıcı girişi ve oturum başlatma (Session["UserId"])
3. **Profile.aspx**: Profil bilgilerini güncelleme (Users tablosunda UPDATE)
4. **Program.aspx**: Kas grubu seçimi ve egzersiz kaydetme (Programs tablosuna INSERT)
5. **MyProgram.aspx**: Kullanıcının kaydettiği programları görüntüleme (GridView)
6. **Logout.aspx**: Kullanıcı oturumunu sonlandırma (Session.Clear())

## Kullanılan Teknolojiler

- ASP.NET Web Forms
- Microsoft SQL Server
- ADO.NET (SqlConnection, SqlCommand, SqlDataReader)
- Bootstrap 5
- Session yönetimi

## Kurulum

1. SQL Server'da veritabanını oluşturun (App_Data/CreateDatabase.sql dosyasını kullanabilirsiniz)
2. Web.config dosyasında ConnectionString'i kendi veritabanı bağlantınıza göre güncelleyin
3. Uygulamayı çalıştırın

## Test Kullanıcısı

Veritabanı oluşturulduğunda otomatik olarak aşağıdaki test kullanıcısı eklenir:
- Kullanıcı adı: demo
- Şifre: demo123
