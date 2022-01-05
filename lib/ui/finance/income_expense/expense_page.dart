import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/models/request/income_expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensePage extends StatefulWidget {
  final List<IncomeExpense> expenseList;
  final String userEmail;
  final Function onDeleteFunction;

  const ExpensePage(this.expenseList, this.userEmail, this.onDeleteFunction);

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  void initState() {
    super.initState();
    sortListByDate(widget.expenseList);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: widget.expenseList.length,
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
                            backgroundColor: Colors.red,
                            maxRadius: 30,
                            child: Text(
                              widget.expenseList[index].amount.toString() + "₺",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          title: Text(
                            widget.expenseList[index].title.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          subtitle: Text(
                            widget.expenseList[index].date ?? "",
                            style:
                                TextStyle(color: Colors.orange, fontSize: 10),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 22,
                            ),
                            color: Colors.red,
                            onPressed: () {
                              deleteIncome(
                                  widget.expenseList[index].docId ?? "");
                            },
                          ),
                        ),
                      ))));
        });
  }

  deleteIncome(docId) async {
    await Database.deleteIncomeExpense(docId, widget.userEmail);
    widget.onDeleteFunction();
  }

  DateTime convertStringToDate(String? date) {
    if (date == null || date == "") return DateTime.now();
    var inputFormat = DateFormat("dd.MM.yyyy");
    var datetime = inputFormat.parse(date).toLocal();

    return datetime;
  }

  sortListByDate(List<IncomeExpense> incomeList) {
    incomeList.sort((a, b) {
      return convertStringToDate(a.date).compareTo(convertStringToDate(b.date));
    });
  }
}
