<div align="center">
  <p>
    <a href="#english">🇺🇸 English</a> | <a href="#turkish">🇹🇷 Türkçe</a>
  </p>
</div>

<a id="english"></a>

# SubZilla

**SubZilla** is a powerful and intuitive Flutter application designed to help you manage your monthly subscriptions, track recurring expenses, and stay in control of your budget.

With recent major updates, SubZilla now offers an even smoother experience with enhanced performance, new features, and a polished design.

<div align="center">
  <table>
    <tr>
      <td align="center" width="50%">
        <b>Home Screen</b>
        <br/>
        <img src="docs/screenshots/home-screen.png" alt="Home Screen" width="250" style="border-radius: 20px; box-shadow: 0 8px 16px rgba(0,0,0,0.2);"/>
      </td>
      <td align="center" width="50%">
        <b>Subscriptions</b>
        <br/>
        <img src="docs/screenshots/subscriptions-screen.png" alt="Subscriptions Screen" width="250" style="border-radius: 20px; box-shadow: 0 8px 16px rgba(0,0,0,0.2);"/>
      </td>
    </tr>
  </table>
</div>

## ✨ Features

- **Subscription Tracking**: Keep all your subscriptions in one place.
- **Visual Analytics**: Interactive charts to visualize your spending trends (`fl_chart`).
- **Smart Notifications**: Get notified before a payment is due, so you never miss a beat.
- **Local Database**: Your data is yours. Securely stored on your device using `sqflite`.
- **Multi-Language Support**: Available in English and Turkish (`easy_localization`).
- **Customizable Experience**: Dark mode, custom themes, and currency settings.
- **State Management**: Built with modern `Riverpod` for robust and testable code.

## 🚀 Getting Started

Follow these steps to download the source code and set up your development environment.

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
- Git installed.

### Installation

1.  **Clone the Repository**
    ```bash
    git clone https://github.com/DevOpen-io/SubZilla.git
    cd SubZilla
    ```

2.  **Install Dependencies**
    Fetch the necessary packages:
    ```bash
    flutter pub get
    ```

3.  **Run Code Generation**
    This project uses `freezed` and `riverpod_generator`. You need to run the build runner to generate the necessary files:
    ```bash
    dart run build_runner build -d
    ```

4.  **Run the Application**
    Connect a device or start an emulator, then run:
    ```bash
    flutter run
    ```

## 📖 How to Use

1.  **Add a Subscription**: Navigate to the add screen, select a brand (or create a custom one), enter the amount, and set the billing cycle.
2.  **Monitor Dashboard**: Check the home dashboard to see your total monthly/yearly expenses and upcoming payments.
3.  **Manage Settings**: Go to settings to toggle dark mode, change language, or adjust notification timing.

## 🤝 Contributing & Support

We love contributions! If you have ideas for new features or have found a bug, here is how you can help:

