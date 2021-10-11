// part of quds_server;

// String? validateValue(String validationRules, String fieldKey, dynamic value) {
//   var validationParts =
//       validationRules.split('|').map((e) => e.toLowerCase().trim());

//   for (var part in validationParts) {
//     // if (part == 'required' && value == null) {
//     //   return 'Field [$fieldKey] is required!';
//     // }

//     // if (['string', 'integer', 'double'].contains(part)) {
//     //   var checkValue = _checkValueType(part, fieldKey, value);
//     //   if (checkValue != null) return checkValue;
//     // }

//     // if (part == 'email') {
//     //   var checkValue = _validateEmail(fieldKey, value);
//     //   if (checkValue != null) return checkValue;
//     // }

//     // if (part == 'url') {
//     //   var checkValue = _validateUrl(fieldKey, value);
//     //   if (checkValue != null) return checkValue;
//     // }

//     // if (part.startsWith('reg')) {
//     //   var mParts = part.split(':');
//     //   if (mParts[0].trim() == 'reg') {
//     //     if (mParts.length != 2) return '[$fieldKey] Invalid regex pattern';
//     //     var checkValue = _checkRegex(fieldKey, value, mParts[1]);
//     //     if (checkValue != null) return checkValue;
//     //   }
//     // }
//     // if (part.startsWith('max') || part.startsWith('min')) {
//     //   var mParts = part.split(':');
//     //   if (['max', 'min'].contains(mParts[0].trim())) {
//     //     if (mParts.length != 2) {
//     //       return 'Invalid range value [$fieldKey - $part]';
//     //     }
//     //     var range = double.tryParse(mParts[1]);
//     //     if (range == null || (value is String && range < 0)) {
//     //       return 'Invalid range value [$part]';
//     //     }

//     //     var rangeCheck = _validateRangeValue(mParts[0], range, fieldKey, value);
//     //     if (rangeCheck != null) return rangeCheck;
//     //   }
//     // }
//   }
// }

// // String? _checkRegex(String fieldKey, dynamic value, String regexPattern) {
// //   if (value == null) return null;
// //   if (value is! String) return '[$fieldKey] must be String object';

// //   RegExp regex = RegExp(regexPattern);
// //   var match = regex.stringMatch(value);
// //   if (match != value) {
// //     return '[$fieldKey] doesn\'t match the requried pattern';
// //   }
// // }

// // String? _checkValueType(String typeName, String fieldKey, dynamic value) {
// //   if (value == null) return null;

// //   if ((typeName == 'string' && value is! String) ||
// //       (typeName == 'integer' && value is! int) ||
// //       (typeName == 'double' && value is! double && value is! int)) {
// //     return '[$fieldKey] field must be $typeName';
// //   }
// // }

// // String? _validateRangeValue(
// //     String borderType, double range, String fieldKey, dynamic value) {
// //   if (value is String) {
// //     if (range != range.toInt()) {
// //       return '[$fieldKey] Range must be integer for string length';
// //     }

// //     switch (borderType) {
// //       case 'min':
// //         if (!(value.length >= range)) {
// //           return '[$fieldKey] length must be >= ${range.toInt()}';
// //         }
// //         break;
// //       case 'max':
// //         if (!(value.length <= range)) {
// //           return '[$fieldKey] length must be <= ${range.toInt()}';
// //         }
// //         break;
// //     }
// //   } else {
// //     switch (borderType) {
// //       case 'min':
// //         if (!(value >= range)) return '[$fieldKey] value must be >= $range';
// //         break;
// //       case 'max':
// //         if (!(value <= range)) return '[$fieldKey] value must be <= $range';
// //         break;
// //     }
// //   }
// // }

// // String? _validateEmail(String fieldKey, dynamic value) {
// //   if (value == null) return null;
// //   if (value is! String) return '[$fieldKey] must be string';
// //   if (!validators.isEmail(value)) return '[$fieldKey] must be an email';
// // }

// // String? _validateUrl(String fieldKey, dynamic value) {
// //   if (value == null) return null;
// //   if (value is! String) return '[$fieldKey] must be string';
// //   var result = Uri.tryParse(value)?.isAbsolute;
// //   if (result != null) return '[$fieldKey] must be a url';
// // }

// // Response? validateRequest(
// //     Map<String, String> validationRules, Map<String, dynamic> bodyMap) {
// //   for (var v in validationRules.entries) {
// //     var validationResult = validateValue(v.value, v.key, bodyMap[v.key]);
// //     if (validationResult != null) {
// //       return responseApiBadRequest(message: validationResult);
// //     }
// //   }
// // }
