import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_study/auth/auth_controller.dart';
import 'package:project_study/auth/auth_provider.dart';
import 'package:project_study/components/custom_background_auth.dart';
import 'package:project_study/components/custom_text_field.dart';
import 'package:project_study/models/user_model.dart';
import 'package:project_study/utils/utils.services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final utilsService = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
          child: CustomBackgroundAuth(
        height: 1.9,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                CustomTextField(
                  controller: emailCtrl,
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Digite seu email';
                    }
                    return null;
                  },
                  label: 'Email',
                  icon: Icons.email_outlined,
                  type: TextInputType.emailAddress,
                ),
                CustomTextField(
                  controller: passwordCtrl,
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return 'Digite sua senha';
                    }
                    if (password.length < 7) {
                      return 'Digite uma senha com ao menos 7 caracteres';
                    }
                    return null;
                  },
                  label: 'Password',
                  icon: Icons.password_outlined,
                  secret: true,
                ),
                ChangeNotifierProvider(
                  create: (_) => AuthProvider(),
                  child: Consumer<AuthProvider>(
                    builder: (context, model, child) => Padding(
                      padding: const EdgeInsets.only(top: 35, bottom: 10),
                      child: SizedBox(
                        height: 55,
                        width: 210,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                width: 1.2, color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              model.loading = true;

                              SharedPreferences storage =
                                  await SharedPreferences.getInstance();

                              Map<String, String> auth = {
                                'email': emailCtrl.text,
                                'password': passwordCtrl.text,
                              };

                              String resp;

                              await login(auth).then(
                                (UserModel user) => {
                                  resp = jsonEncode(user),
                                  if (user.id == null)
                                    {
                                      model.loading = false,
                                      utilsService.showToast(
                                          context: context,
                                          message:
                                              'Incorret email or password, please, try it again',
                                          duration: 3),
                                    }
                                  else
                                    {
                                      model.loading = false,
                                      storage.setString('user', resp),
                                      Navigator.pushReplacementNamed(
                                          context, '/home')
                                    }
                                },
                              );
                            }
                          },
                          child: model.loading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white.withAlpha(700),
                          thickness: 2,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Or',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white.withAlpha(700),
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
