import 'dart:async';

import 'package:flutter/foundation.dart';

/// Coalesces a burst of calls into a single one, fired [delay] after the
/// last call. Used by search fields so a query is sent once the artisan
/// stops typing — one request after the burst, not one per keystroke.
///
/// Lives in `core/` because every searchable list (clients, catalog, the
/// quote-form pickers) needs the same behaviour.
class Debouncer {
  Debouncer([this.delay = const Duration(milliseconds: 300)]);

  final Duration delay;
  Timer? _timer;

  /// Schedules [action], cancelling any call still pending from a previous
  /// [run]. Only the last one within [delay] survives.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Drops any pending call without running it. Idempotent, and the
  /// debouncer stays usable afterwards — a later [run] schedules anew.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }
}
