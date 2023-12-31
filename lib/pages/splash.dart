// not just splash , will ask use for their name here

// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, use_super_parameters, unnecessary_null_comparison

import 'package:finance_app/controllers/db_helper.dart';
import 'package:finance_app/pages/add_name.dart';
import 'package:finance_app/pages/auth.dart';
//import 'package:finance_app/pages/homepage.dart';
import 'package:finance_app/pages/widgets/bottonnavegationbar.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  //
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    getName();
  }

  Future getName() async {
    String? name = await dbHelper.getName();
    if (name != null) {
      // user has entered a name
      // since name is also important and can't be null
      // we will check for auth here and will show , auth if it is on
      bool? auth = await dbHelper.getLocalAuth();
      if (auth != null && auth) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const FingerPrintAuth(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Bottom(),
          ),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AddName(),
        ),
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      backgroundColor: const Color(0xffe2e7ef),
      //
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: Image.asset(
            "assets/icon.png",
            width: 64.0,
            height: 64.0,
          ),
        ),
      ),
    );
  }
}
