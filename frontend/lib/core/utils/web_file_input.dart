/// Removes the lingering `<input type="file">` that `file_picker` leaves in the
/// DOM on the web after a pick. That leftover element overlays the FlutterView
/// and silently swallows every pointer click (scrolling still works, no error
/// is logged in release) — the classic "page frozen after choosing a file" bug.
///
/// A no-op on every non-web platform (there is no DOM). Import this file and
/// call [removeLingeringFileInputs] right after `FilePicker.platform.pickFiles`.
library;

export 'web_file_input_stub.dart'
    if (dart.library.html) 'web_file_input_web.dart';
