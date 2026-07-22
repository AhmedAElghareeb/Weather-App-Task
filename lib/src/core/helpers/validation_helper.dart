import 'package:easy_localization/easy_localization.dart';

class Validators {
  Validators._();

  // ==================== Name Validation ====================

  /// Validates a single name (First or Last)
  static String? validateSingleName(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.required_field'.tr(
        namedArgs: {'field': fieldName ?? 'validation.name'.tr()},
      );
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < 3) {
      return 'validation.name_too_short'.tr();
    }

    // Supports Arabic and English letters, excludes numbers and special characters
    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');
    if (!nameRegex.hasMatch(trimmedValue)) {
      return 'validation.name_invalid_characters'.tr();
    }

    return null;
  }

  /// Specific for First Name
  static String? validateFirstName(String? value) {
    return validateSingleName(value, fieldName: 'validation.first_name'.tr());
  }

  /// Specific for Last Name
  static String? validateLastName(String? value) {
    return validateSingleName(value, fieldName: 'validation.last_name'.tr());
  }

  /// Validates Full Name (Requires at least two words)
  static String? validateFullName(String? value) {
    final basicError = validateSingleName(value, fieldName: 'validation.full_name'.tr());
    if (basicError != null) return basicError;

    final words = value!.trim().split(RegExp(r'\s+'));
    if (words.length < 2) {
      return 'validation.full_name_required'.tr();
    }

    return null;
  }

  // ==================== Phone Validation ====================

  static String? validatePhone(String? value, {String? countryCode}) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.phone_required'.tr();
    }

    final cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');

    // Yemen (+967) - Keeping your specific business rules
    if (countryCode == '+967' || cleanPhone.startsWith('967')) {
      final phoneWithoutCode = cleanPhone.replaceFirst(RegExp(r'^967'), '');

      // Yemen mobile numbers must start with 7 and be 8 or 9 digits
      if (!RegExp(r'^7[0-9]{7,8}$').hasMatch(phoneWithoutCode)) {
        return 'validation.phone_invalid_yemen'.tr();
      }
      return null;
    }

    // KSA (+966) - Starts with 5 and has 9 digits
    if (countryCode == '+966' || cleanPhone.startsWith('966')) {
      final phoneWithoutCode = cleanPhone.replaceFirst(RegExp(r'^966'), '');
      if (!RegExp(r'^5[0-9]{8}$').hasMatch(phoneWithoutCode)) {
        return 'validation.phone_invalid_ksa'.tr();
      }
      return null;
    }

    // Egypt (+20) - Starts with 1, then (0, 1, 2, or 5), then 8 digits
    if (countryCode == '+20' || cleanPhone.startsWith('20')) {
      final phoneWithoutCode = cleanPhone.replaceFirst(RegExp(r'^20'), '');
      if (!RegExp(r'^1[0125][0-9]{8}$').hasMatch(phoneWithoutCode)) {
        return 'validation.phone_invalid_egp'.tr();
      }
      return null;
    }

    // Generic fallback for other countries
    if (cleanPhone.length < 7 || cleanPhone.length > 15) {
      return 'validation.phone_invalid'.tr();
    }

    return null;
  }

  // ==================== Email Validation ====================

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.email_required'.tr();
    }
    return _checkEmailFormat(value);
  }

  /// Validates email only if the user has typed something
  static String? validateEmailOptional(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Valid because it's not required
    }
    return _checkEmailFormat(value);
  }

  static String? _checkEmailFormat(String value) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'validation.email_invalid'.tr();
    }
    return null;
  }

  // ==================== Password Validation ====================

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.password_required'.tr();
    }

    if (value.length < 8) {
      return 'validation.password_too_short'.tr();
    }

    // Optional: Requires at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'validation.password_no_uppercase'.tr();
    }

    // Optional: Requires at least one digit
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'validation.password_no_digit'.tr();
    }

    return null;
  }

  /// Validates that password and confirmation match
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'validation.confirm_password_required'.tr();
    }
    if (value != password) {
      return 'validation.passwords_do_not_match'.tr();
    }
    return null;
  }

  // ==================== IBAN Validations ====================

  /// Yemen IBAN (Length 28) - Your original logic preserved
  static String? validateYEIban(String? value) {
    final iban = _clean(value);
    if (iban.isEmpty) return 'validation.iban_required'.tr();
    if (!iban.startsWith('YE') || iban.length != 28) {
      return 'validation.yemen_iban_must_be_28'.tr();
    }
    if (!RegExp(r'^YE\d{2}[A-Z0-9]{24}$').hasMatch(iban)) {
      return 'validation.invalid_iban_format'.tr();
    }
    return null;
  }

  /// KSA IBAN (Length 24)
  static String? validateKSAIban(String? value) {
    final iban = _clean(value);
    if (iban.isEmpty) return 'validation.iban_required'.tr();
    if (!iban.startsWith('SA') || iban.length != 24) {
      return 'validation.iban_invalid_ksa_length'.tr();
    }
    if (!RegExp(r'^SA\d{2}[A-Z0-9]{20}$').hasMatch(iban)) {
      return 'validation.iban_invalid_ksa_format'.tr();
    }
    return null;
  }

  /// Egypt IBAN (Length 29)
  static String? validateEgyptIban(String? value) {
    final iban = _clean(value);
    if (iban.isEmpty) return 'validation.iban_required'.tr();
    if (!iban.startsWith('EG') || iban.length != 29) {
      return 'validation.iban_invalid_egp_length'.tr();
    }
    if (!RegExp(r'^EG\d{2}\d{4}\d{4}\d{17}$').hasMatch(iban)) {
      return 'validation.iban_invalid_egp_format'.tr();
    }
    return null;
  }

  // ==================== Popular Flutter Validations ====================

  /// Checks if two fields match (Password Confirmation)
  static String? validateConfirm(
    String? value,
    String? original,
    String errorKey,
  ) {
    if (value != original) return errorKey.tr();
    return null;
  }

  /// Credit Card (Luhn check pattern)
  static String? validateCreditCard(String? value) {
    final card = _clean(value);
    if (card.isEmpty) return 'validation.card_required'.tr();
    if (!RegExp(
      r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13})$',
    ).hasMatch(card)) {
      return 'validation.card_invalid'.tr();
    }
    return null;
  }

  /// Identity Number (KSA: 10 digits, Egypt: 14 digits)
  static String? validateNationalId(String? value, {required String country}) {
    final id = _clean(value);
    if (id.isEmpty) return 'validation.id_required'.tr();

    if (country == 'SA' && !RegExp(r'^[12]\d{9}$').hasMatch(id)) {
      return 'validation.id_invalid_ksa'.tr();
    }
    if (country == 'EG' && !RegExp(r'^[23]\d{13}$').hasMatch(id)) {
      return 'validation.id_invalid_egp'.tr();
    }
    return null;
  }

  // ==================== Utilities ====================

  static String _clean(String? value) {
    return value?.replaceAll(RegExp(r'[\s-]'), '').toUpperCase() ?? '';
  }
}
