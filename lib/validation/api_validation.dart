part of quds_server;

/// The base class of api validators
abstract class ApiValidator {
  ApiValidator? parent;
  String? validateValue(String fieldName, dynamic value);

  /// validate the [fieldName] if matches the intented rules.
  String? validate(String fieldName, dynamic value) {
    var checkValue =
        parent?.validate(fieldName, value) ?? validateValue(fieldName, value);
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
