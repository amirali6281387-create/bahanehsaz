import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'services/storage_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // راه‌اندازی دیتابیس محلی Hive
  await Hive.initFlutter();
  await Hive.openBox('favorites');
  
  runApp(const BahanehsazApp());
}

class BahanehsazApp extends StatelessWidget {
  const BahanehsazApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StorageService(),
      child: MaterialApp(
        title: 'بهانه‌ساز حرفه‌ای',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF8A3D),
          ),
          useMaterial3: true,
          // fontFamily: 'Vazirmatn', // اگر فونت وزیرمتن رو اضافه کردی، این خط رو از کامنت دربیار
        ),
        // این بخش اپ رو کاملاً راست‌چین (فارسی) می‌کنه
        builder: (context, child) => Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}