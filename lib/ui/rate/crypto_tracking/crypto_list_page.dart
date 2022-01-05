import 'dart:convert';
import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/di/dio_client.dart';
import 'package:finansfer/core/network/models/response/exchange_crypto_resp.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CryptoListPage extends StatefulWidget {
  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  TextEditingController searchController = new TextEditingController();

  DioClient _dioClient = DioClient();
  ExchangeCryptoResp? cryptoList;
  ExchangeCryptoResp? tempCryptoList;
  String userEmail = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getCryptoList();
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
                ExchangeCryptoResp? temp = new ExchangeCryptoResp();
                cryptoList = tempCryptoList;
                if (cryptoList!.usdtLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.usdt = cryptoList?.usdt;
                  temp.usdtLongName = cryptoList?.usdtLongName;
                }
                if (cryptoList!.xmrLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.xmr = cryptoList?.xmr;
                  temp.xmrLongName = cryptoList?.xmrLongName;
                }
                if (cryptoList!.xrpLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.xrp = cryptoList?.xrp;
                  temp.xrpLongName = cryptoList?.xrpLongName;
                }
                if (cryptoList!.ltcLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.ltc = cryptoList?.ltc;
                  temp.ltcLongName = cryptoList?.ltcLongName;
                }
                if (cryptoList!.bttLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.btt = cryptoList?.btt;
                  temp.bttLongName = cryptoList?.bttLongName;
                }
                if (cryptoList!.hotLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.hot = cryptoList?.hot;
                  temp.hotLongName = cryptoList?.hotLongName;
                }
                if (cryptoList!.qtumLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.qtum = cryptoList?.qtum;
                  temp.qtumLongName = cryptoList?.qtumLongName;
                }
                if (cryptoList!.rvnLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.rvn = cryptoList?.rvn;
                  temp.rvnLongName = cryptoList?.rvnLongName;
                }
                if (cryptoList!.xvgLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.xvg = cryptoList?.xvg;
                  temp.xvgLongName = cryptoList?.xvgLongName;
                }
                if (cryptoList!.avaxLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.avax = cryptoList?.avax;
                  temp.avaxLongName = cryptoList?.avaxLongName;
                }
                if (cryptoList!.manaLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.mana = cryptoList?.mana;
                  temp.manaLongName = cryptoList?.manaLongName;
                }
                if (cryptoList!.xlmLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.xlm = cryptoList?.xlm;
                  temp.xlmLongName = cryptoList?.xlmLongName;
                }
                if (cryptoList!.solLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.sol = cryptoList?.sol;
                  temp.solLongName = cryptoList?.solLongName;
                }
                if (cryptoList!.chzLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.chz = cryptoList?.chz;
                  temp.chzLongName = cryptoList?.chzLongName;
                }
                if (cryptoList!.celoLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.celo = cryptoList?.celo;
                  temp.celoLongName = cryptoList?.celoLongName;
                }
                if (cryptoList!.fttLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.ftt = cryptoList?.ftt;
                  temp.fttLongName = cryptoList?.fttLongName;
                }
                if (cryptoList!.hbarLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.hbar = cryptoList?.hbar;
                  temp.hbarLongName = cryptoList?.hbarLongName;
                }
                if (cryptoList!.atomLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.atom = cryptoList?.atom;
                  temp.atomLongName = cryptoList?.atomLongName;
                }
                if (cryptoList!.arkLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.ark = cryptoList?.ark;
                  temp.arkLongName = cryptoList?.arkLongName;
                }
                if (cryptoList!.shibLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.shib = cryptoList?.shib;
                  temp.shibLongName = cryptoList?.shibLongName;
                }
                if (cryptoList!.dogeLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.doge = cryptoList?.doge;
                  temp.dogeLongName = cryptoList?.dogeLongName;
                }
                if (cryptoList!.dentLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.dent = cryptoList?.dent;
                  temp.dentLongName = cryptoList?.dentLongName;
                }
                if (cryptoList!.maticLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.matic = cryptoList?.matic;
                  temp.maticLongName = cryptoList?.maticLongName;
                }
                if (cryptoList!.aaveLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.aave = cryptoList?.aave;
                  temp.aaveLongName = cryptoList?.aaveLongName;
                }
                if (cryptoList!.egldLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.egld = cryptoList?.egld;
                  temp.egldLongName = cryptoList?.egldLongName;
                }
                if (cryptoList!.ontLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.ont = cryptoList?.ont;
                  temp.ontLongName = cryptoList?.ontLongName;
                }
                if (cryptoList!.enjLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.enj = cryptoList?.enj;
                  temp.enjLongName = cryptoList?.enjLongName;
                }
                if (cryptoList!.xecLongName!
                    .toLowerCase()
                    .trim()
                    .contains(val)) {
                  temp.xec = cryptoList?.xec;
                  temp.xecLongName = cryptoList?.xecLongName;
                }

                cryptoList = temp;

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
                labelText: 'Kripto Ara',
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
                            Text("Kripto",
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
                      cryptoList?.usdtLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.usdtLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.usdt?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.usdt?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.usdt?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.usdt!.isFavorite == true
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
                                      bool? temp = cryptoList!.usdt!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "usdt", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.usdt!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.usdt!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.xmrLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.xmrLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xmr?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xmr?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xmr?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.xmr!.isFavorite == true
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
                                      bool? temp = cryptoList!.xmr!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "xmr", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.xmr!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.xmr!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.xrpLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.xrpLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xrp?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xrp?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xrp?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.xrp!.isFavorite == true
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
                                      bool? temp = cryptoList!.xrp!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "xrp", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.xrp!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.xrp!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.ltcLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.ltcLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ltc?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ltc?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ltc?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.ltc!.isFavorite == true
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
                                      bool? temp = cryptoList!.ltc!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "ltc", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.ltc!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.ltc!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.bttLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.bttLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.btt?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.btt?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.btt?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.btt!.isFavorite == true
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
                                      bool? temp = cryptoList!.btt!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "btt", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.btt!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.btt!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.hotLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.hotLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.hot?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.hot?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.hot?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.hot!.isFavorite == true
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
                                      bool? temp = cryptoList!.hot!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "hot", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.hot!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.hot!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.qtumLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.qtumLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.qtum?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.qtum?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.qtum?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.qtum!.isFavorite == true
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
                                      bool? temp = cryptoList!.qtum!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "qtum", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.qtum!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.qtum!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.rvnLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.rvnLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.rvn?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.rvn?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.rvn?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.rvn!.isFavorite == true
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
                                      bool? temp = cryptoList!.rvn!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "rvn", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.rvn!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.rvn!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.xvgLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.xvgLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xvg?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xvg?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xvg?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.xvg!.isFavorite == true
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
                                      bool? temp = cryptoList!.xvg!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "xvg", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.xvg!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.xvg!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.avaxLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.avaxLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.avax?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.avax?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.avax?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.avax!.isFavorite == true
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
                                      bool? temp = cryptoList!.avax!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "avax", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.avax!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.avax!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.manaLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.manaLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.mana?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.mana?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.mana?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.mana!.isFavorite == true
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
                                      bool? temp = cryptoList!.mana!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "mana", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.mana!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.mana!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.xlmLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.xlmLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xlm?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xlm?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xlm?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.xlm!.isFavorite == true
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
                                      bool? temp = cryptoList!.xlm!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "xlm", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.xlm!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.xlm!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.solLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.solLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.sol?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.sol?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.sol?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.sol!.isFavorite == true
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
                                      bool? temp = cryptoList!.sol!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "sol", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.sol!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.sol!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.chzLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.chzLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.chz?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.chz?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.chz?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.chz!.isFavorite == true
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
                                      bool? temp = cryptoList!.chz!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "chz", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.chz!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.chz!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.celoLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.celoLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.celo?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.celo?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.celo?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.celo!.isFavorite == true
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
                                      bool? temp = cryptoList!.celo!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "celo", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.celo!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.celo!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.fttLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.fttLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ftt?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ftt?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ftt?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.ftt!.isFavorite == true
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
                                      bool? temp = cryptoList!.ftt!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "ftt", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.ftt!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.ftt!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.hbarLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.hbarLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.hbar?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.hbar?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.hbar?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.hbar!.isFavorite == true
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
                                      bool? temp = cryptoList!.hbar!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "hbar", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.hbar!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.hbar!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.atomLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.atomLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.atom?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.atom?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.atom?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.atom!.isFavorite == true
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
                                      bool? temp = cryptoList!.atom!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "atom", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.atom!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.atom!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.arkLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.arkLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ark?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ark?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ark?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.ark!.isFavorite == true
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
                                      bool? temp = cryptoList!.ark!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "ark", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.ark!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.ark!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.shibLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.shibLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.shib?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.shib?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.shib?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.shib!.isFavorite == true
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
                                      bool? temp = cryptoList!.shib!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "shib", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.shib!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.shib!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.dogeLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.dogeLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.doge?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.doge?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.doge?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.doge!.isFavorite == true
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
                                      bool? temp = cryptoList!.doge!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "doge", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.doge!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.doge!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.dentLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.dentLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.dent?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.dent?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.dent?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.dent!.isFavorite == true
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
                                      bool? temp = cryptoList!.dent!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "dent", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.dent!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.dent!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.maticLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.maticLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.matic?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.matic?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.matic?.degisim
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.matic!.isFavorite == true
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
                                          cryptoList!.matic!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "matic", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.matic!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.matic!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.aaveLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.aaveLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.aave?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.aave?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.aave?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.aave!.isFavorite == true
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
                                      bool? temp = cryptoList!.aave!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "aave", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.aave!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.aave!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.egldLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.egldLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.egld?.alis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.egld?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.egld?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.egld!.isFavorite == true
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
                                      bool? temp = cryptoList!.egld!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "egld", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.egld!.docId!,
                                            userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.egld!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.ontLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.ontLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ont?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ont?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.ont?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.ont!.isFavorite == true
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
                                      bool? temp = cryptoList!.ont!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "ont", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.ont!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.ont!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.enjLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.enjLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.enj?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.enj?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.enj?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.enj!.isFavorite == true
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
                                      bool? temp = cryptoList!.enj!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "enj", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.enj!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.enj!.isFavorite = !temp!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      cryptoList?.xecLongName != null
                          ? Container(
                              height: 90.0,
                              padding: EdgeInsets.all(5),
                              color: AppColors.brightMainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(cryptoList?.xecLongName ?? "",
                                        style: TextStyle(color: Colors.amber)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xec?.alis?.toString() ?? "",
                                        style: TextStyle(color: Colors.green)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xec?.satis?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  Container(
                                    child: Text(
                                        cryptoList?.xec?.degisim?.toString() ??
                                            "",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  IconButton(
                                    icon: cryptoList!.xec!.isFavorite == true
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
                                      bool? temp = cryptoList!.xec!.isFavorite;
                                      if (temp == false) {
                                        await Database.addCoinFavorite(
                                            "xec", userEmail);
                                        getCryptoList();
                                      } else {
                                        await Database.deleteCoinFavorite(
                                            cryptoList!.xec!.docId!, userEmail);
                                        getCryptoList();
                                      }
                                      setState(() {
                                        cryptoList!.xec!.isFavorite = !temp!;
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


  getCryptoList() async {
    try {
      if (!mounted) return;
      setState(() {
        loading = true;
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      userEmail = preferences.getString("userEmail") as String;
      final res =
          await _dioClient.get("https://api.genelpara.com/embed/kripto.json");
      var json = jsonDecode(res);

      final favoriteGolds = await Database.getCoinFavorite(userEmail);

      setState(() {
        cryptoList = ExchangeCryptoResp.fromJson(json);

        for (var item in favoriteGolds) {
          if (item.type == "usdt") {
            cryptoList!.usdt!.isFavorite = true;
            cryptoList!.usdt!.docId = item.docId;
          }

          if (item.type == "xmr") {
            cryptoList!.xmr!.isFavorite = true;
            cryptoList!.xmr!.docId = item.docId;
          }
          if (item.type == "xrp") {
            cryptoList!.xrp!.isFavorite = true;
            cryptoList!.xrp!.docId = item.docId;
          }
          if (item.type == "ltc") {
            cryptoList!.ltc!.isFavorite = true;
            cryptoList!.ltc!.docId = item.docId;
          }
          if (item.type == "btt") {
            cryptoList!.btt!.isFavorite = true;
            cryptoList!.btt!.docId = item.docId;
          }
          if (item.type == "hot") {
            cryptoList!.hot!.isFavorite = true;
            cryptoList!.hot!.docId = item.docId;
          }

          if (item.type == "qtum") {
            cryptoList!.qtum!.isFavorite = true;
            cryptoList!.qtum!.docId = item.docId;
          }
          if (item.type == "rvn") {
            cryptoList!.rvn!.isFavorite = true;
            cryptoList!.rvn!.docId = item.docId;
          }
          if (item.type == "xvg") {
            cryptoList!.xvg!.isFavorite = true;
            cryptoList!.xvg!.docId = item.docId;
          }
          if (item.type == "avax") {
            cryptoList!.avax!.isFavorite = true;
            cryptoList!.avax!.docId = item.docId;
          }
          if (item.type == "mana") {
            cryptoList!.mana!.isFavorite = true;
            cryptoList!.mana!.docId = item.docId;
          }

          if (item.type == "xlm") {
            cryptoList!.xlm!.isFavorite = true;
            cryptoList!.xlm!.docId = item.docId;
          }
          if (item.type == "sol") {
            cryptoList!.sol!.isFavorite = true;
            cryptoList!.sol!.docId = item.docId;
          }
          if (item.type == "chz") {
            cryptoList!.chz!.isFavorite = true;
            cryptoList!.chz!.docId = item.docId;
          }
          if (item.type == "celo") {
            cryptoList!.celo!.isFavorite = true;
            cryptoList!.celo!.docId = item.docId;
          }
          if (item.type == "ftt") {
            cryptoList!.ftt!.isFavorite = true;
            cryptoList!.ftt!.docId = item.docId;
          }

          if (item.type == "hbar") {
            cryptoList!.hbar!.isFavorite = true;
            cryptoList!.hbar!.docId = item.docId;
          }
          if (item.type == "atom") {
            cryptoList!.atom!.isFavorite = true;
            cryptoList!.atom!.docId = item.docId;
          }
          if (item.type == "ark") {
            cryptoList!.ark!.isFavorite = true;
            cryptoList!.ark!.docId = item.docId;
          }
          if (item.type == "shib") {
            cryptoList!.shib!.isFavorite = true;
            cryptoList!.shib!.docId = item.docId;
          }
          if (item.type == "doge") {
            cryptoList!.doge!.isFavorite = true;
            cryptoList!.doge!.docId = item.docId;
          }

          if (item.type == "dent") {
            cryptoList!.dent!.isFavorite = true;
            cryptoList!.dent!.docId = item.docId;
          }
          if (item.type == "matic") {
            cryptoList!.matic!.isFavorite = true;
            cryptoList!.matic!.docId = item.docId;
          }
          if (item.type == "aave") {
            cryptoList!.aave!.isFavorite = true;
            cryptoList!.aave!.docId = item.docId;
          }
          if (item.type == "egld") {
            cryptoList!.egld!.isFavorite = true;
            cryptoList!.egld!.docId = item.docId;
          }
          if (item.type == "ont") {
            cryptoList!.ont!.isFavorite = true;
            cryptoList!.ont!.docId = item.docId;
          }

          if (item.type == "enj") {
            cryptoList!.enj!.isFavorite = true;
            cryptoList!.enj!.docId = item.docId;
          }
          if (item.type == "xec") {
            cryptoList!.xec!.isFavorite = true;
            cryptoList!.xec!.docId = item.docId;
          }
        }

        tempCryptoList = cryptoList;
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
