import 'package:equatable/equatable.dart';
import 'package:finansfer/core/network/models/response/news_result.dart';

class NewsResp extends Equatable {
  bool? success;
  List<NewsResult>? result;

  NewsResp(
      {this.success,
      this.result,});

  factory NewsResp.fromJson(Map<String, dynamic> json) => NewsResp(
        success: json['success'] as bool?,
        result: (json['result'] as List<dynamic>?)
            ?.map((e) => NewsResult.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'result': result,
      };

  @override
  List<Object?> get props => [success, result];
}
