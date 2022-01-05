import 'package:equatable/equatable.dart';

class IncomeExpense extends Equatable {
  final String? title;
  final int? amount;
  final bool? isIncome;
  String? date;
  String? docId;

  IncomeExpense({this.title, this.amount, this.isIncome, this.docId, this.date});

  factory IncomeExpense.fromJson(Map<String, dynamic> json) => IncomeExpense(
        title: json['title'] as String?,
        amount: json['amount'] as int?,
        isIncome: json['isIncome'] as bool?,
        docId: json['docId'] as String?,
        date: json['date'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'amount': amount,
        'isIncome': isIncome,
        'date': date,
        'docId': docId,
      };

  @override
  List<Object?> get props => [title, amount, isIncome, docId, date];
}
