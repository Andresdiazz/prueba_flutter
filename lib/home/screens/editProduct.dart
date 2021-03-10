import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProductForm extends StatefulWidget {
  final String name;
  final String description;
  final String price;
  final String stock;
  final String idDoc;

  const EditProductForm(
      {Key key,
      this.name,
      this.description,
      this.price,
      this.stock,
      this.idDoc})
      : super(key: key);
  @override
  _EditProductFormState createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  String name;
  String description;
  String price;
  String stock;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Editar Producto",
          style: GoogleFonts.raleway(
              fontSize: 18,
              color: Color(0xff333333),
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        actions: [
          FlatButton(
              onPressed: () {
                uploadProduct(context);
              },
              child: Text(
                "Publicar",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).primaryColor),
              ))
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            size: 25,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 2,
                ),
                TextFormField(
                  initialValue: widget.name,
                  onSaved: (value) => name = value,
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                  decoration: InputDecoration(
                      //disabledBorder: InputBorder.none,
                      hintText: "Name",
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                          color: Color(0xff828282),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      )),
                ),
                Container(
                  height: 2,
                ),
                TextFormField(
                  initialValue: widget.stock,
                  onSaved: (value) => stock = value,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                  decoration: InputDecoration(
                      //disabledBorder: InputBorder.none,
                      hintText: "Introduzca un número de stock",
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                          color: Color(0xff828282),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      )),
                ),
                Container(
                  height: 2,
                ),
                TextFormField(
                  initialValue: widget.price,
                  onSaved: (value) => price = value,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                  decoration: InputDecoration(
                      //disabledBorder: InputBorder.none,
                      hintText: "Introduzca el precio",
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                          color: Color(0xff828282),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      )),
                ),
                Container(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: widget.description,
                    onSaved: (value) => description = value,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(color: Colors.black87, fontSize: 15),
                    maxLines: 10,
                    decoration: InputDecoration.collapsed(
                      //disabledBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Escribe una descripción",
                      hintStyle: TextStyle(
                          color: Color(0xff828282),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future uploadProduct(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await Firestore.instance
          .collection("products")
          .document(widget.idDoc)
          .updateData({
        "name": name,
        "description": description,
        "timeStamp": DateTime.now(),
        "stock": int.parse(stock),
        "price": int.parse(price)
      });
      setState(() {
        print("Post Posted");

        Navigator.pop(context);
      });
    }
  }
}
