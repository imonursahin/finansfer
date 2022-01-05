import 'dart:convert';

import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/di/dio_client.dart';
import 'package:finansfer/core/network/models/response/exchange_gold_resp.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoldFavoritesPage extends StatefulWidget {
  @override
  State<GoldFavoritesPage> createState() => _GoldFavoritesPageState();
}

class _GoldFavoritesPageState extends State<GoldFavoritesPage> {
  DioClient _dioClient = DioClient();
  ExchangeGoldResp? goldList;
  String userEmail = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getGoldList();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Altın", style: TextStyle(color: Colors.white)),
                        Text("Alış", style: TextStyle(color: Colors.white)),
                        Text("Satış", style: TextStyle(color: Colors.white)),
                        Text("Değişim", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  goldList?.ataLongName != null && goldList!.ata!.isFavorite!
                      ? Container(
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(goldList?.ataLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.ata?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.ata?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.ata?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  goldList?.bslLongName != null && goldList!.bsl!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(goldList?.bslLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.bsl?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.bsl?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.bsl?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  goldList?.yarimLongName != null &&
                          goldList!.yarim!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(goldList?.yarimLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.yarim?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.yarim?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.yarim?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  goldList?.tamLongName != null && goldList!.tam!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(goldList?.tamLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.tam?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.tam?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.tam?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  goldList?.cmrLongName != null && goldList!.cmr!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(goldList?.cmrLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.cmr?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.cmr?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.cmr?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  goldList?.gagLongName != null && goldList!.gag!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(goldList?.gagLongName ?? "",
                                    style: TextStyle(color: Colors.grey)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.gag?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.gag?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.gag?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  goldList?.haLongName != null && goldList!.ha!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(goldList?.haLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.ha?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.ha?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    goldList?.ha?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
  }

  String getCroppedValue(text) {
    const start = "</a>";

    final startIndex = text.indexOf(start);
    return text.substring(startIndex + start.length, text.length);
  }

  getGoldList() async {
    try {
      if (!mounted) return;
      setState(() {
        loading = true;
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      userEmail = preferences.getString("userEmail") as String;
      final res =
          await _dioClient.get("https://api.genelpara.com/embed/altin.json");
      var json = jsonDecode(res);

      final favoriteGolds = await Database.getGoldFavorite(userEmail);

      setState(() {
        goldList = ExchangeGoldResp.fromJson(json);

        for (var item in favoriteGolds) {
          if (item.type == "ata") {
            goldList!.ata!.isFavorite = true;
            goldList!.ata!.docId = item.docId;
          }

          if (item.type == "bsl") {
            goldList!.bsl!.isFavorite = true;
            goldList!.bsl!.docId = item.docId;
          }

          if (item.type == "yarim") {
            goldList!.yarim!.isFavorite = true;
            goldList!.yarim!.docId = item.docId;
          }

          if (item.type == "tam") {
            goldList!.tam!.isFavorite = true;
            goldList!.tam!.docId = item.docId;
          }

          if (item.type == "cmr") {
            goldList!.cmr!.isFavorite = true;
            goldList!.cmr!.docId = item.docId;
          }
          if (item.type == "gag") {
            goldList!.gag!.isFavorite = true;
            goldList!.gag!.docId = item.docId;
          }
          if (item.type == "ha") {
            goldList!.ha!.isFavorite = true;
            goldList!.ha!.docId = item.docId;
          }
        }

        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
      print("error");
    }
  }
}
