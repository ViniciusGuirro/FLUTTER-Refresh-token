import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_study/components/custom_background_auth.dart';
import 'package:project_study/components/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_controller.dart';
import 'auth_provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();
  final fullNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  bool validator = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: CustomBackgroundAuth(
          height: !validator ? 1.3 : 1.6,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      // BACK BUTTON
                      Positioned(
                        right: 10,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Register',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // INPUT FULL NAME
                  CustomTextField(
                    controller: fullNameCtrl,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Type your full name';
                      }
                      return null;
                    },
                    label: 'Full name',
                    icon: Icons.abc_outlined,
                    type: TextInputType.emailAddress,
                  ),

                  // INPUT USER NAME
                  CustomTextField(
                    controller: userNameCtrl,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Type your user name';
                      }
                      return null;
                    },
                    label: 'User name',
                    icon: Icons.abc_outlined,
                    type: TextInputType.emailAddress,
                  ),

                  // INPUT EMAIL
                  CustomTextField(
                    controller: emailCtrl,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Type your email';
                      }
                      return null;
                    },
                    label: 'Email',
                    icon: Icons.email_outlined,
                    type: TextInputType.emailAddress,
                  ),

                  // INPUT PASSWORD
                  CustomTextField(
                    controller: passwordCtrl,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Type your password';
                      }
                      if (password.length < 7) {
                        return 'Enter a password with at least 7 characters';
                      }
                      return null;
                    },
                    label: 'Password',
                    icon: Icons.password_outlined,
                    secret: true,
                  ),

                  // INPUT CONFIRM PASSWORD
                  CustomTextField(
                    controller: confirmPasswordCtrl,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Confirm the password';
                      }
                      if (password.length < 7) {
                        return 'Enter a password with at least 7 characters';
                      }
                      return null;
                    },
                    label: 'Confirm password',
                    icon: Icons.password_outlined,
                    secret: true,
                  ),

                  // BUTTON REGISTER
                  Padding(
                    padding: const EdgeInsets.only(top: 35, bottom: 10),
                    child: SizedBox(
                      height: 55,
                      width: 210,
                      child: ChangeNotifierProvider(
                          create: (_) => AuthProvider(),
                          child: Consumer<AuthProvider>(
                            builder: (context, model, child) => OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    width: 1.2, color: Colors.white),
                              ),
                              onPressed: () async {
                                model.loading = true;

                                SharedPreferences storage =
                                    await SharedPreferences.getInstance();

                                setState(() {
                                  validator = _formKey.currentState!.validate();
                                });

                                if (_formKey.currentState!.validate()) {
                                  Map<String, dynamic> body = {
                                    'realName': fullNameCtrl.text,
                                    'userName': userNameCtrl.text,
                                    'email': emailCtrl.text,
                                    'password': passwordCtrl.text,
                                    'confirmPassword': confirmPasswordCtrl.text,
                                  };

                                  Map<String, String> auth = {
                                    'email': emailCtrl.text,
                                    'password': passwordCtrl.text,
                                  };

                                  String jsonBody = jsonEncode(body);

                                  register(jsonBody).then(
                                    (value) => {
                                      if (value == 'ER_DUP_ENTRY')
                                        {
                                          model.loading = false,
                                        }
                                      else
                                        {
                                          login(auth)
                                              .then(
                                                (value) => {
                                                  model.loading = false,
                                                  storage.setString('user',
                                                      jsonEncode(value)),
                                                  Navigator.pushNamed(
                                                      context, '/home')
                                                },
                                              )
                                              .catchError(
                                                (onError) => {
                                                  model.loading = false,
                                                },
                                              ),
                                        },
                                    },
                                  );

                                  // Navigator.pushNamed(context, '/home');
                                }
                              },
                              child: model.loading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text(
                                      'Register',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
