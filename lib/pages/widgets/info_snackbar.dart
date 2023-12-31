// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:finance_app/static.dart' as Static;

SnackBar deleteInfoSnackBar = const SnackBar(
  backgroundColor: Static.PrimaryColor,
  duration: Duration(
    seconds: 2,
  ),
  content: Row(
    children: [
      Icon(
        Icons.info_outline,
        color: Colors.white,
      ),
      SizedBox(
        width: 6.0,
      ),
      Text(
        "Pulsación larga para borrar",
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    ],
  ),
);
