# PersonalizedWorkoutPlanner

Kişiselleştirilmiş Antrenman Programı Planlayıcı (ASP.NET Web Forms)

## Özellikler

- **Kullanıcı Kaydı ve Girişi:** Güvenli kullanıcı yönetimi.
- **Program Listeleme:** Kullanıcıya özel antrenman programlarının listelenmesi.
- **Filtreleme ve Sıralama:** Kas grubu ve tarihe göre filtreleme/sıralama.
- **Program Silme:** Kayıtlı programları güvenli şekilde silme.
- **CSV ve PDF Dışa Aktarım:** Programları Türkçe karakter desteğiyle CSV ve PDF olarak dışa aktarma.
- **Modern ve Duyarlı Arayüz:** Bootstrap ile şık ve kullanıcı dostu tasarım.

## Kurulum

1. **Projeyi Klonlayın**

   ```sh
   git clone <repo-url>
   ```

2. **Web.config Ayarları**

   - `Web.config` dosyasındaki bağlantı dizesini kendi veritabanınıza göre güncelleyin:
     ```xml
     <connectionStrings>
       <add name="FitnessDBConnectionString"
            connectionString="Data Source=.;Initial Catalog=FitnessDB;Integrated Security=True"
            providerName="System.Data.SqlClient" />
     </connectionStrings>
     ```

3. **NuGet Paketleri**

   - iTextSharp paketini yükleyin:
     ```
     Install-Package iTextSharp
     ```

4. **Font Desteği (PDF için)**
   - Proje kök dizinine `Fonts` klasörü oluşturun.
   - Windows'tan `arial.ttf` dosyasını bu klasöre kopyalayın (`C:\Windows\Fonts\arial.ttf`).

## Kullanım

- **Kayıt Ol:** Yeni kullanıcı oluşturun.
- **Giriş Yap:** Hesabınızla giriş yapın.
- **Program Ekle:** Antrenman programınızı oluşturun.
- **Filtrele/Sırala:** Kas grubu ve tarihe göre filtreleyin/sıralayın.
- **Sil:** Programı silin.
- **Dışa Aktar:** Programlarınızı CSV veya PDF olarak indirin.

## Teknik Notlar

- **CSV Dışa Aktarım:** UTF-8 BOM ile Türkçe karakter desteği.
- **PDF Dışa Aktarım:** Arial fontu ile tam Türkçe karakter desteği.
- **Güvenlik:** SQL Injection'a karşı parametreli sorgular, oturum kontrolü.
- **Kod Kalitesi:** Modüler, okunabilir ve sürdürülebilir kod yapısı.

## Katkı ve Geliştirme

- Pull request ve issue açarak katkıda bulunabilirsiniz.
- Kodunuzu göndermeden önce test etmeyi unutmayın.

## Lisans

MIT

---

Herhangi bir sorunda veya katkı için lütfen iletişime geçin.
