part of quds_server;

extension BooleansValidationExtention on ApiValidator {
  /// Add [IsBoolean] validation rule.
  IsBoolean isBoolean() {
    return IsBoolean()..parent = this;
  }
}

class IsBoolean extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! bool) {
      return '[$fieldName] must be a Boolean object';
    }
    return null;
  }
}
