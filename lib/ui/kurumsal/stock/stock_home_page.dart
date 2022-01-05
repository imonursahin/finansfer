import 'package:finansfer/core/network/models/request/suppliper.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:finansfer/core/util/theme/stock_alert_component.dart';
import 'package:finansfer/ui/kurumsal/stock/stock_products_page.dart';
import 'package:finansfer/ui/kurumsal/stock/stock_sales_page.dart';
import 'package:finansfer/ui/kurumsal/stock/stock_supplier_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finansfer/core/network/models/request/stock.dart';
import 'package:finansfer/core/network/di/database.dart';

class StockHomePage extends StatefulWidget {
  @override
  _StockHomePageState createState() => _StockHomePageState();
}

class _StockHomePageState extends State<StockHomePage> {
  List<Stock> stockList = [];
  List<Stock> saleList = [];
  List<Suppliper> suppliperList = [];

  bool isLoading = false;
  String? userEmail = "";

  int stockAmount = 0;
  int stockSaleAmount = 0;

  @override
  void initState() {
    super.initState();
    getDatabaseStock();
    getDatabaseSale();
  }

  getDatabaseStock() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmail = preferences.getString("userEmail");
    stockList = await Database.getStockList(userEmail ?? "");
    calculateStockAmount(stockList);
    setState(() {
      isLoading = false;
    });
  }

  getDatabaseSale() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmail = preferences.getString("userEmail");
    saleList = await Database.getSaleList(userEmail ?? "");
    setState(() {});
  }

  calculateStockAmount(List<Stock> list) {
    stockAmount = 0;
    stockSaleAmount = 0;
    for (var item in list) {
      if (item.isStock!) {
        stockAmount += item.productAmount!;
      } else {
        stockSaleAmount += item.productAmount!;
      }
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: AppColors.brightMainColor,
            title: Text('Ürün Stok Yönetimi'),
            bottom: TabBar(
              tabs: [
                Tab(
                    icon: Icon(Icons.production_quantity_limits),
                    text: "Ürünler"),
                Tab(icon: Icon(Icons.contacts_rounded), text: "Tedarikçiler"),
                Tab(icon: Icon(Icons.account_balance_wallet), text: "Satışlar")
              ],
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.mainColor,
            child: Column(
              children: [
                isLoading
                    ? Container(
                        margin: EdgeInsets.only(top: 50),
                        child: CircularProgressIndicator())
                    : Expanded(
                        child: TabBarView(children: [
                          StockProductsPage(
                              stockList
                                  .where((element) => element.isStock == true)
                                  .toList(),
                              userEmail ?? "", () {
                            getDatabaseStock();
                          }),
                          StockSupplierPage(userEmail ?? "", () {}),
                          StockSalesPage(userEmail ?? ""),
                        ]),
                      ),
              ],
            ),
          ),
          bottomNavigationBar: new Container(
            color: AppColors.brightMainColor,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: new Text(
                      "Toplam:",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: new Text(
                      "Ürün",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: new Text(
                      stockList.length.toString(),
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: new Text(
                      "Stok",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: new Text(
                      stockAmount.toString(),
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                Expanded(
                    child: new IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          size: 35,
                          color: AppColors.btnOrange,
                        ),
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) => new AlertDialog(
                                    backgroundColor: Color(0xFF29313c),
                                    elevation: 25,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    content: new Container(
                                      height: 160.0,
                                      child: StockAlertComponents(
                                          userEmail ?? "", stockList, () {
                                        getDatabaseStock();
                                      }),
                                    ),
                                  ));
                          getDatabaseStock();
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
