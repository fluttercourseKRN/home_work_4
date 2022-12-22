class Validator {
  static const _maxLength = 12;
  static const _minLength = 2;

  static String? basicValidator(String? value) {
    if (value == null) {
      return 'System Error';
    }
    if (value.isEmpty) {
      return 'The field can\'t be empty';
    }
    if (value.length < _minLength) {
      return 'The field length can\'t be less than $_minLength character(s)';
    }
    if (value.length > _maxLength) {
      return 'The field length can\'t be greater than $_maxLength character(s)';
    }
    return null;
  }
}
