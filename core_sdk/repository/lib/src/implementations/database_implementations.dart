import 'package:repository/src/contracts/database_contract.dart';
import 'package:repository/src/parameters/filter_parameters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseImplementations implements DatabaseContract {
  DatabaseImplementations(this._supabase);
  final Supabase _supabase;

  @override
  Future<List<T>> readData<T>(String tableName, {required FilterParameters filter}) async {
    final table = _supabase.client.from(tableName);

    final result = await _applyFilter(table.select(), filter);
    return await result;
  }

  @override
  Future<void> deleteData(String tableName, {required FilterParameters filter}) {
    final table = _supabase.client.from(tableName);
    return _applyFilter(table.delete(), filter);
  }

  @override
  Future<void> insertData(String tableName, {required Map<String, dynamic> data}) {
    return _supabase.client.from(tableName).insert(data);
  }

  @override
  Future<void> updateData(String tableName, {required Map<String, dynamic> data, required FilterParameters filter}) {
    final table = _supabase.client.from(tableName);
    return _applyFilter(table.update(data), filter);
  }

  Future<PostgrestFilterBuilder> _applyFilter(PostgrestFilterBuilder builder, FilterParameters filter) async {
    return switch (filter.filterType) {
      FilterType.equals => builder.eq(filter.key, filter.value),
      FilterType.greaterThan => builder.gt(filter.key, filter.value),
      FilterType.greaterThanOrEqual => builder.gte(filter.key, filter.value),
      FilterType.lessThan => builder.lt(filter.key, filter.value),
      FilterType.lessThanOrEqual => builder.lte(filter.key, filter.value),
      FilterType.like => builder.like(filter.key, filter.value),
    };
  }
}
