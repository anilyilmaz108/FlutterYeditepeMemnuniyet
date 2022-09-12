# FlutterYeditepeMemnuniyet

![](https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/yeditepe.gif)

Yeditepe Üniversitesi Akademik ve Personeli Memnuniyet Uygulaması, kullanıcının Google ile giriş yaptıktan sonraki verdiği puanlandırma, görüş ve şikayetler sonrasında kurumun yapacağı çalışmalarda yol gösterici olması amacıyla tasarlanmıştır.

Bu uygulamada kullanılan teknolojiler; Flutter, Firebase Authentication, Firebase Cloud Messaging(FCM), PostgreSQL, Node.js ve Flutter’ın 3.parti paketleridir.
Uygulamamızda portu etkinleştirmek için Node.js üzerinden mevcut klasörümüze geliyoruz. node index.js komutu ile 3001 portunda local bir sunucu açıyoruz. Node.js yardımıya yazdığım kodlarda, index.js sayfası ile 3001 portunu etkinleştiriyoruz ve gerekli CRUD işlemlerinin fonksiyonlarını tanımlıyoruz. Diğer sayfamız queries.js ile bu tanımladığımız fonksiyonların işlevlerini yazıyoruz. package.json kısmında express ve pg paketleri aktif. Bu paketlerden pg sayesinde PostgreSQL ile bağlantılı olarak çalışabiliyor.

PostgreSQL kısmında bir Server şifresi ve Databases klasörüne ulaşmak için bir şifre belirliyoruz. Uygulamamda 176369 olarak bu şifreyi verdim. Yeni bir database oluşturup bu database ismini satisfactiondb koydum. Oluşturduğumuz bu satisfactiondb veri tabanında sırasıyla Schemas -> public -> Tables klasöründe yeni bir tablo oluşturuyoruz. Projemde shares ismini verdim. Oluşturduğumuz tabloya sağ tıklayıp sırasıyla Properties… -> Columns kısmında verilerimizin isimlerini ve veri tiplerini giriyoruz. Uygulamamda oluşturduğum tablo aşağıdaki gibidir.

SQL ile yazılan tablomuzun görünümü:

![](https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/2.PNG)

Bu tablo için yazılan SQL kodları: 

![](https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/1.PNG)

Save butonuna tıkladıktan sonra tablomuzun sütunları PostgreSQL içerisine eklenmiş olacaktır. Bu sütunları Postgre içerisinden görmek, güncellemek veya silmek için shares tablosuna ters tıklayıp sırasıyla View/Edit Data -> All Rows içerisinden ulaşabiliriz.

Uygulamamızın Firebase kısmında, Firebase’ de konsola giderek yeni bir proje açıyoruz. Bu proje ismine Satisfaction adını koydum. Projemizi Firebase’e entegre etmek için bize anlatılan talimatları yapıyoruz. Projemde zorunlu olmayan ama Google ile giriş yapmak için ihtiyaç duyduğumuz SHA-1 sertifikasını giriyoruz. Başarılı bir şekilde uygulamamızı Firebase’e ekledikten sonra Firebase Authentication işlemleri için Get Started diyoruz. Projede hangi yollardan giriş yapılabileceğini seçiyoruz. Bu projede sadece Google ile giriş yap seçeneğini seçtim.

Bununla birlikte Authentication işlemlerini de bitirip Firebase Cloud Messaging(FCM) kısmına tıklıyoruz. FCM işlemleri için Google Analitik’i projemize eklememiz gerekiyor. Enable Google Analytics dedikten sonra gerekli adımları izleyerek FCM’yi etkinleştiriyoruz. FCM içerisinde New campaign -> Notifications kısmına tıklıyoruz. Örnek olması için Notification title ve Notification text alanlarını doldurup Next’e tıklıyoruz. Projemizde her seferinde manuel olarak bildirim göndermemek için Target -> Topic -> Message topic kısmına uygulamada kullanılan başlığı giriyoruz. Projemizde Satisfaction olarak kullandım. Scheduling kısmında uygulamamızın ne zaman bildirim göndereceğini seçiyoruz. Projemizde bir butona bağlı olarak, butona tıklanılıp veriler girildiğinde anlık olarak bildirim gönderiliyor. Son olarak Review -> Publish dediğimizde FCM kısmını tamamlamış oluyoruz.

