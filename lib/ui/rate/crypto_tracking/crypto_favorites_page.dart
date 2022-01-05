import 'dart:convert';

import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/di/dio_client.dart';
import 'package:finansfer/core/network/models/response/exchange_crypto_resp.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CryptoFavoritesPage extends StatefulWidget {
  @override
  State<CryptoFavoritesPage> createState() => _CryptoFavoritesPageState();
}

class _CryptoFavoritesPageState extends State<CryptoFavoritesPage> {
  DioClient _dioClient = DioClient();
  ExchangeCryptoResp? cryptoList;
  String userEmail = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getcryptoList();
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
                        Text("Kripto", style: TextStyle(color: Colors.white)),
                        Text("Alış", style: TextStyle(color: Colors.white)),
                        Text("Satış", style: TextStyle(color: Colors.white)),
                        Text("Değişim", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  cryptoList?.usdtLongName != null &&
                          cryptoList!.usdt!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.usdtLongName ?? "",
                                    style: TextStyle(color: Colors.amber)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.usdt?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.usdt?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.usdt?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.xmrLongName != null &&
                          cryptoList!.xmr!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.xmrLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xmr?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xmr?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xmr?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.xrpLongName != null &&
                          cryptoList!.xrp!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.xrpLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xrp?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xrp?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xrp?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.ltcLongName != null &&
                          cryptoList!.ltc!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.ltcLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ltc?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ltc?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ltc?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.bttLongName != null &&
                          cryptoList!.btt!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.bttLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.btt?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.btt?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.btt?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.hotLongName != null &&
                          cryptoList!.hot!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.hotLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.hot?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.hot?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.hot?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.qtumLongName != null &&
                          cryptoList!.qtum!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.qtumLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.qtum?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.qtum?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.qtum?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.rvnLongName != null &&
                          cryptoList!.rvn!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.rvnLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.rvn?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.rvn?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.rvn?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.xvgLongName != null &&
                          cryptoList!.xvg!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.xvgLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xvg?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xvg?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xvg?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.avaxLongName != null &&
                          cryptoList!.avax!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.avaxLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.avax?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.avax?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.avax?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.manaLongName != null &&
                          cryptoList!.mana!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.manaLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.mana?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.mana?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.mana?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.xlmLongName != null &&
                          cryptoList!.xlm!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.xlmLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xlm?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xlm?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xlm?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.solLongName != null &&
                          cryptoList!.sol!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.solLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.sol?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.sol?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.sol?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.chzLongName != null &&
                          cryptoList!.chz!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.chzLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.chz?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.chz?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.chz?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.celoLongName != null &&
                          cryptoList!.celo!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.celoLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.celo?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.celo?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.celo?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.fttLongName != null &&
                          cryptoList!.ftt!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.fttLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ftt?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ftt?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ftt?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.hbarLongName != null &&
                          cryptoList!.hbar!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.hbarLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.hbar?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.hbar?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.hbar?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.atomLongName != null &&
                          cryptoList!.atom!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.atomLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.atom?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.atom?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.atom?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.arkLongName != null &&
                          cryptoList!.ark!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.arkLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ark?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ark?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ark?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.shibLongName != null &&
                          cryptoList!.shib!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.shibLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.shib?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.shib?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.shib?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.dogeLongName != null &&
                          cryptoList!.doge!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.dogeLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.doge?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.doge?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.doge?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.xrpLongName != null &&
                          cryptoList!.dent!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.dentLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.dent?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.dent?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.dent?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.xrpLongName != null &&
                          cryptoList!.matic!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.maticLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.matic?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.matic?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.matic?.degisim?.toString() ??
                                        "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.xrpLongName != null &&
                          cryptoList!.aave!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.aaveLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.aave?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.aave?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.aave?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.egldLongName != null &&
                          cryptoList!.egld!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.egldLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.egld?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.egld?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.egld?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.ontLongName != null &&
                          cryptoList!.ont!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.ontLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ont?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ont?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.ont?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.enjLongName != null &&
                          cryptoList!.enj!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.enjLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.enj?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.enj?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.enj?.degisim?.toString() ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  cryptoList?.xecLongName != null &&
                          cryptoList!.xec!.isFavorite!
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 90.0,
                          padding: EdgeInsets.all(5),
                          color: AppColors.brightMainColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(cryptoList?.xecLongName ?? "",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xec?.alis?.toString() ?? "",
                                    style: TextStyle(color: Colors.green)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xec?.satis?.toString() ?? "",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              Container(
                                child: Text(
                                    cryptoList?.xec?.degisim?.toString() ?? "",
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

  getcryptoList() async {
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

      final favoriteCryptos = await Database.getCoinFavorite(userEmail);

      setState(() {
        cryptoList = ExchangeCryptoResp.fromJson(json);

        for (var item in favoriteCryptos) {
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
