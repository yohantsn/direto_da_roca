import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/src/implementations/auth_implementation.dart';
import 'package:repository/src/parameters/auth_parameters.dart';
import 'package:repository/src/responses/auth_exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../mocks/supabase_client_mock.dart';

import 'auth_implementation_test.mocks.dart';

@GenerateMocks([Supabase, GoTrueClient, User, UserResponse])
void main() {
  late MockSupabase mockSupabase;
  late MockGoTrueClient mockAuthClient;
  late MockUser mockUser;
  late MockUserResponse mockUserResponse;
  late AuthImplementation authImpl;

  setUp(() {
    mockSupabase = MockSupabase();
    mockAuthClient = MockGoTrueClient();
    mockUser = MockUser();
    mockUserResponse = MockUserResponse();

    when(mockSupabase.client).thenReturn(MockSupabaseClient(mockAuthClient));

    authImpl = AuthImplementation(mockSupabase);
  });

  group('isLogged', () {
    test('returns true when user is logged in', () {
      when(mockAuthClient.currentUser).thenReturn(mockUser);
      expect(authImpl.isLogged, true);
    });

    test('returns false when user is not logged in', () {
      when(mockAuthClient.currentUser).thenReturn(null);
      expect(authImpl.isLogged, false);
    });
  });

  group('signIn', () {
    const email = 'test@example.com';
    const password = 'password123';
    const userId = 'user-id-123';

    test('signIn success', () async {
      when(mockUser.id).thenReturn(userId);
      when(mockUser.email).thenReturn(email);
      when(
        mockAuthClient.signInWithPassword(email: email, password: password),
      ).thenAnswer((_) async => AuthResponse(user: mockUser, session: null));

      final params = AuthParameters(email, password);
      final result = await authImpl.signIn(params);

      expect(result.userId, userId);
      expect(result.userEmail, email);
      verify(
        mockAuthClient.signInWithPassword(email: email, password: password),
      ).called(1);
    });

    test('signIn throws UserNotFoundException when user_not_found', () async {
      when(
        mockAuthClient.signInWithPassword(email: email, password: password),
      ).thenThrow(
        AuthApiException('User not found', statusCode: 'user_not_found'),
      );

      final params = AuthParameters(email, password);
      expect(
        () => authImpl.signIn(params),
        throwsA(isA<UserNotFoundException>()),
      );
    });

    test('signIn throws OtherException for other errors', () async {
      when(
        mockAuthClient.signInWithPassword(email: email, password: password),
      ).thenThrow(AuthApiException('Some error', statusCode: 'unknown_error'));

      final params = AuthParameters(email, password);
      expect(() => authImpl.signIn(params), throwsA(isA<OtherException>()));
    });
  });

  group('signUp', () {
    const email = 'newuser@example.com';
    const password = 'password123';
    const userId = 'new-user-id';

    test('signUp success', () async {
      when(mockUser.id).thenReturn(userId);
      when(mockUser.email).thenReturn(email);
      when(
        mockAuthClient.signUp(email: email, password: password),
      ).thenAnswer((_) async => AuthResponse(user: mockUser, session: null));

      final params = AuthParameters(email, password);
      final result = await authImpl.signUp(params);

      expect(result.userId, userId);
      expect(result.userEmail, email);
      verify(mockAuthClient.signUp(email: email, password: password)).called(1);
    });

    test(
      'signUp throws EmailInvalidException when email_address_invalid',
      () async {
        when(mockAuthClient.signUp(email: email, password: password)).thenThrow(
          AuthApiException(
            'Invalid email',
            statusCode: 'email_address_invalid',
          ),
        );

        final params = AuthParameters(email, password);
        expect(
          () => authImpl.signUp(params),
          throwsA(isA<EmailInvalidException>()),
        );
      },
    );

    test(
      'signUp throws UserAlreadyExistsException when email_exists',
      () async {
        when(mockAuthClient.signUp(email: email, password: password)).thenThrow(
          AuthApiException('User already exists', statusCode: 'email_exists'),
        );

        final params = AuthParameters(email, password);
        expect(
          () => authImpl.signUp(params),
          throwsA(isA<UserAlreadyExistsException>()),
        );
      },
    );

    test('signUp throws PasswordWeakException when weak_password', () async {
      when(mockAuthClient.signUp(email: email, password: password)).thenThrow(
        AuthApiException('Password too weak', statusCode: 'weak_password'),
      );

      final params = AuthParameters(email, password);
      expect(
        () => authImpl.signUp(params),
        throwsA(isA<PasswordWeakException>()),
      );
    });

    test('signUp throws OtherException for unknown errors', () async {
      when(
        mockAuthClient.signUp(email: email, password: password),
      ).thenThrow(AuthApiException('Some error', statusCode: 'unknown_error'));

      final params = AuthParameters(email, password);
      expect(() => authImpl.signUp(params), throwsA(isA<OtherException>()));
    });
  });

  group('signOut', () {
    test('signOut calls auth client signOut', () async {
      when(mockAuthClient.signOut()).thenAnswer((_) async => null);

      await authImpl.signOut();

      verify(mockAuthClient.signOut()).called(1);
    });
  });

  group('changePassword', () {
    const newPassword = 'newPassword123';

    test('changePassword success', () async {
      when(
        mockAuthClient.updateUser(any),
      ).thenAnswer((_) async => mockUserResponse);

      await authImpl.changePassword(newPassword);

      verify(mockAuthClient.updateUser(any)).called(1);
    });

    test(
      'changePassword throws PasswordWeakException when weak_password',
      () async {
        when(mockAuthClient.updateUser(any)).thenThrow(
          AuthApiException('Password too weak', statusCode: 'weak_password'),
        );

        expect(
          () => authImpl.changePassword(newPassword),
          throwsA(isA<PasswordWeakException>()),
        );
      },
    );

    test('changePassword throws OtherException for other errors', () async {
      when(
        mockAuthClient.updateUser(any),
      ).thenThrow(AuthApiException('Some error', statusCode: 'unknown_error'));

      expect(
        () => authImpl.changePassword(newPassword),
        throwsA(isA<OtherException>()),
      );
    });
  });
}
