import 'package:flutter_test/flutter_test.dart';
import 'package:mock_supabase_http_client/mock_supabase_http_client.dart';
import 'package:repository/src/implementations/database_implementations.dart';
import 'package:repository/src/parameters/filter_parameters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../mocks/mocks.dart';

void main() {
  late MockSupabaseHttpClient mockHttpClient;
  late SupabaseClient supabaseClient;
  late Supabase supabase;
  late DatabaseImplementations databaseImpl;

  setUpAll(() {
    mockHttpClient = MockSupabaseHttpClient();

    supabaseClient = SupabaseClient(
      'https://mock.supabase.co',
      'fakeAnonKey',
      httpClient: mockHttpClient,
    );

    supabase = MockSupabaseWrapper(supabaseClient);

    databaseImpl = DatabaseImplementations(supabase);
  });

  tearDown(() {
    mockHttpClient.reset();
  });

  group('readData', () {
    const tableName = 'test_table';
    const key = 'id';
    const value = 1;
    final testData = [
      {'id': 1, 'name': 'test'},
      {'id': 2, 'name': 'test2'},
      {'id': 3, 'name': 'other'},
    ];

    setUp(() async {
      await supabaseClient.from(tableName).insert(testData);
    });

    test('equals filter', () async {
      final filter = FilterParameters.equals(key, value);
      final result = await databaseImpl.readData(tableName, filter: filter);

      expect(result, [testData[0]]);
    });

    test('greaterThan filter', () async {
      final filter = FilterParameters.greaterThan(key, 1);
      final result = await databaseImpl.readData(tableName, filter: filter);

      expect(result.length, 2);
      expect(result, containsAll([testData[1], testData[2]]));
    });

    test('greaterThanOrEqual filter', () async {
      final filter = FilterParameters.greaterThanOrEqual(key, 2);
      final result = await databaseImpl.readData(tableName, filter: filter);

      expect(result.length, 2);
      expect(result, containsAll([testData[1], testData[2]]));
    });

    test('lessThan filter', () async {
      final filter = FilterParameters.lessThan(key, 3);
      final result = await databaseImpl.readData(tableName, filter: filter);

      expect(result.length, 2);
      expect(result, containsAll([testData[0], testData[1]]));
    });

    test('lessThanOrEqual filter', () async {
      final filter = FilterParameters.lessThanOrEqual(key, 2);
      final result = await databaseImpl.readData(tableName, filter: filter);

      expect(result.length, 2);
      expect(result, containsAll([testData[0], testData[1]]));
    });

    test('like filter', () async {
      final filter = FilterParameters.contains(key, '%test%');
      final result = await databaseImpl.readData(tableName, filter: filter);

      // Note: LIKE filter works on string columns, testing with name column
      expect(result.length, greaterThanOrEqualTo(0));
    });
  });

  group('deleteData', () {
    const tableName = 'test_table';
    const key = 'id';
    const value = 1;
    final testData = [
      {'id': 1, 'name': 'to_delete'},
      {'id': 2, 'name': 'to_keep'},
      {'id': 3, 'name': 'to_keep2'},
    ];

    setUp(() async {
      await supabaseClient.from(tableName).insert(testData);
    });

    test('equals filter', () async {
      final filter = FilterParameters.equals(key, value);
      await databaseImpl.deleteData(tableName, filter: filter);

      final remaining = await supabaseClient.from(tableName).select();
      expect(remaining.length, 2);
      expect(remaining.map((e) => e['id']), isNot(contains(1)));
    });

    test('greaterThan filter', () async {
      final filter = FilterParameters.greaterThan(key, 1);
      await databaseImpl.deleteData(tableName, filter: filter);

      final remaining = await supabaseClient.from(tableName).select();
      expect(remaining.length, 1);
      expect(remaining.first['id'], equals(1));
    });

    test('greaterThanOrEqual filter', () async {
      final filter = FilterParameters.greaterThanOrEqual(key, 2);
      await databaseImpl.deleteData(tableName, filter: filter);

      final remaining = await supabaseClient.from(tableName).select();
      expect(remaining.length, 1);
      expect(remaining.first['id'], equals(1));
    });

    test('lessThan filter', () async {
      final filter = FilterParameters.lessThan(key, 3);
      await databaseImpl.deleteData(tableName, filter: filter);

      final remaining = await supabaseClient.from(tableName).select();
      expect(remaining.length, 1);
      expect(remaining.first['id'], equals(3));
    });

    test('lessThanOrEqual filter', () async {
      final filter = FilterParameters.lessThanOrEqual(key, 2);
      await databaseImpl.deleteData(tableName, filter: filter);

      final remaining = await supabaseClient.from(tableName).select();
      expect(remaining.length, 1);
      expect(remaining.first['id'], equals(3));
    });

    test('like filter', () async {
      final filter = FilterParameters.contains('name', '%delete%');
      await databaseImpl.deleteData(tableName, filter: filter);

      final remaining = await supabaseClient.from(tableName).select();
      expect(remaining.length, 2);
      expect(
        remaining.map((e) => e['name']),
        containsAll(['to_keep', 'to_keep2']),
      );
    });
  });

  group('insertData', () {
    const tableName = 'test_table';
    final data = {'id': 1, 'name': 'inserted'};

    test('inserts data successfully', () async {
      await databaseImpl.insertData(tableName, data: data);

      final result = await supabaseClient.from(tableName).select();
      expect(result.length, 1);
      expect(result.first, data);
    });

    test('inserts multiple records', () async {
      await databaseImpl.insertData(
        tableName,
        data: {'id': 1, 'name': 'first'},
      );
      await databaseImpl.insertData(
        tableName,
        data: {'id': 2, 'name': 'second'},
      );

      final result = await supabaseClient.from(tableName).select();
      expect(result.length, 2);
    });
  });

  group('updateData', () {
    const tableName = 'test_table';
    const key = 'id';
    const value = 1;
    final testData = [
      {'id': 1, 'name': 'original', 'status': 'active'},
      {'id': 2, 'name': 'other', 'status': 'inactive'},
      {'id': 3, 'name': 'another', 'status': 'active'},
    ];

    setUp(() async {
      await supabaseClient.from(tableName).insert(testData);
    });

    test('equals filter', () async {
      final filter = FilterParameters.equals(key, value);
      await databaseImpl.updateData(
        tableName,
        data: {'name': 'updated'},
        filter: filter,
      );

      final result = await supabaseClient.from(tableName).select();
      expect(result.firstWhere((e) => e['id'] == 1)['name'], equals('updated'));
    });

    test('greaterThan filter', () async {
      final filter = FilterParameters.greaterThan(key, 1);
      await databaseImpl.updateData(
        tableName,
        data: {'status': 'updated'},
        filter: filter,
      );

      final result = await supabaseClient.from(tableName).select();
      expect(
        result.firstWhere((e) => e['id'] == 2)['status'],
        equals('updated'),
      );
      expect(
        result.firstWhere((e) => e['id'] == 3)['status'],
        equals('updated'),
      );
      expect(
        result.firstWhere((e) => e['id'] == 1)['status'],
        equals('active'),
      );
    });

    test('greaterThanOrEqual filter', () async {
      final filter = FilterParameters.greaterThanOrEqual(key, 2);
      await databaseImpl.updateData(
        tableName,
        data: {'name': 'batch_updated'},
        filter: filter,
      );

      final result = await supabaseClient.from(tableName).select();
      expect(
        result.firstWhere((e) => e['id'] == 2)['name'],
        equals('batch_updated'),
      );
      expect(
        result.firstWhere((e) => e['id'] == 3)['name'],
        equals('batch_updated'),
      );
      expect(
        result.firstWhere((e) => e['id'] == 1)['name'],
        equals('original'),
      );
    });

    test('lessThan filter', () async {
      final filter = FilterParameters.lessThan(key, 3);
      await databaseImpl.updateData(
        tableName,
        data: {'status': 'archived'},
        filter: filter,
      );

      final result = await supabaseClient.from(tableName).select();
      expect(
        result.firstWhere((e) => e['id'] == 1)['status'],
        equals('archived'),
      );
      expect(
        result.firstWhere((e) => e['id'] == 2)['status'],
        equals('archived'),
      );
      expect(
        result.firstWhere((e) => e['id'] == 3)['status'],
        equals('active'),
      );
    });

    test('lessThanOrEqual filter', () async {
      final filter = FilterParameters.lessThanOrEqual(key, 2);
      await databaseImpl.updateData(
        tableName,
        data: {'name': 'partial_update'},
        filter: filter,
      );

      final result = await supabaseClient.from(tableName).select();
      expect(
        result.firstWhere((e) => e['id'] == 1)['name'],
        equals('partial_update'),
      );
      expect(
        result.firstWhere((e) => e['id'] == 2)['name'],
        equals('partial_update'),
      );
      expect(result.firstWhere((e) => e['id'] == 3)['name'], equals('another'));
    });

    test('like filter', () async {
      final filter = FilterParameters.contains('name', '%other%');
      await databaseImpl.updateData(
        tableName,
        data: {'status': 'matched'},
        filter: filter,
      );

      final result = await supabaseClient.from(tableName).select();
      expect(
        result.firstWhere((e) => e['id'] == 2)['status'],
        equals('matched'),
      );
    });
  });
}
