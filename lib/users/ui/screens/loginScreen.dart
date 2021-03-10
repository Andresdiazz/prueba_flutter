import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:prueba_tecnica/home/screens/home.dart';
import 'package:prueba_tecnica/users/bloc/user_bloc.dart';
import 'package:prueba_tecnica/users/ui/widgets/loginForm.dart';

class LoginScreen extends StatelessWidget {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Login(context);
        } else {
          return //InfoOyentes();
              HomePage();
        }
      },
    );
  }

  Widget Login(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          //backgroundColor: Theme.of(context).primaryColor,
          body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Center(child: LoginForm())
        ],
      )),
    );
  }
}
