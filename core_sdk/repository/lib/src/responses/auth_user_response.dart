import 'package:equatable/equatable.dart';

class AuthUserResponse extends Equatable {
  final String userId;
  final String? userEmail;

  const AuthUserResponse({required this.userId, this.userEmail});

  @override
  List<Object?> get props => [userId, userEmail];
}
