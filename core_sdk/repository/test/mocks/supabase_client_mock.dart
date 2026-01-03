import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient implements SupabaseClient {
  MockSupabaseClient(this._authClient);
  final GoTrueClient _authClient;

  @override
  GoTrueClient get auth => _authClient;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
