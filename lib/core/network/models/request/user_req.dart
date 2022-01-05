import 'package:equatable/equatable.dart';

class UserReq extends Equatable {
  final String? email;


  const UserReq({
    this.email,
  });

  factory UserReq.fromJson(Map<String, dynamic> json) =>
      UserReq(
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
      };

        @override
  List<Object?> get props => [email];
}
