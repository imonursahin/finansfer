import 'package:equatable/equatable.dart';

class Suppliper extends Equatable {
  final String? supName;
  final String? supContact;
  final String? SupProduct;

  String? docId;
  final bool? isSuppliper;

  Suppliper(
      {this.supName,
      this.supContact,
      this.SupProduct,
      this.docId,
      this.isSuppliper});

  factory Suppliper.fromJson(Map<String, dynamic> json) => Suppliper(
        supName: json['supName'] as String?,
        supContact: json['supContact'] as String?,
        SupProduct: json['SupProduct'] as String?,
        docId: json['docId'] as String?,
        isSuppliper: json['isSuppliper'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'supName': supName,
        'supContact': supContact,
        'SupProduct': SupProduct,
        'docId': docId,
        'isSuppliper': isSuppliper,
      };

  @override
  List<Object?> get props =>
      [supName, supContact, SupProduct, docId, isSuppliper];
}
