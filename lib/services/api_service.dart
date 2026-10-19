import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ اینجا رو یادت نره! بعداً آدرس Worker خودت رو جایگزین کن
  static const String workerUrl = 'https://bahoone.amirali6281387.workers.dev/';

  static Future<String> generateExcuse({
    required String situation,
    required String tone,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(workerUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'situation': situation,
              'tone': tone,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        // چون Worker ما خروجی رو به صورت متن خالص (Text) میده، مستقیم برمی‌گردونیم
        return response.body.trim();
      } else {
        return 'خطا در تولید بهانه (کد ${response.statusCode})';
      }
    } catch (e) {
      return 'اتصال برقرار نشد. اینترنتت رو چک کن.';
    }
  }
}