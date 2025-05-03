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

1. SQL Server'da veritabanını oluşturun (Database/CreateDatabase.sql dosyasını kullanabilirsiniz)
2. Web.config dosyasında ConnectionString'i kendi veritabanı bağlantınıza göre güncelleyin
3. Uygulamayı çalıştırın

## Takım Geliştirme için Web.config Yapılandırması

Bu projede Web.config dosyası Git versiyon kontrolünden çıkarılmıştır, böylece her geliştiricinin kendi bağlantı ayarlarını kullanması sağlanır.

Web.config'i doğru şekilde kullanmak için:

1. Web.config.template dosyasını Web.config olarak kopyalayın
2. Web.config dosyasında ConnectionString'i kendi veritabanı bilgilerinizle güncelleyin
3. Web.config dosyası .gitignore listesinde olduğu için yaptığınız değişiklikler diğer geliştiricileri etkilemeyecektir

**Önemli**: Yeni bir yapılandırma değişikliği yapmanız gerektiğinde, bu değişikliği Web.config.template dosyasına da eklemeyi unutmayın, böylece takımdaki diğer kişilerin güncel yapılandırmaları almaları sağlanır.

## Test Kullanıcısı

Veritabanı oluşturulduğunda otomatik olarak aşağıdaki test kullanıcısı eklenir:

- Kullanıcı adı: demo
- Şifre: demo123
