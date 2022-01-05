import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:finansfer/core/network/models/request/suppliper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class StockSupplierPage extends StatefulWidget {
  String userEmail;

  final Function onDeleteFunction;

  StockSupplierPage(this.userEmail, this.onDeleteFunction);

  @override
  _StockSupplierPageState createState() => _StockSupplierPageState();
}

class _StockSupplierPageState extends State<StockSupplierPage> {
  List<Suppliper> suppliperList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getDatabaseSuppliper();
  }

  getDatabaseSuppliper() async {
    setState(() {
      isLoading = true;
    });
    suppliperList = await Database.suppliperList(widget.userEmail);
    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: suppliperList.length,
        itemBuilder: (BuildContext context, int index) {
          return SafeArea(
              child: Container(
                  height: 92,
                  margin: EdgeInsets.all(1),
                  child: Card(
                      margin: EdgeInsets.all(9),
                      elevation: 20,
                      color: Color(0xFF1c252e),
                      child: Center(
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 22,
                            ),
                            color: Colors.red,
                            onPressed: () {
                              deleteSuppliper(suppliperList[index].docId ?? "");
                            },
                          ),
                          title: Text(
                            suppliperList[index].supName.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                            iconSize: 30,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                      backgroundColor: Color(0xFF29313c),
                                      elevation: 25,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      title: Row(
                                        children: [
                                          new Text("Tedarikçi Bilgisi",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Spacer(),
                                          IconButton(
                                            icon: Icon(
                                              Icons.cancel,
                                            ),
                                            iconSize: 25,
                                            color: Colors.red,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                      content: new Text(
                                          "\n Tedarikçi Adı: " +
                                              suppliperList[index]
                                                  .supName
                                                  .toString() +
                                              "\n\n İletişim Bilgisi: " +
                                              suppliperList[index]
                                                  .supContact
                                                  .toString() +
                                              "\n\n Tedarik Ürün: " +
                                              suppliperList[index]
                                                  .SupProduct
                                                  .toString(),
                                          style:
                                              TextStyle(color: Colors.white)),
                                      actions: <Widget>[]);
                                },
                              );
                            },
                          ),
                        ),
                      ))));
        });
  }

  deleteSuppliper(docId) async {
    await Database.deleteSuppliper(docId, widget.userEmail);
    getDatabaseStock();
  }

  getDatabaseStock() async {
    setState(() {
      isLoading = true;
    });
    suppliperList = await Database.suppliperList(widget.userEmail);

    setState(() {
      isLoading = false;
    });
  }
}
