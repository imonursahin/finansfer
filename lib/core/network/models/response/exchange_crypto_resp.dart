import 'package:equatable/equatable.dart';
import 'package:finansfer/core/network/models/response/exchange_crypto_data.dart';

class ExchangeCryptoResp extends Equatable {
  ExchangeCryptoData? usdt;
  String? usdtLongName;
  ExchangeCryptoData? xmr;
  String? xmrLongName;
  ExchangeCryptoData? xrp;
  String? xrpLongName;
  ExchangeCryptoData? ltc;
  String? ltcLongName;
  ExchangeCryptoData? btt;
  String? bttLongName;
  ExchangeCryptoData? hot;
  String? hotLongName;
  ExchangeCryptoData? qtum;
  String? qtumLongName;
  ExchangeCryptoData? rvn;
  String? rvnLongName;
  ExchangeCryptoData? xvg;
  String? xvgLongName;
  ExchangeCryptoData? avax;
  String? avaxLongName;
  ExchangeCryptoData? mana;
  String? manaLongName;
  ExchangeCryptoData? xlm;
  String? xlmLongName;
  ExchangeCryptoData? sol;
  String? solLongName;
  ExchangeCryptoData? chz;
  String? chzLongName;
  ExchangeCryptoData? celo;
  String? celoLongName;
  ExchangeCryptoData? ftt;
  String? fttLongName;
  ExchangeCryptoData? hbar;
  String? hbarLongName;
  ExchangeCryptoData? atom;
  String? atomLongName;
  ExchangeCryptoData? ark;
  String? arkLongName;
  ExchangeCryptoData? shib;
  String? shibLongName;
  ExchangeCryptoData? doge;
  String? dogeLongName;
  ExchangeCryptoData? dent;
  String? dentLongName;
  ExchangeCryptoData? matic;
  String? maticLongName;
  ExchangeCryptoData? aave;
  String? aaveLongName;
  ExchangeCryptoData? egld;
  String? egldLongName;
  ExchangeCryptoData? ont;
  String? ontLongName;
  ExchangeCryptoData? enj;
  String? enjLongName;
  ExchangeCryptoData? xec;
  String? xecLongName;

  ExchangeCryptoResp({
    this.usdt,
    this.usdtLongName,
    this.xmr,
    this.xmrLongName,
    this.xrp,
    this.xrpLongName,
    this.ltc,
    this.ltcLongName,
    this.btt,
    this.bttLongName,
    this.hot,
    this.hotLongName,
    this.qtum,
    this.qtumLongName,
    this.rvn,
    this.rvnLongName,
    this.xvg,
    this.xvgLongName,
    this.avax,
    this.avaxLongName,
    this.mana,
    this.manaLongName,
    this.xlm,
    this.xlmLongName,
    this.sol,
    this.solLongName,
    this.chz,
    this.chzLongName,
    this.celo,
    this.celoLongName,
    this.ftt,
    this.fttLongName,
    this.hbar,
    this.hbarLongName,
    this.atom,
    this.atomLongName,
    this.ark,
    this.arkLongName,
    this.shib,
    this.shibLongName,
    this.doge,
    this.dogeLongName,
    this.dent,
    this.dentLongName,
    this.matic,
    this.maticLongName,
    this.aave,
    this.aaveLongName,
    this.egld,
    this.egldLongName,
    this.ont,
    this.ontLongName,
    this.enj,
    this.enjLongName,
    this.xec,
    this.xecLongName,
  });

