import 'package:equatable/equatable.dart';

class PaymentPlanner extends Equatable {
  final String? title;
  final String? desc;
   final String? plan;
  final String? remindPeriod;
  String? docId;

  PaymentPlanner(
      {this.title,
      this.desc,
      this.plan,
      this.remindPeriod,
      this.docId});

  factory PaymentPlanner.fromJson(Map<String, dynamic> json) => PaymentPlanner(
        title: json['title'] as String?,
        desc: json['desc'] as String?,
        plan: json['plan'] as String?,
        remindPeriod: json['remindPeriod'] as String?,
        docId: json['docId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
        'plan': plan,
        'remindPeriod': remindPeriod,
        'docId': docId,
      };

  @override
  List<Object?> get props =>
      [title, desc, plan, remindPeriod, docId];
}
