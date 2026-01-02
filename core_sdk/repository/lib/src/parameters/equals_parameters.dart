enum FilterType {
  equals,
  greatThan,
  greatThanOrEqual,
  lessThan,
  lessThanOrEqual,
  like,
}

class FilterParameters {
  final String key;
  final dynamic value;
  final FilterType filterType;

  FilterParameters(this.key, this.value, this.filterType);

  factory FilterParameters.equals(String key, dynamic value) =>
      FilterParameters(key, value, FilterType.equals);

  factory FilterParameters.greatThan(String key, dynamic value) =>
      FilterParameters(key, value, FilterType.greatThan);

  factory FilterParameters.greatThanOrEqual(String key, dynamic value) =>
      FilterParameters(key, value, FilterType.greatThanOrEqual);

  factory FilterParameters.lessThan(String key, dynamic value) =>
      FilterParameters(key, value, FilterType.lessThan);

  factory FilterParameters.lessThanOrEqual(String key, dynamic value) =>
      FilterParameters(key, value, FilterType.lessThanOrEqual);

  factory FilterParameters.contains(String key, dynamic value) =>
      FilterParameters(key, value, FilterType.like);
}
