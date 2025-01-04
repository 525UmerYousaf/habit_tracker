import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitt_app/utils/app_router.dart';

import '../utils/app_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passFocusNode = FocusNode();

  // Default credentials
  final String defaultUsername = 'testuser';
  final String defaultPassword = 'password123';

  void _login() {
    // The login logic goes here
    var isValid = _loginFormKey.currentState!.validate();
    if (isValid) {
      if (_usernameController.text == defaultUsername &&
          _passwordController.text == defaultPassword) {
        // Navigator.of(context).pushNamed(
        //     RouteNames.forgetPasswordScreen);
      } else {
        print('User want to continue with different credential');
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade900],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.topLeft,
                      child: SvgPicture.asset(
                        'assets/svg/habitt_icon.svg',
                        width: 125,
                        height: 125,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Let\'s SIGNIN',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'Welcome back, you\'ve been missed',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Form(
                      key: _loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Username or Email',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _usernameController,
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(_passFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (_usernameController.text.isEmpty ||
                                  _usernameController.text.length < 3) {
                                return 'Please eneter an valid e-mail address or username';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.values[0],
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
                            'Password',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _passwordController,
                            autofillHints: const [AutofillHints.password],
                            focusNode: _passFocusNode,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              _passFocusNode.unfocus();
                              _login();
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.values[0],
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
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(top: 5, right: 5),
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.of(context).pushNamed(
                                //     RouteNames.forgetPasswordScreen);
                              },
                              child: Stack(
                                children: <Widget>[
                                  const Text(
                                    'Forgot Password ?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -1,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                        height: 2.0, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 75),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _passFocusNode.unfocus();
                                _login();
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
                                'LOGIN NOW',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account ?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      print('User want to enter register screen');
                      Navigator.of(context)
                          .pushNamed(RouteNames.registerScreen);
                    },
                    child: Stack(
                      children: <Widget>[
                        const Text(
                          'SIGNUP NOW',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        Positioned(
                          bottom: -1,
                          left: 0,
                          right: 0,
                          child: Container(height: 2.0, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
