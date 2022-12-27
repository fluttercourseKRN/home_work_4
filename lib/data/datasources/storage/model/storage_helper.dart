import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  final SharedPreferences pref;

  StorageHelper(this.pref);
  Future<void> updateIntValues({
    required int value,
    required String key,
  }) async {
    final values = pref.getStringList(key) ?? [];
    values.add('$value');
    await pref.setStringList(key, values);
  }

  Future<List<int>> getIntValues(String key) async {
    final values = pref.getStringList(key) ?? [];
    return values.map((e) => int.parse(e)).toList();
  }

  Future<void> deleteItnValue({required int value, required String key}) async {
    final values = pref.getStringList(key) ?? [];
    if (values.isNotEmpty) {
      values.remove('$value');
      await pref.setStringList(key, values);
    }
  }
}
