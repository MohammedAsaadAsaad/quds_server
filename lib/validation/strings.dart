part of quds_server;

extension StringsValidationExtention on ApiValidator {
  /// Add [IsString] validation rule.
  IsString isString() {
    return IsString()..parent = this;
  }

  /// Add [IsUrl] validation rule.
  IsUrl isUrl() {
    return IsUrl()..parent = this;
  }

  /// Add [IsEmail] validation rule.
  IsEmail isEmail() {
    return IsEmail()..parent = this;
  }

  /// Add [MatchRegex] validation rule.
  MatchRegex matchRegex(String pattern) {
    return MatchRegex(pattern)..parent = this;
  }
}

class IsString extends ApiValidator {
  @override
  String? validateValue(String fieldName, value) {
    if (value == null) return null;
    if (value is! String) return '[$fieldName] must be a string value';
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
