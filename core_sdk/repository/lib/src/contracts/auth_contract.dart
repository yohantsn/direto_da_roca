import 'package:repository/src/parameters/auth_parameters.dart';
import 'package:repository/src/responses/auth_user_response.dart';

abstract interface class AuthContract {
  /// SignUp function must receive the email and password.
  /// in Success case will be returned the [AuthUserResponse] that contains unique user ID and the user email.
  /// in Failure case the function can return [EmailInvalidException] in case of an email invalid,
  /// [UserAlreadyExistsException] in case of the account is already existent, [PasswordWeakException] in case of a weak pasword be used and in the other cases
  /// the [OtherException] will be emitted, check the statusCode for more information.
  Future<AuthUserResponse> signUp(AuthParameters params);

  /// signIn function must receive the email and password.
  /// in Success case will be returned the [AuthUserResponse] that contains unique user ID and the user email.
  /// in Failure case the function can return [UserNotFoundException] in case of an email or password invalid,
  ///  in the other cases the [OtherException] will be emitted, check the statusCode for more information.
  Future<AuthUserResponse> signIn(AuthParameters params);

  Future<void> signOut();

  /// changePassword function must receive a password.
  /// [PasswordWeakException] in case of a weak pasword be used
  /// and in the other cases the [OtherException] will be emitted, check the statusCode for more information.
  Future<void> changePassword(String password);

  /// If the user is already logged will be returned true.
  bool get isLogged;

  /// If the user is logged will be returned the [AuthUserResponse] that contains unique user ID and the user email.
  AuthUserResponse? get user;
}
