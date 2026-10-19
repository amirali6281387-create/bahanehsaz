import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../services/storage_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favs = context.watch<StorageService>().favorites;
    
    return Scaffold(
      appBar: AppBar(title: const Text('بهانه‌های ذخیره‌شده')),
      body: favs.isEmpty
          ? const Center(child: Text('هنوز هیچ بهانه‌ای ذخیره نکردی!'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final fav = favs[i];
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fav.text,
                          style: const TextStyle(fontSize: 14, height: 1.7),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.copy, size: 16),
                              label: const Text('کپی'),
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: fav.text));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('کپی شد!')),
                                );
                              },
                            ),
                            TextButton.icon(
                              icon: const Icon(Icons.delete,
                                  size: 16, color: Colors.red),
                              label: const Text('حذف',
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () => context
                                  .read<StorageService>()
                                  .removeAt(i),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}