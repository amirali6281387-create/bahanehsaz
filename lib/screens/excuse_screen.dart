import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class ExcuseScreen extends StatefulWidget {
  final String title;
  final String initialSituation;

  const ExcuseScreen({
    super.key,
    required this.title,
    required this.initialSituation,
  });

  @override
  State<ExcuseScreen> createState() => _ExcuseScreenState();
}

class _ExcuseScreenState extends State<ExcuseScreen> {
  late TextEditingController _controller;
  String _tone = 'بامزه';
  bool _loading = false;

  final _tones = ['رسمی', 'بامزه', 'احساسی', 'کوتاه', 'خلاق'];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialSituation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اول موقعیت رو بنویس!')),
      );
      return;
    }
    setState(() => _loading = true);
    final excuse = await ApiService.generateExcuse(
      situation: text,
      tone: _tone,
    );
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          excuse: excuse,
          situation: text,
          tone: _tone,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('موقعیت رو بنویس یا ویرایش کن:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'مثلاً: نمی‌خوام امروز سر کلاس برم',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('لحن بهانه:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tones.map((t) {
                final selected = t == _tone;
                return ChoiceChip(
                  label: Text(t),
                  selected: selected,
                  onSelected: (_) => setState(() => _tone = t),
                  selectedColor: const Color(0xFFFF8A3D),
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black87,
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton(
                onPressed: _loading ? null : _generate,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8A3D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: _loading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text('بهانه بساز ✨',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text('فقط برای سرگرمی',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}