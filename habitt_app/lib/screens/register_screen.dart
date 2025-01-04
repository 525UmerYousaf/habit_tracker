import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_icons.dart';
import '../utils/app_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController =
      TextEditingController(text: '');
  final TextEditingController _emailTextController =
      TextEditingController(text: '');
  final TextEditingController _passTextController =
      TextEditingController(text: '');
  final FocusNode _userFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  bool _obscureText = true;
  double _age = 25;
  String _country = 'United States';
  List<String> _countries = [];
  List<String> selectedHabits = [];
  List<String> availableHabits = [
    'Wake Up Early',
    'Workout',
    'Drink Water',
    'Meditate',
    'Read a Book',
    'Practice Gratitude',
    'Sleep 8 Hours',
    'Eat Healthy',
    'Journal',
    'Walk 10,000 Steps'
  ];

  @override
  void initState() {
    _fetchCountries();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _userFocusNode.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchCountries() async {
    List<String> subsetCountries = [
      'United States',
      'Canada',
      'United Kingdom',
      'Australia',
      'India',
      'Germany',
      'France',
      'Japan',
      'China',
      'Brazil',
      'South Africa'
    ];
    setState(() {
      _countries = subsetCountries;
      _countries.sort();
      _country = _countries.isNotEmpty ? _countries[0] : 'United States';
    });
  }

  void _signUp() {
    print('User want to sign up an account.');
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
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            const Text(
              'Getting Started',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Text(
              'Create an account to continue!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 25),
            Form(
              key: _signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _emailTextController,
                    autofillHints: const [AutofillHints.email],
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_userFocusNode),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (_emailTextController.text.isEmpty ||
                          _emailTextController.text.length < 3 ||
                          !_emailTextController.text.contains('@')) {
                        return 'Please eneter an valid e-mail address';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.values[0],
                      counterStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Icon(AppIcons.email_icon),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      hintText: 'xyz@gmail.com',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red.withOpacity(0.5),
                        ),
                      ),
                    ),
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _fullNameController,
                    autofillHints: const [AutofillHints.email],
                    textInputAction: TextInputAction.next,
                    focusNode: _userFocusNode,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_passFocusNode),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (_fullNameController.text.isEmpty ||
                          _fullNameController.text.length < 3) {
                        return 'Please eneter an valid user name';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.values[0],
                      counterStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Icon(AppIcons.person_icon),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      hintText: 'User XYZ',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red.withOpacity(0.5),
                        ),
                      ),
                    ),
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _passTextController,
                    autofillHints: const [AutofillHints.password],
                    focusNode: _passFocusNode,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      _passFocusNode.unfocus();
                      _signUp();
                    },
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password length should be 7 character long';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Icon(AppIcons.password_icon),
                      ),
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.values[0],
                      counterStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      hintText: '*************',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red.withOpacity(0.5),
                        ),
                      ),
                    ),
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Age: ${_age.round()}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  Slider(
                    value: _age,
                    min: 21,
                    max: 100,
                    divisions: 79,
                    activeColor: Colors.blue.shade600,
                    inactiveColor: Colors.blue.shade300,
                    onChanged: (double value) {
                      setState(() {
                        _age = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Country',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  _buildCountryDropdown(),
                  const SizedBox(height: 25),
                  Text(
                    'Select Your Habits',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: availableHabits.map(
                      (habit) {
                        final isSelected = selectedHabits.contains(habit);
                        return GestureDetector(
                          onTap: () => null,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue.shade600
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.blue.shade700),
                            ),
                            child: Text(
                              habit,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.blue.shade700,
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 75),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _passFocusNode.unfocus();
                        _signUp();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF183ABC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 15),
                      ),
                      child: const Text(
                        'SIGNUP NOW',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: DropdownButton<String>(
        value: _country,
        icon: Icon(Icons.arrow_drop_down, color: Colors.blue.shade700),
        isExpanded: true,
        underline: const SizedBox(),
        items: _countries.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 25),
                  child: Icon(
                    AppIcons.country_icon,
                    size: 15,
                  ),
                ),
                Text(value),
              ],
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _country = newValue!;
          });
        },
      ),
    );
  }
}
