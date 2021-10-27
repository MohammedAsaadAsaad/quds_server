part of quds_server;

extension NumbersValidationExtention on ApiValidator {
  /// Add [IsInteger] validation rule.
  IsInteger isInteger() {
    return IsInteger()..parent = this;
  }

  /// Add [IsPositiveInteger] validation rule.
  IsPositiveInteger isPositiveInteger() {
    return IsPositiveInteger()..parent = this;
  }

  /// Add [IsNonPositiveInteger] validation rule.
  IsNonPositiveInteger isNonPositiveInteger() {
    return IsNonPositiveInteger()..parent = this;
  }

  /// Add [IsNegativeInteger] validation rule.
  IsNegativeInteger isNegativeInteger() {
    return IsNegativeInteger()..parent = this;
  }

  /// Add [IsNonNegativeInteger] validation rule.
  IsNonNegativeInteger isNonNegativeInteger() {
    return IsNonNegativeInteger()..parent = this;
  }

  /// Add [IsPositive] validation rule.
  IsPositive isPositive() {
    return IsPositive()..parent = this;
  }

  /// Add [IsNonPositive] validation rule.
  IsNonPositive isNonPositive() {
    return IsNonPositive()..parent = this;
  }

  /// Add [IsNegative] validation rule.
  IsNegative isNegative() {
    return IsNegative()..parent = this;
  }

  /// Add [IsNonNegative] validation rule.
  IsNonNegative isNonNegative() {
    return IsNonNegative()..parent = this;
  }

  /// Add [IsDouble] validation rule.
  IsDouble isDouble() {
    return IsDouble()..parent = this;
  }
}

class IsInteger extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int) return '[$fieldName] must be an integer value';
  }
}

class IsPositiveInteger extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int) return '[$fieldName] must be an integer value';
    if (value <= 0) return '[$fieldName] must be a positive integer';
  }
}

class IsNegativeInteger extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int) return '[$fieldName] must be an integer value';
    if (value >= 0) return '[$fieldName] must be a negative integer';
  }
}

class IsNonPositiveInteger extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int) return '[$fieldName] must be an integer value';
    if (value > 0) return '[$fieldName] must be a non positive integer';
  }
}

class IsNonNegativeInteger extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int) return '[$fieldName] must be an integer value';
    if (value < 0) return '[$fieldName] must be a non negative integer';
  }
}

class IsPositive extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! num) return '[$fieldName] must be a number value';
    if (value <= 0) return '[$fieldName] must be a positive number';
  }
}

class IsNegative extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! num) return '[$fieldName] must be a number value';
    if (value >= 0) return '[$fieldName] must be a negative number';
  }
}

class IsNonPositive extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! num) return '[$fieldName] must be a number value';
    if (value > 0) return '[$fieldName] must be a non positive number';
  }
}

class IsNonNegative extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! num) return '[$fieldName] must be a num value';
    if (value < 0) return '[$fieldName] must be a non negative number';
  }
}

class IsDouble extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int && value is! double) {
      return '[$fieldName] must be a double value';
    }
  }
}
