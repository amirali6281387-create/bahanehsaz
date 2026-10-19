import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'services/storage_service.dart';
import 'screens/home_screen.dart';

void main() async {
  // این خط حتماً باید باشه تا دیتابیس قبل از باز شدن اپ آماده بشه
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
          // اگر فونت وزیرمتن (Vazirmatn) رو به پروژه اضافه کردی، علامت کامنت خط زیر رو بردار:
          // fontFamily: 'Vazirmatn', 
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