import 'package:repository/src/parameters/auth_parameters.dart';
import 'package:repository/src/responses/auth_user_response.dart';

abstract interface class AuthContract {
  Future<AuthUserResponse> signUp(AuthParameters params);
  Future<AuthUserResponse> signIn(AuthParameters params);
  Future<void> signOut();
  Future<void> changePassword(String password);
  bool get isLogged;
}
