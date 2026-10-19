plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // اگر اسم پکیجت چیز دیگری است، این دو خط (namespace و applicationId) را با آن هماهنگ کن
    namespace = "com.example.bahanehsaz" 
    compileSdk = 34
    
    // 🔴 این خط مهم‌ترین بخش است: تعیین نسخه پایدار NDK
    ndkVersion = "26.1.10909125"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.bahanehsaz"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
    }

    buildTypes {
        release {
            // فعلاً برای اینکه بیلد رد بشه از امضای دیباگ استفاده می‌کنیم
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}