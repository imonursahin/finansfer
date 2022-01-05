import 'package:equatable/equatable.dart';

class DebitRecord extends Equatable {
  final String? title;
  final int? amount;
  String? date;
  String? docId;

  DebitRecord({this.title, this.amount, this.docId, this.date});

  factory DebitRecord.fromJson(Map<String, dynamic> json) => DebitRecord(
        title: json['title'] as String?,
        amount: json['amount'] as int?,
        docId: json['docId'] as String?,
        date: json['date'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'amount': amount,
        'docId': docId,
        'date': date,
      };

  @override
  List<Object?> get props => [title, amount, docId, date];
}
