import 'package:repository/src/contracts/database_contract.dart';
import 'package:repository/src/parameters/filter_parameters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseImplementations implements DatabaseContract {
  DatabaseImplementations(this._supabase);
  final Supabase _supabase;

  @override
  Future<List<Map<String, dynamic>>> readData(
    String tableName, {
    required FilterParameters filter,
  }) async {
    final table = _supabase.client.from(tableName);
    final result = await switch (filter.filterType) {
      FilterType.equals => table.select().eq(filter.key, filter.value),
      FilterType.greatThan => table.select().gt(filter.key, filter.value),
      FilterType.greatThanOrEqual => table.select().gte(
        filter.key,
        filter.value,
      ),
      FilterType.lessThan => table.select().lt(filter.key, filter.value),
      FilterType.lessThanOrEqual => table.select().lte(
        filter.key,
        filter.value,
      ),
      FilterType.like => table.select().like(filter.key, filter.value),
    };
    return result;
  }

  @override
  Future<void> deleteData(
    String tableName, {
    required FilterParameters filter,
  }) async {
    final table = _supabase.client.from(tableName);
    await switch (filter.filterType) {
      FilterType.equals => table.delete().eq(filter.key, filter.value),
      FilterType.greatThan => table.delete().gt(filter.key, filter.value),
      FilterType.greatThanOrEqual => table.delete().gte(
        filter.key,
        filter.value,
      ),
      FilterType.lessThan => table.delete().lt(filter.key, filter.value),
      FilterType.lessThanOrEqual => table.delete().lte(
        filter.key,
        filter.value,
      ),
      FilterType.like => table.delete().like(filter.key, filter.value),
    };
  }

  @override
  Future<void> insertData(
    String tableName, {
    required Map<String, dynamic> data,
  }) {
    return _supabase.client.from(tableName).insert(data);
  }

  @override
  Future<void> updateData(
    String tableName, {
    required Map<String, dynamic> data,
    required FilterParameters filter,
  }) {
    final table = _supabase.client.from(tableName);
    return switch (filter.filterType) {
      FilterType.equals => table.update(data).eq(filter.key, filter.value),
      FilterType.greatThan => table.update(data).gt(filter.key, filter.value),
      FilterType.greatThanOrEqual =>
        table.update(data).gte(filter.key, filter.value),
      FilterType.lessThan => table.update(data).lt(filter.key, filter.value),
      FilterType.lessThanOrEqual =>
        table.update(data).lte(filter.key, filter.value),
      FilterType.like => table.update(data).like(filter.key, filter.value),
    };
  }
}
