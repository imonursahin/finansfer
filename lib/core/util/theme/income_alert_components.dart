import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/models/request/income_expense.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AlertComponents extends StatefulWidget {
  final String userEmail;

  AlertComponents(this.userEmail);

  @override
  _AlertComponentsState createState() => _AlertComponentsState();
}

class _AlertComponentsState extends State<AlertComponents> {
  DateTime _dateTime = DateTime.now();
  bool isLoading = true;
  DateTime? incomeDate;
  String incomeDateView = "";

  DateTime? expenseDate;
  String expenseDateView = "";

  TextEditingController incomeTitleController = TextEditingController();
  TextEditingController incomeAmountController = TextEditingController();
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.attach_money, color: Colors.white),
            ),
            new Padding(
              padding: EdgeInsets.all(2.0),
              child: new MaterialButton(
                onPressed: () {
                  expenseTitleController.text = "";
                  expenseAmountController.text = "";
                  expenseDateView = "";
                  expenseDate = null;
                  showDialog(
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
                            new Text("Gelir Ekle"),
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
                        content: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Container(
                            height: 220.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  style: TextStyle(color: Colors.white),
                                  maxLength: 20,
                                  controller: incomeTitleController,
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    counterStyle: TextStyle(
                                      height: double.minPositive,
                                    ),
                                    counterText: "",
                                    border: OutlineInputBorder(),
                                    labelText: 'Başlık',
                                    labelStyle: TextStyle(
                                      color: Colors.blueGrey,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
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
                                  style: TextStyle(color: Colors.white),
                                  maxLength: 40,
                                  controller: incomeAmountController,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    counterStyle: TextStyle(
                                      height: double.minPositive,
                                    ),
                                    counterText: "",
                                    border: OutlineInputBorder(),
                                    labelText: 'Tutar',
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
                                  incomeDateView,
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10.0),
                                RaisedButton.icon(
                                    color: AppColors.brightMainColor,
                                    onPressed: () async {
                                      incomeDate = await showDatePicker(
                                          context: context,
                                          initialDate: _dateTime,
                                          firstDate: _dateTime
                                              .subtract(Duration(days: 20)),
                                          lastDate: _dateTime
                                              .add(Duration(days: 30)));
                                      setState(() {
                                        incomeDateView =
                                            convertDateToString(incomeDate);
                                      });
                                    },
                                    icon: Icon(Icons.calendar_today),
                                    label: Text(
                                      "Tarih Seçiniz",
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                          );
                        }),
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
                            child: Text('Ekle',
                                style: TextStyle(color: Colors.white)),
                            color: Color(0xFFf17c03),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                            onPressed: () async {
                              if (incomeTitleController.text == "" ||
                                  incomeAmountController.text == "" ||
                                  incomeDate == null) {
                                return;
                              } else {
                                await Database.addIncomeExpense(
                                    IncomeExpense(
                                        title: incomeTitleController.text,
                                        amount: int.parse(
                                            incomeAmountController.text),
                                        isIncome: true,
                                        date: incomeDateView),
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
                child: new Text("Gelir Ekle",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
        new Row(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.money_off, color: Colors.white),
            ),
            new Padding(
              padding: EdgeInsets.all(2.0),
              child: new MaterialButton(
                onPressed: () {
                  incomeTitleController.text = "";
                  incomeAmountController.text = "";
                  incomeDateView = "";
                  incomeDate = null;
                  showDialog(
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
                            new Text("Harcama Ekle"),
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
                        content: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Container(
                            height: 220.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  style: TextStyle(color: Colors.white),
                                  maxLength: 20,
                                  cursorColor: Colors.white,
                                  controller: expenseTitleController,
                                  decoration: InputDecoration(
                                    counterStyle: TextStyle(
                                      height: double.minPositive,
                                    ),
                                    counterText: "",
                                    border: OutlineInputBorder(),
                                    labelText: 'Başlık',
                                    labelStyle: TextStyle(
                                      color: Colors.blueGrey,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
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
                                  style: TextStyle(color: Colors.white),
                                  maxLength: 40,
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.number,
                                  controller: expenseAmountController,
                                  decoration: InputDecoration(
                                    counterStyle: TextStyle(
                                      height: double.minPositive,
                                    ),
                                    counterText: "",
                                    border: OutlineInputBorder(),
                                    labelText: 'Tutar',
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
                                  expenseDateView,
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10.0),
                                RaisedButton.icon(
                                    color: AppColors.brightMainColor,
                                    onPressed: () async {
                                      expenseDate = await showDatePicker(
                                          context: context,
                                          initialDate: _dateTime,
                                          firstDate: _dateTime
                                              .subtract(Duration(days: 20)),
                                          lastDate: _dateTime
                                              .add(Duration(days: 30)));
                                      setState(() {
                                        expenseDateView =
                                            convertDateToString(expenseDate);
                                      });
                                    },
                                    icon: Icon(Icons.calendar_today),
                                    label: Text(
                                      "Tarih Seçiniz",
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                          );
                        }),
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
                            child: Text('Ekle',
                                style: TextStyle(color: Colors.white)),
                            color: Color(0xFFf17c03),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                            onPressed: () async {
                              if (expenseTitleController.text == "" ||
                                  expenseAmountController.text == "" ||
                                  expenseDate == null) {
                                return;
                              } else {
                                await Database.addIncomeExpense(
                                    IncomeExpense(
                                        title: expenseTitleController.text,
                                        amount: int.parse(
                                            expenseAmountController.text),
                                        isIncome: false,
                                        date: expenseDateView),
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
                child: new Text("Harcama Ekle",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ],
    );
  }

  String convertDateToString(DateTime? date) {
    if (date == null) {
      return "";
    } else {
      return date.day.toString() +
          "." +
          date.month.toString() +
          "." +
          date.year.toString();
    }
  }
}
