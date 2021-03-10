import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prueba_tecnica/home/screens/home.dart';
import 'package:prueba_tecnica/users/bloc/user_bloc.dart';
import 'package:prueba_tecnica/users/model/user.dart';
import 'package:prueba_tecnica/users/ui/screens/loginScreen.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String passwordConfirm = "";

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
                height: 100,
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
                    hintStyle: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.w400),
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
                    hintStyle: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.w400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                obscureText: !showPassword,

                //autovalidate: true,
                autocorrect: false,
                onSaved: (value) {
                  password = value;
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
                    hintText: "Confirmar contraseña",
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
                    hintStyle: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.w400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                obscureText: !showPassword,

                //autovalidate: true,
                autocorrect: false,
                onSaved: (value) {
                  passwordConfirm = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    textColor: Colors.black,
                    onPressed: () {
                      userBloc.signOut();
                      _login(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "CREAR MI CUENTA",
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
                ],
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("¿YA TIENES CUENTA?",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 0.8,
                      )))
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
        if (password == passwordConfirm) {
          setState(() {
            _loading = true;
            _errorMessage = "";
          });
          try {
            var user = await userBloc
                .createAccountEmail(email, password)
                .then((FirebaseUser user) {
              userBloc.registerUserData(User(uid: user.uid, email: user.email));
            });
            //Navigator.of(context).pop(context);

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
            return user != null;
          } catch (e) {
            setState(() {
              _loading = false;
              if (e.message ==
                  "The email address is already in use by another account.") {
                _errorMessage = "Este email ya esta registrado con otra cuenta";
              } else if (e.message ==
                  "The password must be 6 characters long or more.") {
                _errorMessage = "La contraseña debe tener 6 o más carácteres";
              } else if (e.message == "The email address is badly formatted.") {
                _errorMessage = "El email tiene un formato no válido";
              }
              //_errorMessage = e.message.toString();
              print(e);
            });
            return e.message;
          }
        } else {
          setState(() {
            _errorMessage = "Las contraseñas deben ser iguales";
          });
        }
      }
    }
  }
}
