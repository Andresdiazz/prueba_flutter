import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prueba_tecnica/home/screens/editProduct.dart';

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Container(
            //height: 500,
            height: MediaQuery.of(context).size.height / 1.75,
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('products')
                    .orderBy('timeStamp', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("loading....");
                  }
                  int length = snapshot.data.documents.length;
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: length,
                      itemBuilder: (_, int index) {
                        final DocumentSnapshot doc =
                            snapshot.data.documents[index];
                        return IntrinsicHeight(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                    //height: 258,
                                    width: double.infinity,
                                    child: Card(
                                        color: Color(0xfff2f2f2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        doc.data['name'],
                                                        style:
                                                            GoogleFonts.raleway(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      )),
                                                      Expanded(
                                                          child: Text(
                                                        doc.data['description'],
                                                        style:
                                                            GoogleFonts.raleway(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      )),
                                                      Text(
                                                        "Stock: " +
                                                            doc.data['stock']
                                                                .toString(),
                                                        style:
                                                            GoogleFonts.raleway(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      Text(
                                                        "Price: \$" +
                                                            doc.data['price']
                                                                .toString(),
                                                        style:
                                                            GoogleFonts.raleway(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ]),
                                              ),
                                              IconButton(
                                                  icon: Icon(FontAwesomeIcons
                                                      .ellipsisV),
                                                  onPressed: () {
                                                    _editProductModalBottomSheet(
                                                        context,
                                                        doc.documentID,
                                                        doc.data['name'],
                                                        doc.data['description'],
                                                        doc.data['stock'],
                                                        doc.data['price']);
                                                  })
                                            ],
                                          ),
                                        )))));
                      });
                })));
  }

  void _editProductModalBottomSheet(context, String docId, String name,
      String description, int stock, int price) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: IntrinsicHeight(
                child: Container(
                  width: double.infinity,
                  //height: size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 13),
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            textColor: Colors.black,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => EditProductForm(
                                            name: name,
                                            description: description,
                                            stock: stock.toString(),
                                            price: price.toString(),
                                            idDoc: docId,
                                          )));
                            },
                            child: Text(
                              "Editar Publicacion".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FlatButton(
                            onPressed: () async {
                              await Firestore.instance
                                  .collection('products')
                                  .document(docId)
                                  .delete()
                                  .then((value) => Navigator.pop(context));
                            },
                            child: Text("Eliminar".toUpperCase(),
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
