import 'package:flutter/material.dart';
import 'package:prueba_tecnica/users/ui/widgets/registerForm.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        RegisterForm()
      ],
    ));
  }
}
