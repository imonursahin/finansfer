import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String? productTitle;
  final int? productAmount;
  final String? productAmountTit;

  final bool? isStock;

  String? docId;

  Stock(
      {this.productTitle,
      this.productAmount,
      this.productAmountTit,
      this.isStock,
      this.docId});

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        productTitle: json['productTitle'] as String?,
        productAmount: json['productAmount'] as int?,
        productAmountTit: json['productAmountTit'] as String?,
        isStock: json['isStock'] as bool?,
        docId: json['docId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'productTitle': productTitle,
        'productAmount': productAmount,
        'productAmountTit': productAmountTit,
        'isStock': isStock,
        'docId': docId,
      };

  @override
  List<Object?> get props =>
      [productTitle, productAmount, productAmountTit, isStock, docId];
}
