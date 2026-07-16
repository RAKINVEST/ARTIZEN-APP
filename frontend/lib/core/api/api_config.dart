/// Central place for API connection settings.
///
/// The base URL can be overridden at build/run time without touching code:
/// `flutter run --dart-define=API_BASE_URL=http://192.168.1.10:8000/api`
/// Defaults to the backend's own `docker-compose.yml` port mapping
/// (`8000:8000`) reachable at `localhost` when running Flutter web/desktop
/// on the same machine as the backend.
class ApiConfig {
  const ApiConfig._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000/api',
  );

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);
}
