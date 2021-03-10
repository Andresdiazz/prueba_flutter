import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prueba_tecnica/home/screens/home.dart';
import 'package:prueba_tecnica/users/bloc/user_bloc.dart';
import 'package:prueba_tecnica/users/model/user.dart';
import 'package:prueba_tecnica/users/ui/screens/loginScreen.dart';
import 'package:prueba_tecnica/users/ui/screens/registerScreen.dart';
import 'package:prueba_tecnica/users/ui/widgets/widgetButton.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _loading = false;
  bool _loadingGoogle = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _errorMessage = "";

  bool showPassword = false;

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return Scaffold(
        body: Container(
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "images/LOGO.png",
                        width: 150,
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            if (Platform.isIOS)
                              RaisedButton(
                                padding: EdgeInsets.symmetric(vertical: 13),
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                textColor: Colors.black,
                                onPressed: () => _loginApple(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.apple,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "REGISTRARSE CON APPLE",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: 0.8),
                                    ),
                                    if (_loading)
                                      Container(
                                        height: 20,
                                        width: 20,
                                        margin: const EdgeInsets.only(left: 20),
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Theme.of(context)
                                                      .primaryColor),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 20,
                            ),
                            RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 13),
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              textColor: Colors.black,
                              onPressed: () => _loginGoogle(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.google,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "REGÍSTRARSE CON GOOGLE",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: 0.8),
                                  ),
                                  if (_loadingGoogle)
                                    Container(
                                      height: 20,
                                      width: 20,
                                      margin: const EdgeInsets.only(left: 20),
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 0.5,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            WidgetButton(
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen())),
                              title: "REGÍSTRATE CON E-MAIL",
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 56),
              child: FlatButton(
                  onPressed: () {
                    userBloc.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "¿YA TIENES UNA CUENTA?",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  )),
            ),
          )
        ],
      ),
    ));
  }

  _loginGoogle(BuildContext context) async {
    if (!_loadingGoogle) {
      setState(() {
        _loadingGoogle = true;
        _errorMessage = "";
      });
      try {
        var user = await userBloc.signInWithGoogle().then((FirebaseUser user) {
          userBloc.registerUserData(User(uid: user.uid, email: user.email));
        }).then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));

        return user != null;
      } catch (e) {
        setState(() {
          _loadingGoogle = false;
          _errorMessage = "Email o contraseña incorrecta";
        });
        return e.message;
      }
    }
  }

  _loginApple(BuildContext context) async {
    if (!_loadingGoogle) {
      setState(() {
        _loadingGoogle = true;
        _errorMessage = "";
      });
      try {
        var user = await userBloc.signInWithApple().then((FirebaseUser user) {
          userBloc.registerUserData(User(uid: user.uid, email: user.email));
        }).then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));

        return user != null;
      } catch (e) {
        setState(() {
          _loadingGoogle = false;
          _errorMessage = "Email o contraseña incorrecta";
        });
        return e.message;
      }
    }
  }
}
