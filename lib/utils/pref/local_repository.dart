//
// import 'package:university_app/utils/pref/pref_manager.dart';
//
// class LocalRepository{
//   LocalRepository._();
//   static final LocalRepository _singleton = LocalRepository._internal();
//
//   factory LocalRepository() => _singleton;
//
//   LocalRepository._internal();
//
//   bool get isLoggedIn => PrefManager.db.isLoggedIn;
//
//   Future<void> setIsLoggedIn(bool value) async {
//     await PrefManager.db.setIsLoggedIn(value);
//   }
//
//   bool get isOnboarded => PrefManager.db.isOnboarded;
//
//   Future<void> setIsOnboarded(bool value)async{
//     await PrefManager.db.setIsOnboarded(value);
//   }
// }