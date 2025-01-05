import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitt_app/screens/login_screen.dart';
import 'package:habitt_app/utils/app_constants.dart';
import 'package:habitt_app/utils/app_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_habit_screen.dart';
import 'notification_screen.dart';
import 'personal_info_screen.dart';
import 'report_screen.dart';

class HabitTrackerScreen extends StatefulWidget {
  final String username;
  const HabitTrackerScreen({super.key, required this.username});

  @override
  State<HabitTrackerScreen> createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  Map<String, String> selectedHabitsMap = {};
  Map<String, String> completedHabitsMap = {};
  String name = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString(AppConstants.userNameVal) ?? widget.username;
      selectedHabitsMap = Map<String, String>.from(
          jsonDecode(prefs.getString(AppConstants.selectedHobbiesMap) ?? '{}'));
      completedHabitsMap = Map<String, String>.from(
          jsonDecode(prefs.getString(AppConstants.completedHabitsMap) ?? '{}'));
    });
  }

  Future<void> _saveHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        AppConstants.selectedHobbiesMap, jsonEncode(selectedHabitsMap));
    await prefs.setString(
        AppConstants.completedHabitsMap, jsonEncode(completedHabitsMap));
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Add opacity if not included.
    }
    return Color(int.parse('0x$hexColor'));
  }

  Color _getHabitColor(String habit, Map<String, String> habitsMap) {
    String? colorHex = habitsMap[habit];
    if (colorHex != null) {
      try {
        return _getColorFromHex(colorHex);
      } catch (e) {
        print('Error parsing color for $habit: $e');
      }
    }
    return Colors.blue; // Default color in case of error.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: SvgPicture.asset(
          'assets/svg/habitt_appbar_icon.svg',
          width: 55,
          height: 55,
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF183ABC),
        automaticallyImplyLeading: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF183ABC),
              ),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(AppIcons.configuration_setting_icon,
                  color: Colors.black),
              title: const Text('Configuration'),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddHabitScreen(),
                  ),
                ).then((updatedHabits) {
                  _loadUserData(); // Reload data after returning
                });
              },
            ),
            ListTile(
              leading: const Icon(
                AppIcons.person_icon,
                color: Colors.black,
                size: 18,
              ),
              title: const Text('Personal Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalInfoScreen()),
                ).then((_) {
                  _loadUserData(); // Reload data after returning
                });
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.report_icon, color: Colors.black),
              title: const Text('Reports'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReportsScreen()),
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(AppIcons.notification_icon, color: Colors.black),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.logout_icon, color: Colors.black),
              title: const Text('Sign Out'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Are you sure?',
                      ),
                      content: Text(
                          'Once you press \'proceed\' button below, you will be logged out'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _logoutFunc();
                          },
                          child: const Text('Proceed'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              name.isNotEmpty ? "Welcome $name" : 'Loading ...',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'To Do ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 2),
                  margin: EdgeInsets.only(left: 8),
                  child: Icon(
                    AppIcons.report_icon,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
          selectedHabitsMap.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Text(
                      'Use the + button to create some habits!',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: selectedHabitsMap.length,
                    itemBuilder: (context, index) {
                      String habit = selectedHabitsMap.keys.elementAt(index);
                      Color habitColor =
                          _getHabitColor(habit, selectedHabitsMap);
                      return Dismissible(
                        key: Key(habit),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            String color = selectedHabitsMap.remove(habit)!;
                            completedHabitsMap[habit] = color;
                            _saveHabits();
                          });
                        },
                        background: Container(
                          color: Colors.green,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Swipe to Complete',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.check, color: Colors.white),
                            ],
                          ),
                        ),
                        child: _buildHabitCard(habit, habitColor),
                      );
                    },
                  ),
                ),
          const Divider(),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Done ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 2),
                  margin: EdgeInsets.only(left: 8),
                  child: Icon(
                    AppIcons.done_icon,
                    size: 22,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 2),
                  margin: EdgeInsets.only(left: 8),
                  child: Icon(
                    AppIcons.confetti_icon,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
          completedHabitsMap.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Swipe right on an activity to mark as done.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: completedHabitsMap.length,
                    itemBuilder: (context, index) {
                      String habit = completedHabitsMap.keys.elementAt(index);
                      Color habitColor =
                          _getHabitColor(habit, completedHabitsMap);
                      return Dismissible(
                        key: Key(habit),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          setState(() {
                            String color = completedHabitsMap.remove(habit)!;
                            selectedHabitsMap[habit] = color;
                            _saveHabits();
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Row(
                            children: [
                              Icon(Icons.undo, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Swipe to Undo',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        child: _buildHabitCard(habit, habitColor,
                            isCompleted: true),
                      );
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: selectedHabitsMap.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // String? storedName = prefs.getString(AppConstants.userNameVal);
                // String? storedEmail =
                //     prefs.getString(AppConstants.userEmailVal);
                // double? storedAgeVal = prefs.getDouble(AppConstants.ageVal);
                // String? storedCountryVal =
                //     prefs.getString(AppConstants.countryVal);
                // List<String>? storedHobbies =
                //     prefs.getStringList(AppConstants.hobbiesVal);
                // bool? storedSignInStatus =
                //     prefs.getBool(AppConstants.userLoginStatusVal);
                // print('**************************');
                // print('%%%%%%%%%%%%%%%%%%%%%%%%%%');
                // print('Name is:     $storedName');
                // print('Email is:    $storedEmail');
                // print('Age is:      $storedAgeVal');
                // print('Country is:  $storedCountryVal');
                // storedHobbies?.forEach((hobby) {
                //   print('Each hobby stored is: $hobby');
                // });
                // print("Sign In is:  $storedSignInStatus");
                // print('%%%%%%%%%%%%%%%%%%%%%%%%%%');
                // print('**************************');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddHabitScreen(),
                  ),
                ).then((_) {
                  _loadUserData(); // Reload data after returning
                });
              },
              backgroundColor: const Color(0xFF183ABC),
              tooltip: 'Add Habits',
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  Widget _buildHabitCard(String title, Color color,
      {bool isCompleted = false}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color,
      child: Container(
        height: 60, // Adjust the height for thicker cards.
        child: ListTile(
          title: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          trailing: isCompleted
              ? const Icon(Icons.check_circle, color: Colors.green, size: 28)
              : null,
        ),
      ),
    );
  }

  void _logoutFunc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppConstants.userLoginStatusVal, false);
    Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
