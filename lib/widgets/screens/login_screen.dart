import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_cocktail_app/consts/color.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:random_cocktail_app/data/auth.dart';

import 'dart:developer' as developer;

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>
    with SingleTickerProviderStateMixin {
  bool isSelected = false;
  Animation? _animation;
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = ColorTween(begin: glassColorBegin, end: glassColorEnd)
        .animate(_controller!);
    _controller?.addListener(() {
      _controller!.value;
      _animation?.value;
    });
    _controller?.addStatusListener((status) {
      developer.log(status.toString());
    });
  }

  void animateColor() {
    _controller?.forward();
  }

  void reverseColor() {
    _controller?.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(children: [
          AnimatedPositioned(
            left: 50,
            top: isSelected ? 50 : 200,
            duration: const Duration(seconds: 1),
            child: Column(
              children: [
                const Text("Welcome"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _controller!,
                      builder: (BuildContext context, Widget? child) {
                        return Icon(
                          FontAwesome5.cocktail,
                          size: 50,
                          color: _animation?.value,
                        );
                      },
                    ),
                    const Text(
                      "Random Cocktail App",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              top: 300,
              left: MediaQuery.of(context).size.width / 2 - 100,
              child: SizedBox(
                width: 200,
                child: AnimatedBuilder(
                  animation: _controller!,
                  builder: (BuildContext context, Widget? child) {
                    return Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final signIn = ref.watch(authProvider);
                        return Column(
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: signUpButTextColor,
                                  backgroundColor: signUpButBackgroudColor),
                              onPressed: (() => setState(() {
                                    isSelected = !isSelected;
                                    isSelected
                                        ? animateColor()
                                        : reverseColor();
                                    signIn.googleLogIn();
                                  })),
                              label: const Text("Sign up with Google"),
                              icon: const Icon(FontAwesome5.google),
                            ),
                            SizedBox(
                              width: 150,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: signUpButTextColor,
                                      backgroundColor: signUpButBackgroudColor),
                                  onPressed: (() => setState(() {
                                        isSelected = !isSelected;
                                        isSelected
                                            ? animateColor()
                                            : reverseColor();
                                        signIn.signInAnon();
                                      })),
                                  label: const Text("Sign in Anonymously"),
                                  icon: const Icon(FontAwesome5.mask)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              )),
        ]),
      ),
    );
  }
}
