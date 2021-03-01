import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:sofia/res/palette.dart';
import 'package:sofia/utils/sign_in.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'name_page.dart';

/// Displays the `LoginPage`.
///
/// Uses Google Sign In for user authentication.
///
/// **Connected pages:**
///
/// - `NamePage` (forward)
///
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Palette.loginBackground);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    var screenSize = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Palette.loginBackground,
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Text(
                "Sofia",
                style: TextStyle(
                  fontFamily: 'TitilliumWeb',
                  fontSize: screenSize.width / 8,
                  color: Colors.black,
                ),
              ),
              WebsafeSvg.asset(
                'assets/images/cover1.svg',
                width: MediaQuery.of(context).size.width,
                semanticsLabel: 'Cover Image',
              ),
              _googleSignInButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Generates Google Sign In button widget
  Widget _googleSignInButton() {
    return DecoratedBox(
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.white),
      child: OutlineButton(
        highlightColor: Colors.grey[100],
        splashColor: Colors.grey[100],
        color: Colors.grey[100],
        onPressed: () {
          // Navigates to the NamePage if the authentication
          // is successful.
          signInWithGoogle().then((user) {
            if (user != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return NamePage();
                  },
                ),
              ).then((_) {
                // Sets the status bar color of the one set to this page
                // if an user comes back to this page.
                FlutterStatusbarcolor.setStatusBarColor(
                    Palette.loginBackground);
                FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
              });
            }
          }).catchError(
            (e) => print('SIGN IN ERROR: $e'),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("assets/images/google_logo.png"),
                  height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
