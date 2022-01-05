import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.brightMainColor,
          title: Text("Finans Haberleri"),
        ),
        body: Container(
          color: AppColors.mainColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Column(children: <Widget>[
                    Container(
                      child: Text(
                        "Bitcoin tüm zamanların en yüksek fiyatını gördü", // Bugünün Tarihi
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: AppColors.btnOrange,
                          fontFamily: 'Nunito',
                        ),
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
              Column(
                children: [
                  Text("Haber içeriği", style: TextStyle(color: Colors.white))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
