import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/models/request/debit_record.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DebitRecordHomePage extends StatefulWidget {
  String userEmail;
  DebitRecordHomePage(this.userEmail);

  @override
  State<DebitRecordHomePage> createState() => _DebitRecordHomePageState();
}

class _DebitRecordHomePageState extends State<DebitRecordHomePage> {
  List<DebitRecord> debitList = [];
  bool isLoading = false;
  int debitAmount = 0;
  DateTime? selectedDate;
  String selectedDateView = "";

  TextEditingController debitTitleController = TextEditingController();
  TextEditingController debitAmountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getDatabaseDebitRecord();
  }

  getDatabaseDebitRecord() async {
    setState(() {
      isLoading = true;
    });
    debitList = await Database.debitList(widget.userEmail);
    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: AppColors.brightMainColor,
          title: Text("Borç Kayıt"),
        ),
        body: Container(
          color: AppColors.mainColor,
          child: Column(
            children: <Widget>[
              isLoading
                  ? Container(
                      margin: EdgeInsets.only(top: 25),
                      child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: Column(children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                height: 50.0,
                                minWidth: 300.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setState) {
                                        return AlertDialog(
                                          backgroundColor: Color(0xFF29313c),
                                          elevation: 25,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          title: Row(
                                            children: [
                                              Icon(Icons.add,
                                                  color: Colors.white),
                                              new Text("Borç Kaydı Oluştur"),
                                              Spacer(),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.cancel,
                                                ),
                                                iconSize: 25,
                                                color: Colors.red,
                                                onPressed: () {
                                                  debitTitleController.clear();
                                                  debitAmountController.clear();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                          titleTextStyle: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white),
                                          content: Container(
                                            height: 240.0,
                                            child: Column(
                                              children: [
                                                TextField(
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  maxLength: 35,
                                                  cursorColor: Colors.white,
                                                  controller:
                                                      debitTitleController,
                                                  decoration: InputDecoration(
                                                    counterStyle: TextStyle(
                                                      height:
                                                          double.minPositive,
                                                    ),
                                                    counterText: "",
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText:
                                                        'Borç Alınan Kişi',
                                                    labelStyle: TextStyle(
                                                      color: Colors.blueGrey,
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 2),
                                                    ),
                                                    suffixIcon: IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(Icons.clear,
                                                          size: 10,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10.0),
                                                TextField(
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  maxLength: 55,
                                                  cursorColor: Colors.white,
                                                  controller:
                                                      debitAmountController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    counterStyle: TextStyle(
                                                      height:
                                                          double.minPositive,
                                                    ),
                                                    counterText: "",
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Borç Tutarı',
                                                    labelStyle: TextStyle(
                                                      color: Colors.blueGrey,
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white,
                                                                    width: 2)),
                                                    suffixIcon: IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(Icons.clear,
                                                          size: 10,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10.0),
                                                Text(
                                                  selectedDateView,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                SizedBox(height: 10.0),
                                                RaisedButton.icon(
                                                    color: AppColors
                                                        .brightMainColor,
                                                    onPressed: () async {
                                                      selectedDate =
                                                          await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate: DateTime
                                                                      .now()
                                                                  .subtract(
                                                                      Duration(
                                                                          days:
                                                                              20)),
                                                              lastDate: DateTime
                                                                      .now()
                                                                  .add(Duration(
                                                                      days:
                                                                          30)));

                                                      setState(() {
                                                        selectedDateView =
                                                            convertDateToString(
                                                                selectedDate);
                                                      });
                                                    },
                                                    icon: Icon(
                                                        Icons.calendar_today,
                                                        color: Colors.white),
                                                    label: Text(
                                                      "Geri Ödeme Tarihini Seçiniz",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                SizedBox(height: 10.0),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            // ignore: deprecated_member_use
                                            new RaisedButton(
                                              child: Text('İptal',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              color: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              16.0))),
                                              onPressed: () {
                                                debitTitleController.clear();
                                                debitAmountController.clear();
                                                Navigator.pop(context);
                                              },
                                            ),
                                            // ignore: deprecated_member_use
                                            new RaisedButton(
                                              child: Text('Oluştur',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              color: Color(0xFFf17c03),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              16.0))),
                                              onPressed: () async {
                                                if (debitTitleController
                                                            .text ==
                                                        "" ||
                                                    debitAmountController
                                                            .text ==
                                                        "" ||
                                                    selectedDate == null) {
                                                  return;
                                                } else {
                                                  await Database.addDebitRecord(
                                                      DebitRecord(
                                                          title:
                                                              debitTitleController
                                                                  .text,
                                                          amount: int.parse(
                                                              debitAmountController
                                                                  .text),
                                                          date:
                                                              selectedDateView),
                                                      widget.userEmail);
                                                  getDatabaseDebitRecord();
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    },
                                  );
                                },
                                padding: EdgeInsets.all(12),
                                color: AppColors.btnOrange,
                                child: Text('Borç Kaydı Oluştur',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
              Divider(
                height: 30.0,
                color: Color(0xFF323c45),
                indent: 150,
                endIndent: 150,
                thickness: 1.3,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: debitList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: double.infinity,
                      // color: Colors.pink,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 6.0, right: 6.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(width: 50),
                                    IconButton(
                                      icon: Icon(
                                        Icons.check_box_sharp,
                                      ),
                                      color: Colors.green,
                                      onPressed: () async {
                                        await Database.deleteDebitRecord(
                                            debitList[index].docId!,
                                            widget.userEmail);
                                        getDatabaseDebitRecord();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text(
                                          debitList[index].title.toString(),
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'Nunito',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300),
                                          textAlign: TextAlign.start,
                                          textDirection: TextDirection.ltr,
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          "Geri Ödeme Tarihi: " +
                                              debitList[index].date.toString(),
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14),
                                          textAlign: TextAlign.left,
                                          textDirection: TextDirection.ltr,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      debitList[index].amount.toString() +
                                          " ₺ borç aldım",
                                      style: TextStyle(
                                          color: Colors.white38,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14),
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
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
