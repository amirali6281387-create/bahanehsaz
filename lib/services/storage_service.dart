import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/excuse.dart';

class StorageService extends ChangeNotifier {
  final Box _box = Hive.box('favorites');

  List<Excuse> get favorites {
    final items = <Excuse>[];
    for (final item in _box.values) {
      if (item is Map) {
        try {
          items.add(Excuse.fromJson(Map<String, dynamic>.from(item)));
        } catch (_) {}
      }
    }
    return items.reversed.toList();
  }

  void add(Excuse excuse) {
    // جلوگیری از ذخیره تکراری
    for (final item in _box.values) {
      if (item is Map && item['text'] == excuse.text) {
        return;
      }
    }
    _box.add(excuse.toJson());
    notifyListeners();
  }

  void removeAt(int index) {
    final realIndex = _box.length - 1 - index;
    _box.deleteAt(realIndex);
    notifyListeners();
  }
}