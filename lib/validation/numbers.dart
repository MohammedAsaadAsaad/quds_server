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
    return null;
  }
}

class IsPositiveInteger extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int) return '[$fieldName] must be an integer value';
    if (value <= 0) return '[$fieldName] must be a positive integer';
    return null;
  }
}

class IsNegativeInteger extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int) return '[$fieldName] must be an integer value';
    if (value >= 0) return '[$fieldName] must be a negative integer';
    return null;
  }
}

class IsNonPositiveInteger extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int) return '[$fieldName] must be an integer value';
    if (value > 0) return '[$fieldName] must be a non positive integer';
    return null;
  }
}

class IsNonNegativeInteger extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int) return '[$fieldName] must be an integer value';
    if (value < 0) return '[$fieldName] must be a non negative integer';
    return null;
  }
}

class IsPositive extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! num) return '[$fieldName] must be a number value';
    if (value <= 0) return '[$fieldName] must be a positive number';
    return null;
  }
}

class IsNegative extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! num) return '[$fieldName] must be a number value';
    if (value >= 0) return '[$fieldName] must be a negative number';
    return null;
  }
}

class IsNonPositive extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! num) return '[$fieldName] must be a number value';
    if (value > 0) return '[$fieldName] must be a non positive number';
    return null;
  }
}

class IsNonNegative extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! num) return '[$fieldName] must be a num value';
    if (value < 0) return '[$fieldName] must be a non negative number';
    return null;
  }
}

class IsDouble extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int && value is! double) {
      return '[$fieldName] must be a double value';
    }
    return null;
  }
}
