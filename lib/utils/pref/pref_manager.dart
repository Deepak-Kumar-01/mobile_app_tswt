import 'package:hive/hive.dart';

class PrefManager {
  PrefManager._();
  static final PrefManager db = PrefManager._();

  Box<dynamic>? _box;

  Future<void> init() async {
    if (_box != null && _box!.isOpen) {
      return;
    }
    _box = await Hive.openBox('prefsBox');
  }
  //getter
  bool get isLoggedIn => _box?.get('isLoggedIn', defaultValue: false) ?? false;
  //setter
  Future<void> setIsLoggedIn(bool value) async {
    await _box?.put('isLoggedIn', value);
  }
  //getter
  bool get isOnboarded => _box?.get('isOnboarded', defaultValue: false) ?? false;

  //setter
  Future<void> setIsOnboarded(bool value) async {
    await _box?.put('isOnboarded', value);
  }
}
