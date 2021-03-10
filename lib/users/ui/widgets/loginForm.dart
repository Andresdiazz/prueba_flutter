import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prueba_tecnica/home/screens/home.dart';
import 'package:prueba_tecnica/users/bloc/user_bloc.dart';
import 'package:prueba_tecnica/users/model/user.dart';
import 'package:prueba_tecnica/users/ui/widgets/registerButton.dart';
import 'package:prueba_tecnica/users/ui/widgets/widgetButton.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  String _errorMessage = "";

  bool showPassword = false;

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return SignIn();
  }

  Widget SignIn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Image.asset(
                "images/LOGO.png",
                width: 150,
              ),
              SizedBox(
                height: 100,
              ),
              TextFormField(
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    hintText: "E-mail",
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                keyboardType: TextInputType.emailAddress,
                //autovalidate: true,
                autocorrect: false,
                onSaved: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    hintText: "Contraseña",
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixIcon: IconButton(
                        icon: !showPassword
                            ? Icon(
                                FontAwesomeIcons.eye,
                                size: 18,
                              )
                            : Icon(
                                FontAwesomeIcons.eyeSlash,
                                size: 18,
                              ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        }),
                    hintStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                obscureText: !showPassword,
                onSaved: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      textColor: Colors.white,
                      onPressed: () {
                        userBloc.signOut();
                        _login(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "INGRESAR",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
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
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                              ),
                            )
                        ],
                      ),
                    ),
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
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
                      height: 40,
                    ),
                    WidgetButton(
                      onPressed: () {
                        userBloc.signOut();
                        _loginGoogle(context);
                      },
                      title: "INICIAR SESIÓN CON GOOGLE",
                      icon: FontAwesomeIcons.google,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (Platform.isIOS)
                      WidgetButton(
                        onPressed: () {
                          userBloc.signOut();
                          _loginApple(context);
                        },
                        title: "INICIAR SESIÓN CON APPLE",
                        icon: FontAwesomeIcons.apple,
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
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Text("CREA UNA CUENTA NUEVA",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0.8)))
            ],
          ),
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    if (!_loading) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        setState(() {
          _loading = true;
          _errorMessage = "";
        });
        try {
          var user = await userBloc
              .signInEmail(email, password)
              .then((FirebaseUser user) {
            userBloc.updateUserData(User(uid: user.uid, email: user.email));
          });
          //Navigator.of(context).pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));

          return user != null;
        } catch (e) {
          setState(() {
            _loading = false;
            _errorMessage = "Email o contraseña incorrecta";
          });
          return e.message;
        }
      }
    }
  }

  _loginGoogle(BuildContext context) async {
    if (!_loading) {
      setState(() {
        _loading = true;
        _errorMessage = "";
      });
      try {
        var user = await userBloc.signInWithGoogle().then((FirebaseUser user) {
          userBloc.updateUserData(User(uid: user.uid, email: user.email));
        }).then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
        return user != null;
      } catch (e) {
        setState(() {
          _loading = false;
          _errorMessage = e.message.toString();
        });
        return e.message;
      }
    }
  }

  _loginApple(BuildContext context) async {
    if (!_loading) {
      setState(() {
        _loading = true;
        _errorMessage = "";
      });
      try {
        var user = await userBloc.signInWithApple().then((FirebaseUser user) {
          userBloc.updateUserData(User(uid: user.uid, email: user.email));
        }).then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));

        return user != null;
      } catch (e) {
        setState(() {
          _loading = false;
          _errorMessage = "Email o contraseña incorrecta";
        });
        return e.message;
      }
    }
  }
}
