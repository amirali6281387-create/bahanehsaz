import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/excuse.dart';
import '../services/storage_service.dart';

class ResultScreen extends StatelessWidget {
  final String excuse;
  final String situation;
  final String tone;

  const ResultScreen({
    super.key,
    required this.excuse,
    required this.situation,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بهانه‌ت آماده‌ست')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF3E6), Color(0xFFFFE0C2)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    excuse,
                    style: const TextStyle(fontSize: 17, height: 1.8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.copy),
                    label: const Text('کپی'),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: excuse));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('کپی شد!')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.share),
                    label: const Text('اشتراک'),
                    onPressed: () => Share.share(excuse),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.favorite),
                    label: const Text('ذخیره'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8A3D),
                    ),
                    onPressed: () {
                      context.read<StorageService>().add(
                            Excuse(
                              text: excuse,
                              situation: situation,
                              tone: tone,
                            ),
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ذخیره شد! ♥')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('یکی دیگه'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}