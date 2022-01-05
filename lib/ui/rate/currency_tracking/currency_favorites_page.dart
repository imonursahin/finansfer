import 'dart:convert';

import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/di/dio_client.dart';
import 'package:finansfer/core/network/models/response/exchange_currency_resp.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyFavoritesPage extends StatefulWidget {
  @override
  State<CurrencyFavoritesPage> createState() => _CurrencyFavoritesPageState();
}

class _CurrencyFavoritesPageState extends State<CurrencyFavoritesPage> {
  DioClient _dioClient = DioClient();
  ExchangeCurrencyResp? currencyList;
  String userEmail = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getCurrencyList();
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
                        Text("Döviz", style: TextStyle(color: Colors.white)),
                        Text("Alış", style: TextStyle(color: Colors.white)),
                        Text("Satış", style: TextStyle(color: Colors.white)),
                        Text("Değişim", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  currencyList?.uahLongName != null &&
                          currencyList!.uah!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.uahLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.uah?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.uah?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.uah?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  currencyList?.eurLongName != null &&
                          currencyList!.eur!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.eurLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.eur?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.eur?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.eur?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  currencyList?.gbpLongName != null &&
                          currencyList!.gbp!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.gbpLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.gbp?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.gbp?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.gbp?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  currencyList?.chfLongName != null &&
                          currencyList!.chf!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.chfLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.chf?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.chf?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.chf?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  currencyList?.cadLongName != null &&
                          currencyList!.cad!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.cadLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.cad?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.cad?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.cad?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  currencyList?.rubLongName != null &&
                          currencyList!.rub!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.rubLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.rub?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.rub?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.rub?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  currencyList?.audLongName != null &&
                          currencyList!.aud!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.audLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.aud?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.aud?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.aud?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  currencyList?.phpLongName != null &&
                          currencyList!.php!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.phpLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.php?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.php?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.php?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  currencyList?.jpyLongName != null &&
                          currencyList!.jpy!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.jpyLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.jpy?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.jpy?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.jpy?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  currencyList?.aznLongName != null &&
                          currencyList!.azn!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.aznLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.azn?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.azn?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.azn?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  currencyList?.copLongName != null &&
                          currencyList!.cop!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.copLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.cop?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.cop?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.cop?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  currencyList?.kwdLongName != null &&
                          currencyList!.kwd!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(currencyList?.kwdLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.kwd?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.kwd?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    currencyList?.kwd?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
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

  getCurrencyList() async {
    try {
      if (!mounted) return;
      setState(() {
        loading = true;
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      userEmail = preferences.getString("userEmail") as String;
      final res =
          await _dioClient.get("https://api.genelpara.com/embed/doviz.json");
      var json = jsonDecode(res);

      final favoriteCurrencys = await Database.getCurrencyFavorite(userEmail);

      setState(() {
        currencyList = ExchangeCurrencyResp.fromJson(json);

        for (var item in favoriteCurrencys) {
          if (item.type == "uah") {
            currencyList!.uah!.isFavorite = true;
            currencyList!.uah!.docId = item.docId;
          }

          if (item.type == "eur") {
            currencyList!.eur!.isFavorite = true;
            currencyList!.eur!.docId = item.docId;
          }
          if (item.type == "gbp") {
            currencyList!.gbp!.isFavorite = true;
            currencyList!.gbp!.docId = item.docId;
          }
          if (item.type == "chf") {
            currencyList!.chf!.isFavorite = true;
            currencyList!.chf!.docId = item.docId;
          }
          if (item.type == "cad") {
            currencyList!.cad!.isFavorite = true;
            currencyList!.cad!.docId = item.docId;
          }
          if (item.type == "rub") {
            currencyList!.rub!.isFavorite = true;
            currencyList!.rub!.docId = item.docId;
          }

          if (item.type == "aud") {
            currencyList!.aud!.isFavorite = true;
            currencyList!.aud!.docId = item.docId;
          }
          if (item.type == "php") {
            currencyList!.php!.isFavorite = true;
            currencyList!.php!.docId = item.docId;
          }
          if (item.type == "jpy") {
            currencyList!.jpy!.isFavorite = true;
            currencyList!.jpy!.docId = item.docId;
          }
          if (item.type == "azn") {
            currencyList!.azn!.isFavorite = true;
            currencyList!.azn!.docId = item.docId;
          }
          if (item.type == "cop") {
            currencyList!.cop!.isFavorite = true;
            currencyList!.cop!.docId = item.docId;
          }

          if (item.type == "kwd") {
            currencyList!.kwd!.isFavorite = true;
            currencyList!.kwd!.docId = item.docId;
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
