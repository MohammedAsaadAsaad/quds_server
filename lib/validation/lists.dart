part of quds_server;

extension ListsValidationExtention on ApiValidator {
  /// Add [IsDateTime] validation rule.
  IsListOfType<T> isListOfType<T>() {
    return IsListOfType<T>()..parent = this;
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
