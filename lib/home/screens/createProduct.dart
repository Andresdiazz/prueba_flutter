import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class NewProductForm extends StatefulWidget {
  @override
  _NewProductFormState createState() => _NewProductFormState();
}

class _NewProductFormState extends State<NewProductForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController priceController = TextEditingController();

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
          "Nuevo Producto",
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
      body: Container(
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
                controller: nameController,
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
                keyboardType: TextInputType.number,
                controller: stockController,
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
                keyboardType: TextInputType.number,
                controller: priceController,
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
                  controller: descriptionController,
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
    );
  }

  Future uploadProduct(BuildContext context) async {
    await Firestore.instance.collection("products").add({
      "name": nameController.text,
      "description": descriptionController.text,
      "timeStamp": DateTime.now(),
      "stock": int.parse(stockController.text),
      "price": int.parse(priceController.text)
    });
    setState(() {
      print("Post Posted");

      Navigator.pop(context);
    });
  }
}
