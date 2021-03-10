import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetButton extends StatelessWidget {
  final VoidCallback _onPressed;
  String title;
  IconData icon;

  WidgetButton({Key key, VoidCallback onPressed, this.title, this.icon})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      onPressed: _onPressed,
      padding: EdgeInsets.symmetric(vertical: 13),
      color: Theme.of(context).secondaryHeaderColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: 0.8),
          ),
        ],
      ),
    );
  }
}
