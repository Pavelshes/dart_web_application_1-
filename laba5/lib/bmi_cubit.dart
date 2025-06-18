import 'package:shared_preferences/shared_preferences.dart';

class BMICubit {
  Future<void> saveResult(double height, double weight, double bmi) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> results = prefs.getStringList('bmi_results') ?? [];

    String record = "$height;$weight;$bmi";
    results.add(record);

    await prefs.setStringList('bmi_results', results);
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? records = prefs.getStringList('bmi_results');

    if (records == null || records.isEmpty) return [];

    return records.map((record) {
      final parts = record.split(';');
      return {
        'height': double.parse(parts[0]),
        'weight': double.parse(parts[1]),
        'bmi': double.parse(parts[2]),
      };
    }).toList();
  }
}

class SharedPreferences {
  static Future getInstance() async {}
}