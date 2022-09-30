import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_cocktail_app/consts/color.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:random_cocktail_app/data/auth.dart';
import 'package:random_cocktail_app/widgets/screens/log_in_widgets/build_log_in_buttons.dart';
import 'package:random_cocktail_app/widgets/screens/log_in_widgets/title_and_logo.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      buildTitleAndLogo(deviceSize),
      BuildLogInButtons(deviceSize: deviceSize),
    ])));
  }
}
