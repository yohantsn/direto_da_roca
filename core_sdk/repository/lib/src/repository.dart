import 'package:iod/iod.dart';
import 'package:repository/src/contracts/contracts.dart';
import 'package:repository/src/implementations/auth_implementation.dart';
import 'package:repository/src/implementations/database_implementations.dart';
import 'package:repository/src/secrets/app_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Repository {
  Future<void> init() async {
    final instance = await Supabase.initialize(
      url: AppKeys.databaseUrl,
      anonKey: AppKeys.databaseAnonKey,
    );

    IoD.register<DatabaseContract>(DatabaseImplementations(instance));
    IoD.register<AuthContract>(AuthImplementation(instance));
  }

  /// return an instance from database, certified that the repository was instantiated before.
  DatabaseContract get database {
    try {
      return IoD.read<DatabaseContract>();
    } catch (_) {
      throw Exception(
        "Repository not instantiated, please, call the init function before use it.",
      );
    }
  }

  /// return an instance from authentication service, certified that the repository was instantiated before.
  AuthContract get authentication {
    try {
      return IoD.read<AuthContract>();
    } catch (_) {
      throw Exception(
        "Repository not instantiated, please, call the init function before use it.",
      );
    }
  }
}
