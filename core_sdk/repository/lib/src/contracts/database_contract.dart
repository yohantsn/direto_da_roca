import 'package:repository/src/parameters/filter_parameters.dart';

abstract interface class DatabaseContract {
  /// Use this function to get a list of data from remote database, is necessary inform the table some filter.
  Future<List<T>> readData<T>(String tableName, {required FilterParameters filter});

  /// Use this function to save some new data, passing the table name and the information that will be save on the database.
  /// Attention, the table must be already existent.
  Future<void> insertData(String tableName, {required Map<String, dynamic> data});

  Future<void> updateData(String tableName, {required Map<String, dynamic> data, required FilterParameters filter});
  Future<void> deleteData(String tableName, {required FilterParameters filter});
}
