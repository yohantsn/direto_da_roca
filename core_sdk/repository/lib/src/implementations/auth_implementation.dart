import 'package:repository/src/contracts/auth_contract.dart';
import 'package:repository/src/parameters/auth_parameters.dart';
import 'package:repository/src/responses/auth_exceptions.dart';
import 'package:repository/src/responses/auth_user_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthImplementation implements AuthContract {
  final GoTrueClient _authClient;
  AuthImplementation(Supabase supabase) : _authClient = supabase.client.auth;

  @override
  bool get isLogged => _authClient.currentUser != null;

  @override
  Future<AuthUserResponse> signIn(AuthParameters params) async {
    try {
      final response = await _authClient.signInWithPassword(
        email: params.email,
        password: params.password,
      );

      final user = response.user;
      if (user == null) {
        throw OtherException('unexpected_error');
      }
      return AuthUserResponse(userId: user.id, userEmail: user.email);
    } on AuthApiException catch (e) {
      if (e.statusCode == 'user_not_found') {
        throw UserNotFoundException();
      }
      throw OtherException(e.statusCode ?? 'unexpected_error');
    } catch (_) {
      throw OtherException('unexpected_error');
    }
  }

  @override
  Future<AuthUserResponse> signUp(AuthParameters params) async {
    try {
      final response = await _authClient.signUp(
        email: params.email,
        password: params.password,
      );

      final user = response.user;
      if (user == null) {
        throw OtherException('unexpected_error');
      }
      return AuthUserResponse(userId: user.id, userEmail: user.email);
    } on AuthApiException catch (e) {
      if (e.statusCode == 'email_address_invalid') {
        throw EmailInvalidException();
      }
      if (e.statusCode == 'email_exists') {
        throw UserAlreadyExistsException();
      }
      if (e.statusCode == 'weak_password') {
        throw PasswordWeakException();
      }
      throw OtherException(e.statusCode ?? 'unexpected_error');
    } catch (_) {
      throw OtherException('unexpected_error');
    }
  }

  @override
  Future<void> signOut() {
    return _authClient.signOut();
  }

  @override
  Future<void> changePassword(String password) {
    try {
      return _authClient.updateUser(UserAttributes(password: password));
    } on AuthApiException catch (e) {
      if (e.statusCode == 'weak_password') {
        throw PasswordWeakException();
      }
      throw OtherException(e.statusCode ?? 'unexpected_error');
    } catch (_) {
      throw OtherException('unexpected_error');
    }
  }

  @override
  AuthUserResponse? get user {
    final user = _authClient.currentUser;
    if (user == null) {
      return null;
    }

    return AuthUserResponse(userId: user.id, userEmail: user.email);
  }
}
