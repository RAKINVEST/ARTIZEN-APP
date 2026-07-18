import 'dart:js_interop';
import 'dart:js_interop_unsafe';

/// Web implementation of [openExternalUrl]: point the browser at [url].
///
/// Setting `window.location.href` is the most reliable way to trigger a
/// `mailto:` hand-off to the user's mail client (a new-tab `window.open`
/// often leaves a blank tab behind), and it follows `https:`/`tel:` links the
/// same way. Only the SDK's `dart:js_interop` is used, so no extra package is
/// introduced.
@JS('window')
external JSObject get _window;

void openExternalUrl(String url) {
  final location = _window.getProperty<JSObject>('location'.toJS);
  location.setProperty('href'.toJS, url.toJS);
}
