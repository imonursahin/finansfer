import 'package:equatable/equatable.dart';
import 'package:finansfer/core/network/models/response/exchange_gold_data.dart';

class ExchangeGoldResp extends Equatable {
  ExchangeGoldData? ata;
  String? ataLongName;
  ExchangeGoldData? bsl;
  String? bslLongName;
  ExchangeGoldData? yarim;
  String? yarimLongName;
  ExchangeGoldData? tam;
  String? tamLongName;
  ExchangeGoldData? cmr;
  String? cmrLongName;
  ExchangeGoldData? gag;
  String? gagLongName;
  ExchangeGoldData? ha;
  String? haLongName;

  ExchangeGoldResp({
    this.ata,
    this.ataLongName,
    this.bsl,
    this.bslLongName,
    this.yarim,
    this.yarimLongName,
    this.tam,
    this.tamLongName,
    this.cmr,
    this.cmrLongName,
    this.gag,
    this.gagLongName,
    this.ha,
    this.haLongName,
  });

  factory ExchangeGoldResp.fromJson(Map<String, dynamic> json) =>
      ExchangeGoldResp(
        ata: json['ATA'] == null
            ? null
            : ExchangeGoldData.fromJson(json['ATA'] as Map<String, dynamic>),
        ataLongName: json['ATA'] == null ? null : "Ata Altın",
        bsl: json['BSL'] == null
            ? null
            : ExchangeGoldData.fromJson(json['BSL'] as Map<String, dynamic>),
        bslLongName: json['BSL'] == null ? null : "Beşli Altın",
        yarim: json['Y'] == null
            ? null
            : ExchangeGoldData.fromJson(json['Y'] as Map<String, dynamic>),
        yarimLongName: json['Y'] == null ? null : "Yarım Altın",
        tam: json['T'] == null
            ? null
            : ExchangeGoldData.fromJson(json['T'] as Map<String, dynamic>),
        tamLongName: json['T'] == null ? null : "Tam Altın",
        cmr: json['CMR'] == null
            ? null
            : ExchangeGoldData.fromJson(json['CMR'] as Map<String, dynamic>),
        cmrLongName: json['CMR'] == null ? null : "Cumhuriyet Altın",
        gag: json['GAG'] == null
            ? null
            : ExchangeGoldData.fromJson(json['GAG'] as Map<String, dynamic>),
        gagLongName: json['GAG'] == null ? null : "Gümüş",
        ha: json['HA'] == null
            ? null
            : ExchangeGoldData.fromJson(json['HA'] as Map<String, dynamic>),
        haLongName: json['HA'] == null ? null : "Hamit Altın",
      );

  Map<String, dynamic> toJson() => {
        'ata': ata,
        'ataLongName': ataLongName,
        'bsl': bsl,
        'bslLongName': bslLongName,
        'yarim': yarim,
        'yarimLongName': yarimLongName,
        'tam': tam,
        'tamLongName': tamLongName,
        'cmr': cmr,
        'cmrLongName': cmrLongName,
        'gag': gag,
        'gagLongName': gagLongName,
        'ha': ha,
        'haLongName': haLongName,
      };

  @override
  List<Object?> get props => [
        ata,
        ataLongName,
        bsl,
        bslLongName,
        yarim,
        yarimLongName,
        tam,
        tamLongName,
        cmr,
        cmrLongName,
        gag,
        gagLongName,
        ha,
        haLongName,
      ];
}
