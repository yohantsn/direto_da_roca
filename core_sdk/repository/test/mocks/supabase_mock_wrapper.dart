import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseWrapper implements Supabase {
  MockSupabaseWrapper(this._client);

  final SupabaseClient _client;

  @override
  SupabaseClient get client => _client;

  @override
  bool get isInitialized => true;

  @override
  Future<void> dispose() async {}

  @override
  Future<void> onResumed() async {}

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
