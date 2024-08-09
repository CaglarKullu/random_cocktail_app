import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart' as fonts;
import 'package:random_cocktail_app/consts/color.dart';

import '../../../view_models/Auth_View_Model.dart';

// ignore: must_be_immutable
class BuildLogInButtons extends ConsumerWidget {
  Size deviceSize;
  BuildLogInButtons({required this.deviceSize, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
        top: deviceSize.height / 2,
        child: SizedBox(
            width: deviceSize.width,
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        width: deviceSize.width,
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
                          label: const Text("Sign up with Google",
                              style: TextStyle(color: selectedNavItemColor)),
                          icon: const Icon(
                            FontAwesome5.google,
                          ),
                          onPressed: () => ref
                              .read(authViewModelProvider.notifier)
                              .signInWithGoogle(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Or",
                          style: fonts.GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 20,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        width: deviceSize.width,
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
                            onPressed: () => ref
                                .read(authViewModelProvider.notifier)
                                .anonSignIn(),
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
