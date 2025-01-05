import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:habitt_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});
  @override
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _habitController = TextEditingController();
  Color selectedColor = Colors.amber; // Default color
  Map<String, String> selectedHabitsMap = {};
  Map<String, String> completedHabitsMap = {};
  final Map<String, Color> _habitColors = {
    'Amber': Colors.amber,
    'Red Accent': Colors.redAccent,
    'Light Blue': Colors.lightBlue,
    'Light Green': Colors.lightGreen,
    'Purple Accent': Colors.purpleAccent,
    'Orange': Colors.orange,
    'Teal': Colors.teal,
    'Deep Purple': Colors.deepPurple,
  };
  String selectedColorName = 'Amber'; // Default color name
  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  /*
  Future<void> _loadHabits() async {
    setState(() {
// Hardcoded habits for demonstration
      selectedHabitsMap = {
        'Workout': 'FF5733', // Color in hex (e.g., Amber)
        'Meditate': 'FF33A1',
        'Read a Book': '33FFA1',
        'Drink Water': '3380FF',
        'Practice Gratitude': 'FFC300'
      };
      completedHabitsMap = {'Wake Up Early': 'FF5733', 'Journal': 'DAF7A6'};
    });
  }
  */

  Future<void> _loadHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load habits from both maps
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

  @override
  Widget build(BuildContext context) {
// Combine both maps for display, ensuring no duplicates
    Map<String, String> allHabitsMap = {
      ...selectedHabitsMap,
      ...completedHabitsMap
    };
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF183ABC),
        foregroundColor: Colors.white,
        title: Center(
          child: Text(
            "Configure Habits",
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Habit Name',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _habitController,
              decoration: const InputDecoration(
                labelText: 'Habit Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Color:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton<String>(
                value: selectedColorName,
                isExpanded: true,
                underline: const SizedBox(),
                items: _habitColors.keys.map((String colorName) {
                  return DropdownMenuItem<String>(
                    value: colorName,
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _habitColors[colorName],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        colorName,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedColorName = newValue!;
                    selectedColor = _habitColors[selectedColorName]!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_habitController.text.isNotEmpty) {
                  setState(() {
// Add the new habit to the selectedHabitsMap with the chosen color
                    selectedHabitsMap[_habitController.text] =
                        selectedColor.value.toRadixString(16);
                    _habitController.clear();
                    selectedColorName = 'Amber'; // Reset to default
                    selectedColor = _habitColors[selectedColorName]!;
                  });
                }
              },
              child: Text(
                'Add Habit',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: allHabitsMap.entries.map((entry) {
                  final habitName = entry.key;
                  final habitColor = _getColorFromHex(entry.value);
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: habitColor,
                    ),
                    title: Text(habitName),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
// Remove habit from both maps if it exists
                          selectedHabitsMap.remove(habitName);
                          completedHabitsMap.remove(habitName);
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Add opacity if not included.
    }
    return Color(int.parse('0x$hexColor'));
  }
}
