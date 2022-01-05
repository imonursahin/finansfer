import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/models/request/payment_planner.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class PaymentPlannerHomePage extends StatefulWidget {
  @override
  State<PaymentPlannerHomePage> createState() => _PaymentPlannerHomePageState();
}

class _PaymentPlannerHomePageState extends State<PaymentPlannerHomePage> {
  DateTime _dateTime = DateTime.now();
  String? userEmail = "";
  List<PaymentPlanner> paymentPlannerList = [];
  bool isLoading = true;
  Event? calendar;
  var val = -1;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPaymentPlanner();
  }

  @override
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
          title: Text("Ödeme Planlayıcısı"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.mainColor,
          child: Column(
            children: <Widget>[
              Padding(
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
                                        Icon(Icons.add, color: Colors.white),
                                        new Text("Ödeme Planı Oluştur"),
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
                                    titleTextStyle: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        height: 270.0,
                                        child: Column(
                                          children: [
                                            TextField(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              maxLength: 35,
                                              cursorColor: Colors.white,
                                              controller: titleController,
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
                                                  onPressed: () {
                                                    titleController.text = "";
                                                  },
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
                                              controller: descController,
                                              cursorColor: Colors.white,
                                              decoration: InputDecoration(
                                                counterStyle: TextStyle(
                                                  height: double.minPositive,
                                                ),
                                                counterText: "",
                                                border: OutlineInputBorder(),
                                                labelText: 'Açıklama',
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
                                                        borderSide: BorderSide(
                                                            color: Colors.white,
                                                            width: 2)),
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    descController.text = "";
                                                  },
                                                  icon: Icon(Icons.clear,
                                                      size: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10.0),
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Radio(
                                                              value: 1,
                                                              groupValue: val,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  val = 1;
                                                                });
                                                              }),
                                                          Expanded(
                                                            child: Text(
                                                                'Günlük',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12)),
                                                          )
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Radio(
                                                              value: 2,
                                                              groupValue: val,
                                                              onChanged:
                                                                  (index) {
                                                                setState(() {
                                                                  val = 2;
                                                                });
                                                              }),
                                                          Expanded(
                                                              child: Text(
                                                                  'Haftalık',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12)))
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Radio(
                                                              value: 3,
                                                              groupValue: val,
                                                              onChanged:
                                                                  (index) {
                                                                setState(() {
                                                                  val = 3;
                                                                });
                                                              }),
                                                          Expanded(
                                                              child: Text(
                                                                  'Aylık',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12)))
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      // ignore: deprecated_member_use
                                      new RaisedButton(
                                        child: Text('İptal',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0))),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      // ignore: deprecated_member_use
                                      new RaisedButton(
                                        child: Text('Oluştur',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Color(0xFFf17c03),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0))),
                                        onPressed: () async {
                                          if (titleController.text == "" ||
                                              descController.text == "") return;
                                          String plan = val == 1
                                              ? "Günlük"
                                              : val == 2
                                                  ? "Haftalık"
                                                  : val == 3
                                                      ? "Aylık"
                                                      : "";
                                          calendar = Event(
                                            title: titleController.text,
                                            description: descController.text,
                                            startDate: DateTime.now(),
                                            endDate: DateTime.now()
                                                .add(Duration(minutes: 30)),
                                          );
                                          await Add2Calendar.addEvent2Cal(
                                              calendar!);
                                          await Database.addPaymentPlanner(
                                              PaymentPlanner(
                                                  title: titleController.text,
                                                  desc: descController.text,
                                                  plan: plan),
                                              userEmail ?? "");
                                          titleController.text = "";
                                          descController.text = "";
                                          val = -1;
                                          Navigator.pop(context);
                                          getPaymentPlanner();
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
                          child: Text('Ödeme Planlayıcısı Oluştur',
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
              Container(
                width: double.infinity,
                // color: Colors.pink,
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: paymentPlannerList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 6.0, right: 6.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(width: 50),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete_forever,
                                      ),
                                      color: Colors.red,
                                      onPressed: () async {
                                        await Database.deletePaymentPlanner(
                                            paymentPlannerList[index]
                                                .docId
                                                .toString(),
                                            userEmail ?? "");
                                        getPaymentPlanner();
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
                                          paymentPlannerList[index]
                                              .title
                                              .toString(),
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
                                          paymentPlannerList[index]
                                              .plan
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14),
                                          textAlign: TextAlign.left,
                                          textDirection: TextDirection.ltr,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      paymentPlannerList[index].desc.toString(),
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
                          );
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getPaymentPlanner() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmail = preferences.getString("userEmail");
    paymentPlannerList = await Database.getPaymentPlanner(userEmail ?? "");
    setState(() {
      isLoading = false;
    });
  }
}
