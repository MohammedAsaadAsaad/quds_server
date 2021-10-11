part of quds_server;

abstract class ApiValidator {
  dynamic _parent;
  String? _validate(String fieldName, dynamic value);

  Required required() {
    return Required().._parent = this;
  }

  IsString isString() {
    return IsString().._parent = this;
  }

  IsInteger isInteger() {
    return IsInteger().._parent = this;
  }

  IsDouble isDouble() {
    return IsDouble().._parent = this;
  }

  IsUrl isUrl() {
    return IsUrl().._parent = this;
  }

  IsEmail isEmail() {
    return IsEmail().._parent = this;
  }

  MatchRegex matchRegex(String pattern) {
    return MatchRegex(pattern).._parent = this;
  }

  Max max(double max) {
    return Max(max).._parent = this;
  }

  Min min(double min) {
    return Min(min).._parent = this;
  }

  String? validate(String fieldName, dynamic value) {
    var checkValue =
        _parent?.validate(fieldName, value) ?? _validate(fieldName, value);
    return checkValue;
  }
}

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
  String? _validate(String fieldName, value) {
    if (value == null) return '[$fieldName] is required';
  }
}

class IsInteger extends ApiValidator {
  @override
  String? _validate(String fieldName, value) {
    if (value == null) return null;
    if (value is! int) return '[$fieldName] must be an integer value';
  }
}

class IsString extends ApiValidator {
  @override
  String? _validate(String fieldName, value) {
    if (value == null) return null;
    if (value is! String) return '[$fieldName] must be a string value';
  }
}

class IsDouble extends ApiValidator {
  @override
  String? _validate(String fieldName, value) {
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
  String? _validate(String fieldName, value) {
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
  String? _validate(String fieldName, value) {
    if ((value is String && _max < 0)) {
      return 'Invalid range value [$fieldName - Max]';
    }

    if (value is String) {
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
  String? _validate(String fieldName, value) {
    if ((value is String && _min < 0)) {
      return 'Invalid range value [$fieldName - Min]';
    }

    if (value is String) {
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
  String? _validate(String fieldName, value) {
    if (value == null) return null;
    if (value is! String) return '[$fieldName] must be string';
    var result = Uri.tryParse(value)?.isAbsolute;
    if (result != null) return '[$fieldName] must be a url';
  }
}

class IsEmail extends ApiValidator {
  @override
  String? _validate(String fieldName, value) {
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
