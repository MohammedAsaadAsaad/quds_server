part of quds_server;

extension CommonsValidationExtention on ApiValidator {
  /// Add [Max] validation rule.
  Max max(double max) {
    return Max(max)..parent = this;
  }

  /// Add [Min] validation rule.
  Min min(double min) {
    return Min(min)..parent = this;
  }

  /// Add [Required] validation rule.
  Required required() {
    return Required()..parent = this;
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

class Required extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return '[$fieldName] is required';
  }
}
