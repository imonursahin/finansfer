import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:finansfer/core/network/models/request/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class ToDoDaily extends StatefulWidget {
  String userEmail;
  ToDoDaily(this.userEmail);

  @override
  _ToDoDailyState createState() => _ToDoDailyState();
}

class _ToDoDailyState extends State<ToDoDaily> {
  List<ToDo> todoList = [];
  bool isLoading = false;

  TextEditingController todoTitleController = TextEditingController();
  TextEditingController todoDescController = TextEditingController();

  String finalDate = '';

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
    getDatabaseToDo();
  }

  getDatabaseToDo() async {
    setState(() {
      isLoading = true;
    });
    todoList = await Database.todoList(widget.userEmail);
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
          title: Text("Bugün Yapılacaklar"),
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
                      padding: const EdgeInsets.only(top: 2),
                      child: Center(
                        child: Column(children: <Widget>[
                          Container(
                            child: Text(
                              finalDate, // Bugünün Tarihi
                              textScaleFactor: 1.8,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Container(
                            child: Text(
                              "Bugün yapman gereken " +
                                  todoList.length.toString() +
                                  " şey var",
                              style: TextStyle(color: Colors.white70),
                            ),
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
                  itemCount: todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: double.infinity,
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
                                        Icons.check_box_rounded,
                                      ),
                                      color: Colors.green,
                                      onPressed: () async {
                                        await Database.deleteToDo(
                                            todoList[index].docId!,
                                            widget.userEmail);
                                        getDatabaseToDo();
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
                                    Text(
                                      todoList[index].title.toString(),
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Nunito',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300),
                                      textAlign: TextAlign.start,
                                      textDirection: TextDirection.ltr,
                                    ),
                                    // SizedBox(height: 2),
                                    Text(
                                      todoList[index].desc.toString(),
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
                  })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
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
                      new Text("Bugün ne yapacaksın?"),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.cancel,
                        ),
                        iconSize: 25,
                        color: Colors.red,
                        onPressed: () {
                          todoTitleController.clear();

                          todoDescController.clear();

                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  titleTextStyle:
                      TextStyle(fontSize: 18.0, color: Colors.white),
                  content: Container(
                    height: 160.0,
                    child: Column(
                      children: [
                        TextField(
                          style: TextStyle(color: Colors.white),
                          controller: todoTitleController,
                          maxLength: 35,
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
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
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
                          controller: todoDescController,
                          maxLength: 55,
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
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.clear,
                                  size: 10, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    // ignore: deprecated_member_use
                    new RaisedButton(
                      child:
                          Text('İptal', style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      onPressed: () {
                        todoTitleController.clear();

                        todoDescController.clear();
                        Navigator.pop(context);
                      },
                    ),
                    // ignore: deprecated_member_use
                    new RaisedButton(
                      child:
                          Text('Ekle', style: TextStyle(color: Colors.white)),
                      color: Color(0xFFf17c03),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      onPressed: () async {
                        if (todoTitleController.text == "" ||
                            todoDescController.text == "") {
                          return;
                        } else {
                          await Database.addToDo(
                              ToDo(
                                title: todoTitleController.text,
                                desc: todoDescController.text,
                              ),
                              widget.userEmail);
                          getDatabaseToDo();
                          todoTitleController.clear();

                          todoDescController.clear();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: AppColors.btnOrange,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
