import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:prueba_tecnica/home/screens/createProduct.dart';
import 'package:prueba_tecnica/home/widgets/listProduct.dart';
import 'package:prueba_tecnica/users/bloc/user_bloc.dart';
import 'package:prueba_tecnica/users/ui/screens/loginScreen.dart';

class HomePage extends StatelessWidget {
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Home Page",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.white,
              ),
              onPressed: () {
                userBloc.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              })
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListProducts(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewProductForm()));
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
