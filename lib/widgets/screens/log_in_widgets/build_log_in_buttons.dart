import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_cocktail_app/consts/color.dart';
import 'package:random_cocktail_app/data/auth.dart';

// ignore: must_be_immutable
class BuildLogInButtons extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var deviceSize;
  BuildLogInButtons({required this.deviceSize, super.key});

  @override
  State<BuildLogInButtons> createState() => _BuildLogInButtonsState();
}

class _BuildLogInButtonsState extends State<BuildLogInButtons> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: widget.deviceSize.height / 2,
        child: SizedBox(
            width: widget.deviceSize.width,
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final signIn = ref.watch(authProvider);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        width: widget.deviceSize.width,
                        height: 45,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                width: 1,
                                color: selectedNavItemColor,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: signUpButTextColor,
                              backgroundColor: backgroundColor),
                          onPressed: (() => setState(() {
                                signIn.googleLogIn();
                              })),
                          label: const Text("Sign up with Google",
                              style: TextStyle(color: selectedNavItemColor)),
                          icon: const Icon(
                            FontAwesome5.google,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Or",
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 20,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        width: widget.deviceSize.width,
                        height: 45,
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 1,
                                  color: selectedNavItemColor,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                foregroundColor: signUpButTextColor,
                                backgroundColor: backgroundColor),
                            onPressed: (() => setState(() {
                                  signIn.signInAnon();
                                })),
                            label: const Text(
                              " Continue as Anonymous",
                              style: TextStyle(color: selectedNavItemColor),
                            ),
                            icon: const Icon(FontAwesome5.mask)),
                      ),
                    ),
                  ],
                );
              },
            )));
  }
}
