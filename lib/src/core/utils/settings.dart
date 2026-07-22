import 'package:easy_localization/easy_localization.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Settings — Global application settings and utility helpers
/// ─────────────────────────────────────────────────────────────────────────────
/// Provides convenient static methods for common operations like
/// date formatting and status normalization.
abstract class Settings {
  /// Formats a [DateTime] to 'yyyy-MM-dd' string for API consumption.
  /// Returns null if the input date is null.
  static String? convertDate({required DateTime? date}) =>
      date != null ? DateFormat('yyyy-MM-dd').format(date) : null;

  /// Normalizes a status string by trimming whitespace and converting
  /// to lowercase for consistent comparison.
  static String? generateStatus(String? status) =>
      status?.trim().toLowerCase();
}
