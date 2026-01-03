import 'package:repository/src/parameters/filter_parameters.dart';

abstract interface class DatabaseContract {
  Future<List<Map<String, dynamic>>> readData(
    String tableName, {
    required FilterParameters filter,
  });
  Future<void> insertData(
    String tableName, {
    required Map<String, dynamic> data,
  });
  Future<void> updateData(
    String tableName, {
    required Map<String, dynamic> data,
    required FilterParameters filter,
  });
  Future<void> deleteData(String tableName, {required FilterParameters filter});
}