-   **Report Issues**: Use the [GitHub Issues](https://github.com/DevOpen-io/SubZilla/issues) tab to report bugs or request features.
-   **Submit Pull Requests**: Fork the repository, make your changes, and submit a PR. Please ensure your code follows the project's style and passes all tests.
-   **Support**: Give the project a star ⭐ to show your support!

---

<a id="turkish"></a>

# SubZilla

**SubZilla**, aylık aboneliklerinizi yönetmenize, tekrarlayan harcamalarınızı takip etmenize ve bütçenizi kontrol altında tutmanıza yardımcı olmak için tasarlanmış güçlü ve sezgisel bir Flutter uygulamasıdır.

Son büyük güncellemelerle birlikte SubZilla, gelişmiş performans, yeni özellikler ve cilalanmış bir tasarımla çok daha akıcı bir deneyim sunuyor.

<div align="center">
  <table>
    <tr>
      <td align="center" width="50%">
        <b>Ana Ekran</b>
        <br/>
        <img src="docs/screenshots/home-screen.png" alt="Home Screen" width="250" style="border-radius: 20px; box-shadow: 0 8px 16px rgba(0,0,0,0.2);"/>
      </td>
      <td align="center" width="50%">
        <b>Abonelikler</b>
        <br/>
        <img src="docs/screenshots/subscriptions-screen.png" alt="Subscriptions Screen" width="250" style="border-radius: 20px; box-shadow: 0 8px 16px rgba(0,0,0,0.2);"/>
      </td>
    </tr>
  </table>
</div>

## ✨ Özellikler

- **Abonelik Takibi**: Tüm aboneliklerinizi tek bir yerde tutun.
- **Görsel Analizler**: Harcama trendlerinizi görselleştirmek için etkileşimli grafikler (`fl_chart`).
- **Akıllı Bildirimler**: Ödeme günü yaklaşmadan bildirim alın, böylece hiçbir ödemeyi kaçırmazsınız.
- **Yerel Veritabanı**: Verileriniz size aittir. `sqflite` kullanılarak cihazınızda güvenle saklanır.
- **Çoklu Dil Desteği**: İngilizce ve Türkçe (`easy_localization`) seçenekleri mevcuttur.
- **Özelleştirilebilir Deneyim**: Karanlık mod, özel temalar ve para birimi ayarları.
- **Durum Yönetimi**: Sağlam ve test edilebilir kod için modern `Riverpod` ile oluşturulmuştur.

## 🚀 Başlarken

Kaynak kodunu indirmek ve geliştirme ortamınızı kurmak için aşağıdaki adımları izleyin.

### Ön Koşullar
- [Flutter SDK](https://flutter.dev/docs/get-started/install) yüklü olmalıdır.
- Git yüklü olmalıdır.

### Kurulum

1.  **Depoyu Klonlayın**
    ```bash
    git clone https://github.com/DevOpen-io/SubZilla.git
    cd SubZilla
    ```

2.  **Bağımlılıkları Yükleyin**
    Gerekli paketleri indirin:
    ```bash
    flutter pub get
    ```

3.  **Kod Üretimini Çalıştırın**
    Bu proje `freezed` ve `riverpod_generator` kullanır. Gerekli dosyaları oluşturmak için build runner'ı çalıştırmanız gerekir:
    ```bash
    dart run build_runner build -d
    ```

4.  **Uygulamayı Çalıştırın**
    Bir cihaz bağlayın veya emülatörü başlatın, ardından çalıştırın:
    ```bash
    flutter run
    ```

## 📖 Nasıl Kullanılır

1.  **Abonelik Ekle**: Ekle ekranına gidin, bir marka seçin (veya özel bir tane oluşturun), tutarı girin ve faturalandırma döngüsünü ayarlayın.
2.  **Paneli İzleyin**: Aylık/yıllık toplam harcamalarınızı ve yaklaşan ödemelerinizi görmek için ana paneli kontrol edin.
3.  **Ayarları Yönetin**: Karanlık modu açmak, dili değiştirmek veya bildirim zamanlamasını ayarlamak için ayarlara gidin.

## 🤝 Katkıda Bulunma ve Destek

Katkıları seviyoruz! Yeni özellikler için fikirleriniz varsa veya bir hata bulduysanız, işte nasıl yardımcı olabileceğiniz:

-   **Sorun Bildirin**: Hataları bildirmek veya özellik istemek için [GitHub Issues](https://github.com/DevOpen-io/SubZilla/issues) sekmesini kullanın.
-   **Pull Request Gönderin**: Depoyu fork'layın, değişikliklerinizi yapın ve bir PR gönderin. Lütfen kodunuzun proje stiline uyduğundan ve tüm testleri geçtiğinden emin olun.
-   **Destek**: Desteğinizi göstermek için projeye bir yıldız ⭐ verin!

---

## 📈 Star History / Yıldız Geçmişi

[![Star History Chart](https://api.star-history.com/svg?repos=DevOpen-io/SubZilla&type=Date)](https://star-history.com/#DevOpen-io/SubZilla&Date)
