import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:prueba_tecnica/users/bloc/user_bloc.dart';
import 'package:prueba_tecnica/users/ui/screens/loginScreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xff65e8e3),
            secondaryHeaderColor: Color(0xff72f46d)),
        title: "Prueba Técnica",
        home: LoginScreen(),
      ),
      bloc: UserBloc(),
    );
  }
}
