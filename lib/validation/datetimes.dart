part of quds_server;

extension DateTimesValidationExtention on ApiValidator {
  /// Add [IsDateTime] validation rule.
  IsDateTime isDateTime() {
    return IsDateTime()..parent = this;
  }
}

class IsDateTime extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! String || DateTime.tryParse(value) == null) {
      return '[$fieldName] must be a DateTime object';
    }
  }
}
