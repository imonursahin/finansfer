import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/models/request/income_expense.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:finansfer/core/util/theme/income_alert_components.dart';
import 'package:finansfer/ui/finance/income_expense/expense_page.dart';
import 'package:finansfer/ui/finance/income_expense/income_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeExpensePage extends StatefulWidget {
  @override
  State<IncomeExpensePage> createState() => _IncomeExpensePageState();
}

class _IncomeExpensePageState extends State<IncomeExpensePage> {
  List<IncomeExpense> incomeExpenseList = [];
  bool isLoading = false;
  String? userEmail = "";
  int incomeAmount = 0;
  int expenseAmount = 0;

  @override
  void initState() {
    super.initState();
    getDatabaseIncomeExpense();
  }

  getDatabaseIncomeExpense() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmail = preferences.getString("userEmail");
    incomeExpenseList = await Database.getIncomeExpenseList(userEmail ?? "");
    calculateIncomeExpenseAmount(incomeExpenseList);
    setState(() {
      isLoading = false;
    });
  }

  calculateIncomeExpenseAmount(List<IncomeExpense> list) {
    incomeAmount = 0;
    expenseAmount = 0;
    for (var item in list) {
      if (item.isIncome!) {
        incomeAmount += item.amount!;
      } else {
        expenseAmount += item.amount!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: AppColors.brightMainColor,
            title: Text('Gelir-Gider Takibi'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.auto_graph,
                    color: Colors.green,
                  ),
                  text: "Gelirlerim",
                ),
                Tab(
                    icon: Icon(
                      Icons.analytics,
                      color: Colors.red,
                    ),
                    text: "Harcamalarım")
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
                        child: TabBarView(
                          children: [
                            IncomePage(
                                incomeExpenseList
                                    .where(
                                        (element) => element.isIncome == true)
                                    .toList(),
                                userEmail ?? "", () {
                              getDatabaseIncomeExpense();
                            }),
                            ExpensePage(
                                incomeExpenseList
                                    .where(
                                        (element) => element.isIncome == false)
                                    .toList(),
                                userEmail ?? "", () {
                              getDatabaseIncomeExpense();
                            }),
                          ],
                        ),
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
                      "Gelir",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: new Text(
                      incomeAmount.toString(),
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: new Text(
                      "Harcama",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: new Text(
                      expenseAmount.toString(),
                      style: TextStyle(color: Colors.red),
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
                                      height: 110.0,
                                      child: AlertComponents(userEmail ?? ""),
                                    ),
                                  ));
                          getDatabaseIncomeExpense();
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
