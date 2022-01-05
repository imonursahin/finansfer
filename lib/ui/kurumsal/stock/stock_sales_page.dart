import 'package:finansfer/core/network/models/request/stock.dart';
import 'package:flutter/material.dart';
import 'package:finansfer/core/network/di/database.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockSalesPage extends StatefulWidget {
  final String userEmail;

  const StockSalesPage(this.userEmail);

  @override
  _StockSalesPageState createState() => _StockSalesPageState();
}

class _StockSalesPageState extends State<StockSalesPage> {
  String finalDate = '';
  List<Stock> saleList = [];

  getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {
      finalDate = formattedDate.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentDate();
    getDatabaseSale();
  }

  getDatabaseSale() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    saleList = await Database.getSaleList(widget.userEmail);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: saleList.length,
        itemBuilder: (BuildContext context, int index) {
          return SafeArea(
              child: Container(
                  margin: EdgeInsets.all(1),
                  child: Card(
                      margin: EdgeInsets.all(9),
                      elevation: 20,
                      color: Color(0xFF1c252e),
                      child: Center(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            maxRadius: 30,
                            child: Text(
                              finalDate,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          title: Text(
                            saleList[index].productTitle.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          subtitle: Text(
                            saleList[index].productAmount.toString() +
                                " stok miktarı satış gerçekleştirildi.",
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 10),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 22,
                            ),
                            color: Colors.red,
                            onPressed: () {
                              deleteStock(saleList[index].docId!);
                            },
                          ),
                        ),
                      ))));
        });
  }

  deleteStock(docId) async {
    await Database.deleteSale(docId, widget.userEmail);
    getDatabaseSale();
  }
}
