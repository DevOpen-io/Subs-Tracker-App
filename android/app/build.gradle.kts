import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Groovy'deki "def" yerine Kotlin'de "val" kullanılır.
// Tek tırnak (') yerine çift tırnak (") kullanılır.
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "io.devopen.subzilla"
    compileSdk = 36 // Eğer hata alırsan bunu 34 veya 35 yapabilirsin.
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "io.devopen.subzilla"
        minSdk = flutter.minSdkVersion
        targetSdk = 33 // Genelde compileSdk ile uyumlu olması önerilir ama 33 de çalışır.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        // Kotlin DSL'de yeni bir config oluştururken create("isim") kullanılır.
        create("release") {
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            } else {
                // CI/CD Ortamı (GitHub Actions)
                storeFile = file("upload-keystore.jks")
                storePassword = System.getenv("KEY_STORE_PASSWORD")
                keyAlias = System.getenv("ALIAS")
                keyPassword = System.getenv("KEY_PASSWORD")
            }
        }
    }

    buildTypes {
        release {
            // Kotlin DSL'de atama yapılırken "=" kullanılır ve getByName ile çağrılır.
            signingConfig = signingConfigs.getByName("release")
            
            // Kotlin DSL'de "isMinifyEnabled" property'si kullanılır.
            isMinifyEnabled = false
            isShrinkResources = false
            
            // Fonksiyon çağrıları parantez içinde olmalıdır.
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.window:window:1.0.0")
    implementation("androidx.window:window-java:1.0.0")
}

flutter {
    source = "../.."
}