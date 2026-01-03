enum FilterType {
  equals,
  greaterThan,
  greaterThanOrEqual,
  lessThan,
  lessThanOrEqual,
  like,
}

class FilterParameters {
  final String key;
  final dynamic value;
  final FilterType filterType;

  FilterParameters._(this.key, this.value, this.filterType);

  ///For the [equals], will be selected considering the exact value, in SQL command would be like that:
  ///```Select * from table where id == 0```
  factory FilterParameters.equals(String key, dynamic value) =>
      FilterParameters._(key, value, FilterType.equals);

  ///For the [greaterThan], will be selected considering the results that present values greater than the value informed,
  /// in SQL command would be like that:
  ///```Select * from table where id > 0```
  factory FilterParameters.greaterThan(String key, dynamic value) =>
      FilterParameters._(key, value, FilterType.greaterThan);

  ///For the [greaterThanOrEqual], will be selected considering the results that present values greater than or equal to the value informed,
  /// in SQL command would be like that:
  ///```Select * from table where id >= 0```
  factory FilterParameters.greaterThanOrEqual(String key, dynamic value) =>
      FilterParameters._(key, value, FilterType.greaterThanOrEqual);

  ///For the [lessThan], will be selected considering the results that present values less than the value informed,
  /// in SQL command would be like that:
  ///```Select * from table where id < 0```
  factory FilterParameters.lessThan(String key, dynamic value) =>
      FilterParameters._(key, value, FilterType.lessThan);

  ///For the [lessThanOrEqual], will be selected considering the results that present values less than or equal to the value informed,
  /// in SQL command would be like that:
  ///```Select * from table where id <= 0```
  factory FilterParameters.lessThanOrEqual(String key, dynamic value) =>
      FilterParameters._(key, value, FilterType.lessThanOrEqual);

  ///For the [contains], will be selected considering the results that contains the value informed,
  /// in SQL command would be like that:
  ///```Select * from table where name like "John"```
  factory FilterParameters.contains(String key, dynamic value) =>
      FilterParameters._(key, value, FilterType.like);
}
