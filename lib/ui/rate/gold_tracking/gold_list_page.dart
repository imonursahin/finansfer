import 'dart:convert';

import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/di/dio_client.dart';
import 'package:finansfer/core/network/models/response/exchange_gold_resp.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoldListPage extends StatefulWidget {
  @override
  State<GoldListPage> createState() => _GoldListPageState();
}

class _GoldListPageState extends State<GoldListPage> {
  TextEditingController searchController = new TextEditingController();

  DioClient _dioClient = DioClient();
  ExchangeGoldResp? goldList;
  ExchangeGoldResp? tempGoldList;
  String userEmail = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getGoldList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (val) {
                ExchangeGoldResp? temp = new ExchangeGoldResp();
                goldList = tempGoldList;
                if (goldList!.ataLongName!.toLowerCase().trim().contains(val)) {
                  temp.ata = goldList?.ata;
                  temp.ataLongName = goldList?.ataLongName;
                }
                if (goldList!.bslLongName!.toLowerCase().trim().contains(val)) {
                  temp.bsl = goldList?.bsl;
                  temp.bslLongName = goldList?.bslLongName;
                }
                if (goldList!.yarimLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.yarim = goldList?.yarim;
                  temp.yarimLongName = goldList?.yarimLongName;
                }
                if (goldList!.tamLongName!.toLowerCase().trim().contains(val)) {
                  temp.tam = goldList?.tam;
                  temp.tamLongName = goldList?.tamLongName;
                }
                if (goldList!.cmrLongName!.toLowerCase().trim().contains(val)) {
                  temp.cmr = goldList?.cmr;
                  temp.cmrLongName = goldList?.cmrLongName;
                }
                if (goldList!.gagLongName!.toLowerCase().trim().contains(val)) {
                  temp.gag = goldList?.gag;
                  temp.gagLongName = goldList?.gagLongName;
                }
                if (goldList!.haLongName!.toLowerCase().trim().contains(val)) {
                  temp.ha = goldList?.gag;
                  temp.haLongName = goldList?.haLongName;
                }
                goldList = temp;

                setState(() {});
              },
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              controller: searchController,
              decoration: InputDecoration(
                counterStyle: TextStyle(
                  height: double.minPositive,
                ),
                counterText: "",
                border: OutlineInputBorder(),
                labelText: 'Altın Ara',
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2)),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search, size: 30, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          loading
              ? CircularProgressIndicator()
              : Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Altın",
                                style: TextStyle(color: Colors.white)),
                            Text("Alış", style: TextStyle(color: Colors.white)),
                            Text("Satış",
                                style: TextStyle(color: Colors.white)),
                            Text("Değişim",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      goldList?.ataLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        goldList?.ata?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: goldList!.ata!.isFavorite == true
                                        ? Icon(
                                            Icons.favorite,
                                            size: 18,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            size: 18,
                                          ),
                                    color: Colors.red,
                                    onPressed: () async {
                                      if (!mounted) return;
                                      bool? temp = goldList!.ata!.isFavorite;
                                      if (temp == false) {
                                        await Database.addGoldFavorite(
                                            "ata", userEmail);
                                        getGoldList();
                                      } else {
                                        await Database.deleteGoldFavorite(
                                            goldList!.ata!.docId!, userEmail);
                                        getGoldList();
                                      }
                                      setState(() {
                                        goldList!.ata!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      goldList?.bslLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        goldList?.bsl?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: goldList!.bsl!.isFavorite == true
                                        ? Icon(
                                            Icons.favorite,
                                            size: 18,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            size: 18,
                                          ),
                                    color: Colors.red,
                                    onPressed: () async {
                                      if (!mounted) return;
                                      bool? temp = goldList!.bsl!.isFavorite;
                                      if (temp == false) {
                                        await Database.addGoldFavorite(
                                            "bsl", userEmail);
                                        getGoldList();
                                      } else {
                                        await Database.deleteGoldFavorite(
                                            goldList!.bsl!.docId!, userEmail);
                                        getGoldList();
                                      }
                                      setState(() {
                                        goldList!.bsl!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      goldList?.yarimLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        goldList?.yarim?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        goldList?.yarim?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: goldList!.yarim!.isFavorite == true
                                        ? Icon(
                                            Icons.favorite,
                                            size: 18,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            size: 18,
                                          ),
                                    color: Colors.red,
                                    onPressed: () async {
                                      if (!mounted) return;
                                      bool? temp = goldList!.yarim!.isFavorite;
                                      if (temp == false) {
                                        await Database.addGoldFavorite(
                                            "yarim", userEmail);
                                        getGoldList();
                                      } else {
                                        await Database.deleteGoldFavorite(
                                            goldList!.yarim!.docId!, userEmail);
                                        getGoldList();
                                      }
                                      setState(() {
                                        goldList!.yarim!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      goldList?.tamLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        goldList?.tam?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: goldList!.tam!.isFavorite == true
                                        ? Icon(
                                            Icons.favorite,
                                            size: 18,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            size: 18,
                                          ),
                                    color: Colors.red,
                                    onPressed: () async {
                                      if (!mounted) return;
                                      bool? temp = goldList!.tam!.isFavorite;
                                      if (temp == false) {
                                        await Database.addGoldFavorite(
                                            "tam", userEmail);
                                        getGoldList();
                                      } else {
                                        await Database.deleteGoldFavorite(
                                            goldList!.tam!.docId!, userEmail);
                                        getGoldList();
                                      }
                                      setState(() {
                                        goldList!.tam!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      goldList?.cmrLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        goldList?.cmr?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: goldList!.cmr!.isFavorite == true
                                        ? Icon(
                                            Icons.favorite,
                                            size: 18,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            size: 18,
                                          ),
                                    color: Colors.red,
                                    onPressed: () async {
                                      if (!mounted) return;
                                      bool? temp = goldList!.cmr!.isFavorite;
                                      if (temp == false) {
                                        await Database.addGoldFavorite(
                                            "cmr", userEmail);
                                        getGoldList();
                                      } else {
                                        await Database.deleteGoldFavorite(
                                            goldList!.cmr!.docId!, userEmail);
                                        getGoldList();
                                      }
                                      setState(() {
                                        goldList!.cmr!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      goldList?.gagLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        goldList?.gag?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: goldList!.gag!.isFavorite == true
                                        ? Icon(
                                            Icons.favorite,
                                            size: 18,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            size: 18,
                                          ),
                                    color: Colors.red,
                                    onPressed: () async {
                                      if (!mounted) return;
                                      bool? temp = goldList!.gag!.isFavorite;
                                      if (temp == false) {
                                        await Database.addGoldFavorite(
                                            "gag", userEmail);
                                        getGoldList();
                                      } else {
                                        await Database.deleteGoldFavorite(
                                            goldList!.gag!.docId!, userEmail);
                                        getGoldList();
                                      }
                                      setState(() {
                                        goldList!.gag!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      goldList?.haLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  IconButton(
                                    icon: goldList!.ha!.isFavorite == true
                                        ? Icon(
                                            Icons.favorite,
                                            size: 18,
                                          )
                                        : Icon(
                                            Icons.favorite_border_outlined,
                                            size: 18,
                                          ),
                                    color: Colors.red,
                                    onPressed: () async {
                                      if (!mounted) return;
                                      bool? temp = goldList!.ha!.isFavorite;
                                      if (temp == false) {
                                        await Database.addGoldFavorite(
                                            "ha", userEmail);
                                        getGoldList();
                                      } else {
                                        await Database.deleteGoldFavorite(
                                            goldList!.ha!.docId!, userEmail);
                                        getGoldList();
                                      }
                                      setState(() {
                                        goldList!.ha!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                )
        ],
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

        tempGoldList = goldList;
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
