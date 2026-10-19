import 'package:flutter/material.dart';
import 'excuse_screen.dart';
import 'favorites_screen.dart';

class Category {
  final String name;
  final String emoji;
  final String situation;
  const Category(this.name, this.emoji, this.situation);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const categories = [
    Category('مدرسه', '🎒', 'نمی‌خوام امروز مدرسه برم'),
    Category('کار', '💼', 'می‌خوام امروز مرخصی بگیرم'),
    Category('خانواده', '🏠', 'نمی‌تونم به مهمونی خانوادگی بیام'),
    Category('دوستان', '👥', 'می‌خوام قرار با دوستام رو کنسل کنم'),
    Category('ورزش', '⚽', 'نمی‌تونم امروز باشگاه برم'),
    Category('عروسی', '💒', 'نمی‌تونم به عروسی برم'),
    Category('قرار عاشقانه', '💕', 'می‌خوام قرار امروز رو کنسل کنم'),
    Category('دلخواه', '✏️', ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بهانه‌ساز حرفه‌ای'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF8A3D), Color(0xFFFFB347)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('بهانه همیشه هست، فقط باید قشنگش کنی! ✨',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('یک موقعیت انتخاب کن یا خودت بنویس',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('موقعیت رو انتخاب کن:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: categories.length,
                itemBuilder: (context, i) {
                  final cat = categories[i];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExcuseScreen(
                          title: cat.name,
                          initialSituation: cat.situation,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(cat.emoji,
                              style: const TextStyle(fontSize: 32)),
                          const SizedBox(height: 6),
                          Text(cat.name,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}