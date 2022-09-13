import 'package:flutter/material.dart';
import 'package:random_cocktail_app/consts/color.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

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
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation =
        ColorTween(begin: Colors.white, end: Colors.pink).animate(_controller!);
    _controller?.addListener(() {
      _controller!.value;
      _animation?.value;
    });
    _controller?.addStatusListener((status) {
      print(status);
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
            duration: Duration(seconds: 1),
            child: Column(
              children: [
                Text("Welcome"),
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
                    Text(
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
              left: MediaQuery.of(context).size.width / 2 - 40,
              child: SizedBox(
                width: 80,
                child: AnimatedBuilder(
                  animation: _controller!,
                  builder: (BuildContext context, Widget? child) {
                    return ElevatedButton(
                        onPressed: (() => setState(() {
                              isSelected = !isSelected;
                              isSelected ? animateColor() : reverseColor();
                            })),
                        child: const Text("Sign In"));
                  },
                ),
              )),
        ]),
      ),
    );
  }
}
