import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static const String userNameVal = 'username';
  static const String userEmailVal = 'email';
  static const String passwordVal = 'password';
  static const String ageVal = 'age';
  static const String countryVal = 'country';
  static const String hobbiesVal = 'hobbies';
  static const String selectedHobbiesMap = 'selectedHobbiesMap';
  static const String completedHabitsMap = 'completedHabitsMap';
  static const String userLoginStatusVal = 'userLoginStatusVal';
  static const String weeklyData = 'weeklyData';
  static const String notificationsEnabled = 'notificationsEnabled';
  static const String notificationHabits = 'notificationHabits';
  static const String notificationTimes = 'notificationTimes';
}

late Future<SharedPreferences> localUser;
