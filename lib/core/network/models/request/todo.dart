import 'package:equatable/equatable.dart';

class ToDo extends Equatable {
  final String? title;
  final String? desc;
  String? docId;

  ToDo({this.title, this.desc, this.docId});

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
        title: json['title'] as String?,
        desc: json['desc'] as String?,
        docId: json['docId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
        'docId': docId,
      };

  @override
  List<Object?> get props => [title, desc, docId];
}
