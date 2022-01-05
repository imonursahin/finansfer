import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/models/request/stock.dart';
import 'package:finansfer/core/network/models/request/suppliper.dart';

class StockAlertComponents extends StatefulWidget {
  final String userEmail;
  final List<Stock> stokList;
  final Function getStock;
  StockAlertComponents(this.userEmail, this.stokList, this.getStock);

  @override
  _StockAlertComponentsState createState() => _StockAlertComponentsState();
}

class _StockAlertComponentsState extends State<StockAlertComponents> {
  bool isLoading = true;
  Stock? selectedProduct;
  String errorText = "";

  TextEditingController productTitleController = TextEditingController();
  TextEditingController productAmountController = TextEditingController();
  TextEditingController productAmountTitController = TextEditingController();

  TextEditingController suppliperNameController = TextEditingController();
  TextEditingController suppliperContactController = TextEditingController();
  TextEditingController suppliperProductController = TextEditingController();

  TextEditingController productSalesAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(4.0),
              child:
                  Icon(Icons.production_quantity_limits, color: Colors.white),
            ),
            new Padding(
              padding: EdgeInsets.all(2.0),
              child: new MaterialButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color(0xFF29313c),
                        elevation: 25,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        title: Row(
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            new Text("Ürün Ekle"),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.cancel,
                              ),
                              iconSize: 25,
                              color: Colors.red,
                              onPressed: () {
                                productTitleController.clear();
                                productAmountController.clear();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        titleTextStyle:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                        content: Container(
                          height: 210.0,
                          child: Column(
                            children: [
                              TextField(
                                controller: productTitleController,
                                style: TextStyle(color: Colors.white),
                                maxLength: 20,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(
                                    height: double.minPositive,
                                  ),
                                  counterText: "",
                                  border: OutlineInputBorder(),
                                  labelText: 'Ürün Adı',
                                  labelStyle: TextStyle(
                                    color: Colors.blueGrey,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.clear,
                                        size: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: productAmountController,
                                style: TextStyle(color: Colors.white),
                                maxLength: 40,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(
                                    height: double.minPositive,
                                  ),
                                  counterText: "",
                                  border: OutlineInputBorder(),
                                  labelText: 'Miktar',
                                  labelStyle: TextStyle(
                                    color: Colors.blueGrey,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.clear,
                                        size: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              TextField(
                                controller: productAmountTitController,
                                style: TextStyle(color: Colors.white),
                                maxLength: 40,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(
                                    height: double.minPositive,
                                  ),
                                  counterText: "",
                                  border: OutlineInputBorder(),
                                  labelText: 'Miktar Birimi',
                                  labelStyle: TextStyle(
                                    color: Colors.blueGrey,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.clear,
                                        size: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          // ignore: deprecated_member_use
                          new RaisedButton(
                            child: Text('İptal',
                                style: TextStyle(color: Colors.white)),
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                            onPressed: () {
                              productTitleController.clear();
                              productAmountController.clear();
                              productAmountTitController.clear();
                              Navigator.pop(context);
                            },
                          ),
                          // ignore: deprecated_member_use
                          new RaisedButton(
                            child: Text('Ekle',
                                style: TextStyle(color: Colors.white)),
                            color: Color(0xFFf17c03),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                            onPressed: () async {
                              if (productTitleController.text == "" ||
                                  productAmountController.text == "" ||
                                  productAmountTitController.text == "") {
                                return;
                              } else {
                                await Database.addStock(
                                    Stock(
                                        productTitle:
                                            productTitleController.text,
                                        productAmountTit:
                                            productAmountTitController.text,
                                        productAmount: int.parse(
                                          productAmountController.text,
                                        ),
                                        isStock: true),
                                    widget.userEmail);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: new Text("Ürün Ekle",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
        new Row(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.contacts, color: Colors.white),
            ),
            new Padding(
              padding: EdgeInsets.all(2.0),
              child: new MaterialButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color(0xFF29313c),
                        elevation: 25,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        title: Row(
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            new Text("Tedarikçi Ekle"),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.cancel,
                              ),
                              iconSize: 25,
                              color: Colors.red,
                              onPressed: () {
                                suppliperNameController.clear();
                                suppliperContactController.clear();
                                suppliperProductController.clear();

                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        titleTextStyle:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                        content: Container(
                          height: 210.0,
                          child: Column(
                            children: [
                              TextField(
                                controller: suppliperNameController,
                                style: TextStyle(color: Colors.white),
                                maxLength: 20,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(
                                    height: double.minPositive,
                                  ),
                                  counterText: "",
                                  border: OutlineInputBorder(),
                                  labelText: 'Tedarikçi Adı',
                                  labelStyle: TextStyle(
                                    color: Colors.blueGrey,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.clear,
                                        size: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              TextField(
                                controller: suppliperContactController,
                                style: TextStyle(color: Colors.white),
                                maxLength: 40,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(
                                    height: double.minPositive,
                                  ),
                                  counterText: "",
                                  border: OutlineInputBorder(),
                                  labelText: 'Tedarikçi İletişim',
                                  labelStyle: TextStyle(
                                    color: Colors.blueGrey,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.clear,
                                        size: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              TextField(
                                controller: suppliperProductController,
                                style: TextStyle(color: Colors.white),
                                maxLength: 40,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(
                                    height: double.minPositive,
                                  ),
                                  counterText: "",
                                  border: OutlineInputBorder(),
                                  labelText: 'Tedarik Ürün',
                                  labelStyle: TextStyle(
                                    color: Colors.blueGrey,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2)),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.clear,
                                        size: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          // ignore: deprecated_member_use
                          new RaisedButton(
                            child: Text('İptal',
                                style: TextStyle(color: Colors.white)),
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                            onPressed: () {
                              suppliperNameController.clear();
                              suppliperContactController.clear();
                              suppliperProductController.clear();

                              Navigator.pop(context);
                            },
                          ),
                          // ignore: deprecated_member_use
                          new RaisedButton(
                            child: Text('Ekle',
                                style: TextStyle(color: Colors.white)),
                            color: Color(0xFFf17c03),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                            onPressed: () async {
                              if (suppliperNameController.text == "" ||
                                  suppliperContactController.text == "" ||
                                  suppliperProductController.text == "") {
                                return;
                              } else {
                                await Database.addSuppliper(
                                    Suppliper(
                                        supName: suppliperNameController.text,
                                        supContact:
                                            suppliperContactController.text,
                                        SupProduct:
                                            suppliperProductController.text,
                                        isSuppliper: true),
                                    widget.userEmail);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                print("eklendi");
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: new Text("Tedarikçi Ekle",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
        new Row(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.account_balance_wallet, color: Colors.white),
            ),
            new Padding(
              padding: EdgeInsets.all(2.0),
              child: new MaterialButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          backgroundColor: Color(0xFF29313c),
                          elevation: 25,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          title: Row(
                            children: [
                              Icon(Icons.add, color: Colors.white),
                              new Text("Satış Yap"),
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
                          titleTextStyle:
                              TextStyle(fontSize: 18.0, color: Colors.white),
                          content: SingleChildScrollView(
                            child: Container(
                              height: 180.0,
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButton<Stock>(
                                      hint: Text(
                                        'Ürün Seç',
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                      value: selectedProduct,
                                      iconDisabledColor: Colors.white,
                                      style: TextStyle(color: Colors.white),
                                      underline: Container(
                                          color: Colors.grey, height: 1.0),
                                      iconEnabledColor: Colors.white,
                                      dropdownColor: Colors.grey,
                                      isExpanded: true,
                                      items: widget.stokList
                                          .where((element) =>
                                              element.productAmount != 0)
                                          .map<DropdownMenuItem<Stock>>(
                                              (Stock value) {
                                        return DropdownMenuItem<Stock>(
                                          value: value,
                                          child: Text(
                                              value.productTitle.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (Stock? newValue) {
                                        setState(() {
                                          selectedProduct = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  TextField(
                                    controller: productSalesAmountController,
                                    style: TextStyle(color: Colors.white),
                                    maxLength: 40,
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      counterStyle: TextStyle(
                                        height: double.minPositive,
                                      ),
                                      counterText: "",
                                      border: OutlineInputBorder(),
                                      labelText: 'Miktar',
                                      labelStyle: TextStyle(
                                        color: Colors.blueGrey,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2)),
                                      suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.clear,
                                            size: 10, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    errorText,
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            // ignore: deprecated_member_use
                            new RaisedButton(
                              child: Text('İptal',
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            // ignore: deprecated_member_use
                            new RaisedButton(
                              child: Text('Sat',
                                  style: TextStyle(color: Colors.white)),
                              color: Color(0xFFf17c03),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0))),
                              onPressed: () async {
                                if (selectedProduct == null ||
                                    productSalesAmountController.text == "") {
                                  return;
                                }
                                if (selectedProduct!.productAmount! <
                                    int.parse(
                                        productSalesAmountController.text)) {
                                  setState(() {
                                    errorText = "Bu ürün den stokta " +
                                        selectedProduct!.productAmount
                                            .toString() +
                                        " adet bulunmakradır.";
                                  });
                                  return;
                                }

                                await Database.addSale(
                                    Stock(
                                        productAmount: int.parse(
                                            productSalesAmountController.text),
                                        productTitle:
                                            selectedProduct!.productTitle),
                                    widget.userEmail);
                                int productAmount =
                                    selectedProduct!.productAmount! -
                                        int.parse(
                                            productSalesAmountController.text);
                                await Database.updateStock(
                                    Stock(
                                      productAmount: productAmount,
                                      productTitle:
                                          selectedProduct!.productTitle,
                                      productAmountTit:
                                          selectedProduct!.productAmountTit!,
                                      isStock: selectedProduct!.isStock!,
                                    ),
                                    widget.userEmail,
                                    docId: selectedProduct!.docId!);
                                widget.getStock();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                    },
                  );
                },
                child: new Text("Satış Yap",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ],
    );
  }
}
