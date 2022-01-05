import 'package:equatable/equatable.dart';

class ExchangeGoldData extends Equatable {
   String? satis;
   String? alis;
   String? degisim;
   bool? isFavorite = false;
   String? docId;
   String? type;


   ExchangeGoldData({
    this.satis,
    this.alis,
    this.degisim,
    this.isFavorite = false,
    this.docId,
    this.type
  });

  factory ExchangeGoldData.fromJson(Map<String, dynamic> json) =>
      ExchangeGoldData(
        satis: json['satis'] as String?,
        alis: json['alis'] as String?,
        degisim: json['degisim'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'satis': satis,
        'alis': alis,
        'degisim': degisim,
      };

        @override
  List<Object?> get props => [satis, alis, degisim, isFavorite];
}
