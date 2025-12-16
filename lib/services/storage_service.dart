import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> saveTheme(bool dark) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('dark', dark);
  }

  Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dark') ?? true;
  }
}
