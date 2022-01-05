import 'package:equatable/equatable.dart';

class NewsResult extends Equatable {
  String? key;
  String? url;
  String? description;
  String? image;
  String? name;
  String? source;

  NewsResult(
      {this.key,
      this.url,
      this.description,
      this.image,
      this.name,
      this.source});

  factory NewsResult.fromJson(Map<String, dynamic> json) => NewsResult(
        key: json['key'] as String?,
        url: json['url'] as String?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        name: json['name'] as String?,
        source: json['source'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'url': url,
        'description': description,
        'image': image,
        'name': name,
        'source': source,
      };

  @override
  List<Object?> get props => [key, url, description, image, name, source];
}
