part of quds_server;

/// The base class of api validators
abstract class ApiValidator {
  dynamic _parent;
  String? validateValue(String fieldName, dynamic value);

  /// Add [Required] validation rule.
  Required required() {
    return Required().._parent = this;
  }

  /// Add [IsString] validation rule.
  IsString isString() {
    return IsString().._parent = this;
  }

  /// Add [IsInteger] validation rule.
  IsInteger isInteger() {
    return IsInteger().._parent = this;
  }

  /// Add [IsDateTime] validation rule.
  IsDateTime isDateTime() {
    return IsDateTime().._parent = this;
  }

  /// Add [IsDouble] validation rule.
  IsDouble isDouble() {
    return IsDouble().._parent = this;
  }

  /// Add [IsUrl] validation rule.
  IsUrl isUrl() {
    return IsUrl().._parent = this;
  }

  /// Add [IsEmail] validation rule.
  IsEmail isEmail() {
    return IsEmail().._parent = this;
  }

  /// Add [MatchRegex] validation rule.
  MatchRegex matchRegex(String pattern) {
    return MatchRegex(pattern).._parent = this;
  }

  /// Add [Max] validation rule.
  Max max(double max) {
    return Max(max).._parent = this;
  }

  /// Add [Min] validation rule.
  Min min(double min) {
    return Min(min).._parent = this;
  }

  /// validate the [fieldName] if matches the intented rules.
  String? validate(String fieldName, dynamic value) {
    var checkValue =
        _parent?.validate(fieldName, value) ?? validateValue(fieldName, value);
    return checkValue;
  }
}

/// validate the whole request [bodyMap] if matches the passed [validationRules]
Response? validateRequest(
    Map<String, ApiValidator> validationRules, Map<String, dynamic> bodyMap) {
  for (var v in validationRules.entries) {
    var validationResult = v.value.validate(v.key, bodyMap[v.key]);
    if (validationResult != null) {
      return responseApiBadRequest(message: validationResult);
    }
  }
}

class Required extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return '[$fieldName] is required';
  }
}

class IsInteger extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! int) return '[$fieldName] must be an integer value';
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

class IsString extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! String) return '[$fieldName] must be a string value';
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

class MatchRegex extends ApiValidator {
  final String _pattern;
  MatchRegex(this._pattern);
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! String) return '[$fieldName] must be String object';

    RegExp regex = RegExp(_pattern);
    var match = regex.stringMatch(value);
    if (match != value) {
      return '[$fieldName] doesn\'t match the requried pattern';
    }
  }
}

class Max extends ApiValidator {
  final double _max;
  Max(this._max);
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if ((value is String && _max < 0)) {
      return 'Invalid range value [$fieldName - Max]';
    }

    if (value is String || value is List) {
      if (_max != _max.toInt()) {
        return '[$fieldName] Range must be integer for string length';
      }
      if (!(value.length <= _max)) {
        return '[$fieldName] length must be <= ${_max.toInt()}';
      }
    } else {
      if (!(value <= _max)) return '[$fieldName] value must be <= $_max';
    }
  }
}

class Min extends ApiValidator {
  final double _min;
  Min(this._min);
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if ((value is String && _min < 0)) {
      return 'Invalid range value [$fieldName - Min]';
    }

    if (value is String || value is List) {
      if (_min != _min.toInt()) {
        return '[$fieldName] Range must be integer for string length';
      }
      if (!(value.length >= _min)) {
        return '[$fieldName] length must be >= ${_min.toInt()}';
      }
    } else {
      if (!(value <= _min)) return '[$fieldName] value must be >= $_min';
    }
  }
}

class IsUrl extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! String) return '[$fieldName] must be string';
    var result = Uri.tryParse(value)?.isAbsolute;
    if (result != null) return '[$fieldName] must be a url';
  }
}

class IsEmail extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! String) return '[$fieldName] must be string';
    if (!validators.isEmail(value)) return '[$fieldName] must be an email';
  }
}

extension BodyMapValidation on Map<String, dynamic> {
  Response? validate(
    Map<String, ApiValidator> validationRules,
  ) {
    for (var v in validationRules.entries) {
      var validationResult = v.value.validate(v.key, this[v.key]);
      if (validationResult != null) {
        return responseApiBadRequest(message: validationResult);
      }
    }
  }
}
