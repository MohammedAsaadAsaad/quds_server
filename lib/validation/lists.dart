part of quds_server;

extension ListsValidationExtention on ApiValidator {
  /// Add [IsListOfType] validation rule.
  IsListOfType<T> isListOfType<T>() {
    return IsListOfType<T>()..parent = this;
  }

  /// Add [IsMapOf] validation rule.
  IsMapOf<K, V> isMapOf<K, V>() {
    return IsMapOf<K, V>()..parent = this;
  }
}

class IsListOfType<T> extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! List) return '[$fieldName] must be a list';
    for (var v in value) {
      if (v is! T) return '[$fieldName] has invalid values';
    }
    return null;
  }
}

class IsMapOf<K, V> extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! Map) {
      return '[$fieldName] must be a Map of ${K.toString()},${V.toString()}';
    }
    for (var v in value.entries) {
      if (v.key is! K || v.value is! V) {
        return '[$fieldName] has invalid entries';
      }
    }
    return null;
  }
}
