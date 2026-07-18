/// Opens an external URL (`mailto:`, `https:`, `tel:` …) without pulling in a
/// plugin such as `url_launcher`. The web build navigates the browser; every
/// other target (including the Dart VM that `flutter test` runs on) falls back
/// to the no-op stub, which keeps the whole app compiling everywhere.
///
/// The conditional export is the standard plugin pattern: `dart.library.js_interop`
/// is only defined when compiling for the web, so native/test builds pick the
/// stub and never see `dart:js_interop`.
library;

export 'external_link_stub.dart' if (dart.library.js_interop) 'external_link_web.dart';