Uygulamamızda Flutter kısmına geldiğimizde projeyi indirip sağ üstte Get Dependencies butonuna tıklayarak projemizde pubspec.yaml içerisindeki paketlerimizin import edilmesini sağlıyoruz. Eğer yükleme sırasında versiyon veya paket sürümü hatası alınırsa pubspec.yaml -> dependencies: altındaki eklenilen paketlerin sürümlerini silip sadece paket isimleri ve iki nokta(ör: firebase_auth:) kalacak şekilde yazabilirsiniz. 

Flutter projemiz pluginleri içeren bir sayfa, main sayfası, dil desteği için bir constants sayfası, kendi widgetlarımız olan components klasörü, dil desteği için extensions klasörü, projemizde oluşturulan models klasörü, backend işlemlerindeki servislerimiz için services klasörü ve arayüzlerimizin bulunduğu views klasörü içermektedir.  Oluşturduğumuz views klasörü admin ve user klasörlerinden oluşmaktadır. Ayrıca assets klasörü altında resimlerimiz ve uygulamamızın dil desteği için json dosyaları bulunmaktadır.

Node.js ile uygulamamıza PostgreSQL bağlantısını yaptığımız kodlar:

![](https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/3.PNG)

Flutter ile uygulamamıza PostgreSQL bağlantısını yaptığımız kodlar:

![](https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/4.PNG)

Yukarıdaki resimlerde görüldüğü gibi uygulamamızın düzgün bir şekilde çalışabilmesi için istenilen verilerin birbirleri ile örtüşmesi gerekiyor. Localhost ile çalışırken emülatörde bu porta ulaşmak için 10.0.2.2 yazmamız gerekiyor. Yukarıda gördüğümüz connection verimizde, 10.0.2.2 yerine Komut İstemi(CMD) üzerinden ipconfig komutu ile IPv4 adresini veya direkt olarak localhost yazdığımızda emülatör o sunucuya bağlanamıyor. Bu yüzden eğer belirli bir hosting yoksa ve emülatörde çalışmak istiyorsak host kısmına 10.0.2.2 giriyoruz.

![](https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/5.PNG)

Yukarıda DatabaseService sayfasındaki bir kod örneğinde görüldüğü gibi 10.0.2.2 ağından her hangi bir get,post,put ve delete işlemi yapabiliyoruz.

NotificationService sayfasından Firebase yardımıyla bir bildirim göndermek ve bu bildirimi manuel olarak yapmamak için aşağıdaki kod örneğindeki "to": "/topics/Satisfaction", kısmını yazıyoruz. Buradaki Satisfaction benim projemdeki kendi isimlendirmem. O yüzden Firebase içerisindeki topics kısmı ile aynı olması koşulu ile istediğimiz bir ismi yazabiliriz. Burada ayrıca önemli bir nokta ise Server Key’imizin aşağıdaki kod örneğindeki Authorization anahtarına karşılık gelen değerle aynı olmasıdır. Server Key’imizi öğrenmek için Project Overview yanındaki ayarlar butonundan Project Settings -> Cloud Messaging altındaki Cloud Messaging API (Legacy) kısmından görebiliriz.

![](https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/6.PNG)

Yeditepe Memnuniyet Uygulaması Tüm Sayfalar:


<img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/46.PNG" width="200"/><img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/47.PNG" width="200"/><img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/48.PNG" width="200"/><img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/49.PNG" width="200"/>

<img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/50.PNG" width="200"/><img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/51.PNG" width="200"/><img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/52.PNG" width="200"/><img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/53.PNG" width="200"/>

<img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/54.PNG" width="200"/><img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/55.PNG" width="200"/><img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/56.PNG" width="200"/><img src="https://github.com/anilyilmaz108/FlutterYeditepeMemnuniyet/blob/main/github_images/57.PNG" width="200"/>
