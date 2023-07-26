import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_study/auth/auth_controller.dart';
import 'package:project_study/auth/auth_provider.dart';
import 'package:project_study/components/custom_wrap_text.dart';
import 'package:project_study/home/home_provider.dart';
import 'package:project_study/models/user_model.dart';
import 'package:project_study/utils/local_storage.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final storage = LocalStorage();
  UserModel user = UserModel();
  String? oldToken = '';

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 200),
      () => setState(
        () {
          storage.getUserStorage().then(
                (value) => {
                  user = value,
                },
              );
        },
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (_) => HomeProvider(),
        child: Consumer<HomeProvider>(
          builder: (context, model, child) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    const Text(
                      'API data user request: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          getUser(model, context);
                        },
                        child: const Text(
                          'Click here :)',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: model.user.id != null,
                child: CustomWrapText(
                  title: 'Token will expire in: ',
                  value: model.seconds.toString(),
                  widgetType: 'row',
                  fontSize: 30,
                ),
              ),

              // TITLE VIEW
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Visibility(
                  visible: model.user.id != null,
                  child: const Text(
                    'User data',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),

              // NAME
              Visibility(
                visible: model.user.id != null,
                child: CustomWrapText(
                  title: 'Name: ',
                  value: '${model.user.realName}',
                  widgetType: 'row',
                ),
              ),

              // EMAIL
              Visibility(
                visible: model.user.id != null,
                child: CustomWrapText(
                  title: 'Email: ',
                  value: '${model.user.email}',
                  widgetType: 'row',
                ),
              ),

              // USERNAME
              Visibility(
                visible: model.user.id != null,
                child: CustomWrapText(
                  title: 'User name: ',
                  value: '${model.user.userName}',
                  widgetType: 'row',
                ),
              ),

              // TOKEN
              Visibility(
                visible: model.user.id != null,
                child: CustomWrapText(
                  title: 'Current token: ',
                  value: '${user.token}',
                  widgetType: 'wrap',
                ),
              ),

              // TOKEN
              Visibility(
                visible: model.user.id != null,
                child: CustomWrapText(
                  title: 'Old token: ',
                  value: '$oldToken',
                  widgetType: 'wrap',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getUser(HomeProvider model, BuildContext context) {
    getUserById(user.id!).then(
      (value) => {
        model.user = value,
        Provider.of<HomeProvider>(context, listen: false).startTimer(),
        Future.delayed(
          const Duration(seconds: 10),
          () => model.user = UserModel(),
        ),
        storage.getOldToken().then(
              (value) => {
                if (value != '')
                  {
                    oldToken = value,
                  }
                else
                  {
                    oldToken = user.token,
                  },
              },
            ),
        storage.getUserStorage().then(
              (value) => {
                user = value,
              },
            )
      },
    );
  }
}
