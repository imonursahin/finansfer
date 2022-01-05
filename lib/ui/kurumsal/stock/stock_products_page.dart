import 'package:finansfer/core/network/models/request/stock.dart';
import 'package:flutter/material.dart';
import 'package:finansfer/core/network/di/database.dart';

class StockProductsPage extends StatefulWidget {
  final List<Stock> stockList;
  final String userEmail;
  final Function onDeleteFunction;

  StockProductsPage(this.stockList, this.userEmail, this.onDeleteFunction);

  @override
  _StockProductsPageState createState() => _StockProductsPageState();
}

class _StockProductsPageState extends State<StockProductsPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: widget.stockList.length,
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
                          leading: CircleAvatar(
                            backgroundColor: Color(0xffF57F17),
                            maxRadius: 30,
                            child: Text(
                              widget.stockList[index].productAmountTit
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          title: Text(
                            widget.stockList[index].productTitle.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          subtitle: Text(
                            "\n" +
                                "Stok Miktarı: " +
                                widget.stockList[index].productAmount
                                    .toString(),
                            style:
                                TextStyle(color: Colors.white38, fontSize: 15),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 22,
                            ),
                            color: Colors.red,
                            onPressed: () {
                              deleteStockProduct(
                                  widget.stockList[index].docId ?? "");
                            },
                          ),
                        ),
                      ))));
        });
  }

  deleteStockProduct(docId) async {
    await Database.deleteStock(docId, widget.userEmail);
    widget.onDeleteFunction();
  }
}
