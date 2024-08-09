import 'package:flutter/material.dart';
import 'package:random_cocktail_app/widgets/screens/log_in_widgets/build_log_in_buttons.dart';
import 'package:random_cocktail_app/widgets/screens/log_in_widgets/title_and_logo.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      buildTitleAndLogo(deviceSize),
      BuildLogInButtons(deviceSize: deviceSize),
    ])));
  }
}
