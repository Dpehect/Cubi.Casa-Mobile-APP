class RegexPatterns {
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static final RegExp phoneRegex = RegExp(
    r'^\+?[0-9]{10,}$',
  );

  static final RegExp urlRegex = RegExp(
    r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
    caseSensitive: false,
  );

  static final RegExp numberRegex = RegExp(
    r'^-?\d+\.?\d*$',
  );

  static final RegExp alphanumericRegex = RegExp(
    r'^[a-zA-Z0-9]+$',
  );

  static final RegExp nameRegex = RegExp(
    r'^[a-zA-Z\s]+$',
  );

  static final RegExp postalCodeRegex = RegExp(
    r'^\d{5}(-\d{4})?$',
  );
}
