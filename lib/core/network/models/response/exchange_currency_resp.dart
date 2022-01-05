import 'package:equatable/equatable.dart';
import 'package:finansfer/core/network/models/response/exchange_currency_data.dart';

class ExchangeCurrencyResp extends Equatable {
  ExchangeCurrencyData? uah;
  String? uahLongName;
  ExchangeCurrencyData? eur;
  String? eurLongName;
  ExchangeCurrencyData? gbp;
  String? gbpLongName;
  ExchangeCurrencyData? chf;
  String? chfLongName;
  ExchangeCurrencyData? cad;
  String? cadLongName;
  ExchangeCurrencyData? rub;
  String? rubLongName;
  ExchangeCurrencyData? aud;
  String? audLongName;
  ExchangeCurrencyData? php;
  String? phpLongName;
  ExchangeCurrencyData? jpy;
  String? jpyLongName;
  ExchangeCurrencyData? azn;
  String? aznLongName;
  ExchangeCurrencyData? cop;
  String? copLongName;
  ExchangeCurrencyData? kwd;
  String? kwdLongName;

  ExchangeCurrencyResp({
    this.uah,
    this.uahLongName,
    this.eur,
    this.eurLongName,
    this.gbp,
    this.gbpLongName,
    this.chf,
    this.chfLongName,
    this.cad,
    this.cadLongName,
    this.rub,
    this.rubLongName,
    this.aud,
    this.audLongName,
    this.php,
    this.phpLongName,
    this.jpy,
    this.jpyLongName,
    this.azn,
    this.aznLongName,
    this.cop,
    this.copLongName,
    this.kwd,
    this.kwdLongName,
  });

  factory ExchangeCurrencyResp.fromJson(Map<String, dynamic> json) {
    return ExchangeCurrencyResp(
      uah: json['UAH'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['UAH'] as Map<String, dynamic>),
      uahLongName: json['UAH'] == null ? null : "Grivna",
      eur: json['EUR'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['EUR'] as Map<String, dynamic>),
      eurLongName: json['EUR'] == null ? null : "Euro",
      gbp: json['GBP'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['GBP'] as Map<String, dynamic>),
      gbpLongName: json['GBP'] == null ? null : "İngiliz Sterlini",
      chf: json['CHF'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['CHF'] as Map<String, dynamic>),
      chfLongName: json['CHF'] == null ? null : "İsviçre Frangı",
      cad: json['CAD'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['CAD'] as Map<String, dynamic>),
      cadLongName: json['CAD'] == null ? null : "Kanada Doları",
      rub: json['RUB'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['RUB'] as Map<String, dynamic>),
      rubLongName: json['RUB'] == null ? null : "Rus Rublesi",
      aud: json['AUD'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['AUD'] as Map<String, dynamic>),
      audLongName: json['AUD'] == null ? null : "Avustralya Doları",
      php: json['PHP'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['PHP'] as Map<String, dynamic>),
      phpLongName: json['PHP'] == null ? null : "Filipin Pesosu",
      jpy: json['JPY'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['JPY'] as Map<String, dynamic>),
      jpyLongName: json['JPY'] == null ? null : "Japon Yeni",
      azn: json['AZN'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['AZN'] as Map<String, dynamic>),
      aznLongName: json['AZN'] == null ? null : "Azerbaycan Manatı",
      cop: json['COP'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['COP'] as Map<String, dynamic>),
      copLongName: json['COP'] == null ? null : "Kolombiya Pesosu",
      kwd: json['KWD'] == null
          ? null
          : ExchangeCurrencyData.fromJson(json['KWD'] as Map<String, dynamic>),
      kwdLongName: json['KWD'] == null ? null : "Kuveyt Dinarı",
    );
  }

  Map<String, dynamic> toJson() => {
        'uah': uah,
        'uahLongName': uahLongName,
        'eur': eur,
        'eurLongName': eurLongName,
        'gbp': gbp,
        'gbpLongName': gbpLongName,
        'chf': chf,
        'chfLongName': chfLongName,
        'cad': cad,
        'cadLongName': cadLongName,
        'rub': rub,
        'rubLongName': rubLongName,
        'aud': aud,
        'audLongName': audLongName,
        'php': php,
        'phpLongName': phpLongName,
        'jpy': jpy,
        'jpyLongName': jpyLongName,
        'azn': azn,
        'aznLongName': aznLongName,
        'cop': cop,
        'copLongName': copLongName,
        'kwd': kwd,
        'kwdLongName': kwdLongName,
      };

  @override
  List<Object?> get props => [
        uah,
        uahLongName,
        eur,
        eurLongName,
        gbp,
        gbpLongName,
        chf,
        chfLongName,
        cad,
        cadLongName,
        rub,
        rubLongName,
        aud,
        audLongName,
        php,
        phpLongName,
        jpy,
        jpyLongName,
        azn,
        aznLongName,
        cop,
        copLongName,
        kwd,
        kwdLongName,
      ];
}
