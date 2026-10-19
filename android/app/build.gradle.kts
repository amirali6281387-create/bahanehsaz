plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // ⚠️ نکته: اگر اسم پکیجت چیز دیگری است، این خط و خط applicationId را با آن هماهنگ کن
    namespace = "com.example.bahanehsaz" 
    
    compileSdk = 34 // نسخه اندروید برای کامپایل

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.bahanehsaz" // شناسه یکتای اپ شما در مایکت
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
    }

    buildTypes {
        release {
            // فعلاً برای اینکه بیلد رد بشه از امضای دیباگ استفاده میکنیم
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}