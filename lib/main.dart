// ignore_for_file: unnecessary_import, use_super_parameters

import 'package:finance_app/pages/splash.dart';
import 'package:finance_app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('transaction');
  await Hive.openBox('saving');
  await Hive.openBox('budget');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses',
      theme: myTheme,
      home: const Splash(),
    );
  }
}
