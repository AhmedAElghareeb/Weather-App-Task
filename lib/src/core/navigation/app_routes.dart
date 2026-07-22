/// ─────────────────────────────────────────────────────────────────────────────
/// AppRoutes — Centralized route path definitions
/// ─────────────────────────────────────────────────────────────────────────────
/// All route paths are defined as static constants here for type-safe,
/// centralized navigation management. Adding a new screen requires only
/// adding a constant here and registering it in [AppRouter].
abstract class AppRoutes {
  /// Start Screens
  static const String splash = '/splash';

  /// Weather Screen — the main feature of the app
  static const String weather = '/weather';
}
