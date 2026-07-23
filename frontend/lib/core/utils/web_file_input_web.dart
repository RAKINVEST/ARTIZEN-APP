// dart:html is deprecated but is the simplest always-available way to reach the
// DOM on Flutter web; this file is only ever compiled for the web target.
// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'dart:html' as html;

/// Delete any `<input type="file">` still hanging in the DOM after a file pick.
/// `file_picker` appends one and does not always remove it; left behind, it
/// covers the page and eats all clicks. Snapshot the list first (it can be
/// live) then remove each element.
void removeLingeringFileInputs() {
  final inputs = html.document.querySelectorAll('input[type="file"]').toList();
  for (final node in inputs) {
    node.remove();
  }
}
