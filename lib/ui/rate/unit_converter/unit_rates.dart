import 'dart:convert';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UnitRates extends StatefulWidget {
  @override
  _UnitRatesState createState() => _UnitRatesState();
}

class _UnitRatesState extends State<UnitRates> {
  bool num1 = true;
  bool from = true;
  bool end = true;
  double? rate;
  double factor = 0;

  TextEditingController controller = TextEditingController();
  String dropvalue = "USD", tovalue = "TRY";
  final key = GlobalKey<ScaffoldState>();
  final list = [
    "INR",
    "USD",
    "EUR",
    "JPY",
    "BGN",
    "CZK",
    "DKK",
    "GBP",
    "HUF",
    "PLN",
    "SEK",
    "CHF",
    "AUD",
    "BRL",
    "CAD",
    "CNY",
    "RUB",
    "HKD",
    "NOK",
    "ILS",
    "KRW",
    "NZD",
    "PHP",
    "ZAR",
    "THB",
    "SGD",
    "RON",
    "HRK",
    "ISK",
    "IDR",
    "TRY",
    "MXN"
  ];

  getrate() async {
    final response = await http.get(Uri.parse(
        "http://api.exchangeratesapi.io/v1/latest?access_key=0b5e40c8e2f6adab87ac316dac431b7f&format=1"));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonrate = jsonDecode(response.body);
      factor = jsonrate["rates"][tovalue].toDouble();
      setState(() {
        rate = factor * (double.parse(controller.text));
      });
    } else {
      throw Exception();
    }
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
            title: Text("Kur Dönüştürücü"),
          ),
          body: Container(
            color: AppColors.mainColor,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        controller: controller,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: "Tutar Girin",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            num1 = true;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: dropvalue,
                        hint: Text("From"),
                        items: list.map((String value) {
                          return new DropdownMenuItem(
                            value: value,
                            child: Text(value,
                                style: TextStyle(color: Colors.green)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropvalue = value!;
                            from = true;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: tovalue,
                        hint: Text(
                          "To",
                        ),
                        items: list.map((String value) {
                          return new DropdownMenuItem(
                            value: value,
                            child: Text(value,
                                style: TextStyle(color: Colors.green)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            tovalue = value!;
                            end = true;
                          });
                        },
                      ),
                      SizedBox(height: 50),
                      Text(rate != null ? rate.toString() : "",
                          style: TextStyle(color: Colors.green)),
                      SizedBox(height: 10),
                      RaisedButton(
                        child: Text(
                          "Çevir",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (num1 == true && from == true && end == true) {
                            getrate();
                          } else {
                            print("1");
                          }
                        },
                        color: AppColors.btnOrange,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
