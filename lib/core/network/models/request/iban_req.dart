import 'package:equatable/equatable.dart';

class IbanReq extends Equatable {
  final String? bankName;
  final String? ibanNumber;
  final String? ibanOwner;
  String? docId;

  IbanReq({
    this.bankName,
    this.ibanNumber,
    this.ibanOwner,
    this.docId,
  });

  factory IbanReq.fromJson(Map<String, dynamic> json) => IbanReq(
        bankName: json['bankName'] as String?,
        ibanNumber: json['ibanNumber'] as String?,
        ibanOwner: json['ibanOwner'] as String?,
        docId: json['docId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'bankName': bankName,
        'ibanNumber': ibanNumber,
        'ibanOwner': ibanOwner,
        'docId': docId,
      };

  @override
  List<Object?> get props => [bankName, ibanNumber, ibanOwner, docId];
}
