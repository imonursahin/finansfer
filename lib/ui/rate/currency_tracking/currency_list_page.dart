import 'dart:convert';
import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/di/dio_client.dart';
import 'package:finansfer/core/network/models/response/exchange_currency_resp.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyListPage extends StatefulWidget {
  @override
  State<CurrencyListPage> createState() => _CurrencyListPageState();
}

class _CurrencyListPageState extends State<CurrencyListPage> {
  TextEditingController searchController = new TextEditingController();

  DioClient _dioClient = DioClient();
  ExchangeCurrencyResp? currencyList;
  ExchangeCurrencyResp? tempCurrencyList;
  String userEmail = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getCurrencyList();
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
                ExchangeCurrencyResp? temp = new ExchangeCurrencyResp();
                currencyList = tempCurrencyList;
                if (currencyList!.uahLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.uah = currencyList?.uah;
                  temp.uahLongName = currencyList?.uahLongName;
                }
                if (currencyList!.eurLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.eur = currencyList?.eur;
                  temp.eurLongName = currencyList?.eurLongName;
                }
                if (currencyList!.gbpLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.gbp = currencyList?.gbp;
                  temp.gbpLongName = currencyList?.gbpLongName;
                }
                if (currencyList!.chfLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.chf = currencyList?.chf;
                  temp.chfLongName = currencyList?.chfLongName;
                }
                if (currencyList!.cadLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.cad = currencyList?.cad;
                  temp.cadLongName = currencyList?.cadLongName;
                }
                if (currencyList!.rubLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.rub = currencyList?.rub;
                  temp.rubLongName = currencyList?.rubLongName;
                }
                if (currencyList!.audLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.aud = currencyList?.aud;
                  temp.audLongName = currencyList?.audLongName;
                }
                if (currencyList!.phpLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.php = currencyList?.php;
                  temp.phpLongName = currencyList?.phpLongName;
                }
                if (currencyList!.jpyLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.jpy = currencyList?.jpy;
                  temp.jpyLongName = currencyList?.jpyLongName;
                }
                if (currencyList!.aznLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.azn = currencyList?.azn;
                  temp.aznLongName = currencyList?.aznLongName;
                }
                if (currencyList!.copLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.cop = currencyList?.cop;
                  temp.copLongName = currencyList?.copLongName;
                }
                if (currencyList!.kwdLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.kwd = currencyList?.kwd;
                  temp.kwdLongName = currencyList?.kwdLongName;
                }

                currencyList = temp;

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
                labelText: 'Döviz Ara',
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
                            Text("Döviz",
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
                      currencyList?.uahLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.uahLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.uah?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.uah?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.uah?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.uah!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.uah!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "uah", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.uah!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.uah!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      currencyList?.eurLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.eurLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.eur?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.eur?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.eur?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.eur!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.eur!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "eur", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.eur!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.eur!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      currencyList?.gbpLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.gbpLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.gbp?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.gbp?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.gbp?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.gbp!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.gbp!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "gbp", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.gbp!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.gbp!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      currencyList?.chfLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.chfLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.chf?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.chf?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.chf?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.chf!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.chf!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "chf", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.chf!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.chf!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      currencyList?.cadLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.cadLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.cad?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.cad?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.cad?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.cad!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.cad!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "cad", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.cad!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.cad!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      currencyList?.rubLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.rubLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.rub?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.rub?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.rub?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.rub!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.rub!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "rub", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.rub!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.rub!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      currencyList?.audLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.audLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.aud?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.aud?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.aud?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.aud!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.aud!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "aud", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.aud!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.aud!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      currencyList?.phpLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.phpLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.php?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.php?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.php?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.php!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.php!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "php", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.php!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.php!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      currencyList?.jpyLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.jpyLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.jpy?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.jpy?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.jpy?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.jpy!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.jpy!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "jpy", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.jpy!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.jpy!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      currencyList?.aznLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.aznLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.azn?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.azn?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.azn?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.azn!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.azn!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "azn", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.azn!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.azn!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      currencyList?.copLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.copLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.cop?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.cop?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.cop?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.cop!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.cop!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "cop", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.cop!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.cop!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      currencyList?.kwdLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(currencyList?.kwdLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.kwd?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.kwd?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        currencyList?.kwd?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: currencyList!.kwd!.isFavorite == true
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
                                      bool? temp =
                                          currencyList!.kwd!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCurrencyFavorite(
                                            "kwd", userEmail);
                                        getCurrencyList();
                                      } else {
                                        await Database.deleteCurrencyFavorite(
                                            currencyList!.kwd!.docId!,
                                            userEmail);
                                        getCurrencyList();
                                      }
                                      setState(() {
                                        currencyList!.kwd!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
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

      final favoriteCurrency = await Database.getCurrencyFavorite(userEmail);

      setState(() {
        currencyList = ExchangeCurrencyResp.fromJson(json);

        for (var item in favoriteCurrency) {
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

        tempCurrencyList = currencyList;
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
