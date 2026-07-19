/// Central place for API connection settings — the single source of truth for
/// the backend URL. Every Dio client / repository resolves the base URL from
/// here, never hard-codes a host.
///
/// Defaults to the public production API (served behind Nginx at
/// `https://artizenapp.com/api`). For local development against a backend on
/// your machine, override it at build/run time WITHOUT touching this file, e.g.
/// `flutter run --dart-define=API_BASE_URL=http://ADRESSE_BACKEND:8000/api`
class ApiConfig {
  const ApiConfig._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://artizenapp.com/api',
  );

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);
}