  factory ExchangeCryptoResp.fromJson(Map<String, dynamic> json) {
    return ExchangeCryptoResp(
      usdt: json['USDT'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['USDT'] as Map<String, dynamic>),
      usdtLongName: json['USDT'] == null ? null : "Tether",
      xmr: json['XMR'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['XMR'] as Map<String, dynamic>),
      xmrLongName: json['XMR'] == null ? null : "Monero",
      xrp: json['XRP'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['XRP'] as Map<String, dynamic>),
      xrpLongName: json['XRP'] == null ? null : "Ripple",
      ltc: json['LTC'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['LTC'] as Map<String, dynamic>),
      ltcLongName: json['LTC'] == null ? null : "Litecoin",
      btt: json['BTT'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['BTT'] as Map<String, dynamic>),
      bttLongName: json['BTT'] == null ? null : "Bittorrent",
      hot: json['HOT'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['HOT'] as Map<String, dynamic>),
      hotLongName: json['HOT'] == null ? null : "Holochain",
      qtum: json['QTUM'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['QTUM'] as Map<String, dynamic>),
      qtumLongName: json['QTUM'] == null ? null : "QTUM",
      rvn: json['RVN'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['RVN'] as Map<String, dynamic>),
      rvnLongName: json['RVN'] == null ? null : "Ravencoin",
      xvg: json['XVG'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['XVG'] as Map<String, dynamic>),
      xvgLongName: json['XVG'] == null ? null : "Verge",
      avax: json['AVAX'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['AVAX'] as Map<String, dynamic>),
      avaxLongName: json['AVAX'] == null ? null : "AVAX",
      mana: json['MANA'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['MANA'] as Map<String, dynamic>),
      manaLongName: json['MANA'] == null ? null : "Decentraland",
      xlm: json['XLM'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['XLM'] as Map<String, dynamic>),
      xlmLongName: json['XLM'] == null ? null : "Stellar",
      sol: json['SOL'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['SOL'] as Map<String, dynamic>),
      solLongName: json['SOL'] == null ? null : "Solana",
      chz: json['CHZ'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['CHZ'] as Map<String, dynamic>),
      chzLongName: json['CHZ'] == null ? null : "Chiliz",
      celo: json['CELO'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['CELO'] as Map<String, dynamic>),
      celoLongName: json['CELO'] == null ? null : "Celo",
      ftt: json['FTT'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['FTT'] as Map<String, dynamic>),
      fttLongName: json['FTT'] == null ? null : "FTX Token",
      hbar: json['HBAR'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['HBAR'] as Map<String, dynamic>),
      hbarLongName: json['HBAR'] == null ? null : "Hedera",
      atom: json['ATOM'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['ATOM'] as Map<String, dynamic>),
      atomLongName: json['ATOM'] == null ? null : "Cosmos",
      ark: json['ARK'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['ARK'] as Map<String, dynamic>),
      arkLongName: json['ARK'] == null ? null : "Ark",
      shib: json['SHIB'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['SHIB'] as Map<String, dynamic>),
      shibLongName: json['SHIB'] == null ? null : "Shiba",
      doge: json['DOGE'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['DOGE'] as Map<String, dynamic>),
      dogeLongName: json['DOGE'] == null ? null : "Doge",
      dent: json['DENT'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['DENT'] as Map<String, dynamic>),
      dentLongName: json['DENT'] == null ? null : "Dent",
      matic: json['MATIC'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['MATIC'] as Map<String, dynamic>),
      maticLongName: json['MATIC'] == null ? null : "Polygon",
      aave: json['AAVE'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['AAVE'] as Map<String, dynamic>),
      aaveLongName: json['AAVE'] == null ? null : "Aave",
      egld: json['EGLD'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['EGLD'] as Map<String, dynamic>),
      egldLongName: json['EGLD'] == null ? null : "Elrond",
      ont: json['ONT'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['ONT'] as Map<String, dynamic>),
      ontLongName: json['ONT'] == null ? null : "Ontology",
      enj: json['ENJ'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['ENJ'] as Map<String, dynamic>),
      enjLongName: json['ENJ'] == null ? null : "Enjin Coin",
      xec: json['XEC'] == null
          ? null
          : ExchangeCryptoData.fromJson(json['XEC'] as Map<String, dynamic>),
      xecLongName: json['XEC'] == null ? null : "eCash",
    );
  }

  Map<String, dynamic> toJson() => {
        'usdt': usdt,
        'usdtLongName': usdtLongName,
        'xmr': xmr,
        'xmrLongName': xmrLongName,
        'xrp': xrp,
        'xrpLongName': xrpLongName,
        'ltc': ltc,
        'ltcLongName': ltcLongName,
        'btt': btt,
        'bttLongName': bttLongName,
        'hot': hot,
        'hotLongName': hotLongName,
        'qtum': qtum,
        'qtumLongName': qtumLongName,
        'rvn': rvn,
        'rvnLongName': rvnLongName,
        'xvg': xvg,
        'xvgLongName': xvgLongName,
        'avax': avax,
        'avaxLongName': avaxLongName,
        'mana': mana,
        'manaLongName': manaLongName,
        'xlm': xlm,
        'xlmLongName': xlmLongName,
        'sol': sol,
        'solLongName': solLongName,
        'chz': chz,
        'chzLongName': chzLongName,
        'celo': celo,
        'celoLongName': celoLongName,
        'ftt': ftt,
        'fttLongName': fttLongName,
        'hbar': hbar,
        'hbarLongName': hbarLongName,
        'atom': atom,
        'atomLongName': atomLongName,
        'ark': ark,
        'arkLongName': arkLongName,
        'shib': shib,
        'shibLongName': shibLongName,
        'doge': doge,
        'dogeLongName': dogeLongName,
        'dent': dent,
        'dentLongName': dentLongName,
        'matic': matic,
        'maticLongName': maticLongName,
        'aave': aave,
        'aaveLongName': aaveLongName,
        'egld': egld,
        'egldLongName': egldLongName,
        'ont': ont,
        'ontLongName': ontLongName,
        'enj': enj,
        'enjLongName': enjLongName,
        'xec': xec,
        'xecLongName': xecLongName,
      };

  @override
  List<Object?> get props => [
        usdt,
        usdtLongName,
        xmr,
        xmrLongName,
        xrp,
        xrpLongName,
        ltc,
        ltcLongName,
        btt,
        bttLongName,
        hot,
        hotLongName,
        qtum,
        qtumLongName,
        rvn,
        rvnLongName,
        xvg,
        xvgLongName,
        avax,
        avaxLongName,
        mana,
        manaLongName,
        xlm,
        xlmLongName,
        sol,
        solLongName,
        chz,
        chzLongName,
        celo,
        celoLongName,
        ftt,
        fttLongName,
        hbar,
        hbarLongName,
        atom,
        atomLongName,
        ark,
        arkLongName,
        shib,
        shibLongName,
        doge,
        dogeLongName,
        dent,
        dentLongName,
        matic,
        maticLongName,
        aave,
        aaveLongName,
        egld,
        egldLongName,
        ont,
        ontLongName,
        enj,
        enjLongName,
        xec,
        xecLongName,
      ];
}
