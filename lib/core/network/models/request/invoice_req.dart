import 'package:equatable/equatable.dart';

class InvoiceReq extends Equatable {
  final String? productTitle;
  final String? productAmount;
  final String? productPrice;

  const InvoiceReq({
    this.productTitle,
    this.productAmount,
    this.productPrice,
  });

  factory InvoiceReq.fromJson(Map<String, dynamic> json) => InvoiceReq(
        productTitle: json['productTitle'] as String?,
        productAmount: json['productAmount'] as String?,
        productPrice: json['productPrice'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'productTitle': productTitle,
        'productAmount': productAmount,
        'productPrice': productPrice,
      };

  @override
  List<Object?> get props => [productTitle, productAmount, productPrice];
}
