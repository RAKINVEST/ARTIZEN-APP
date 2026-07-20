/// Ergonomic handling of a catalog item's estimated labour time (point #6
/// of the "Bêta Ready" brief). The backend still stores a single integer
/// number of **minutes** (`CatalogItem.estimated_duration_minutes`) — this
/// is purely a UI convenience so the artisan can enter and read the value
/// in minutes, hours or days instead of only minutes.
///
/// A "day" here means one **working day of 7 hours** (420 min), the common
/// French convention for a labour day in a quote (`35 h` week / 5). It is a
/// single named constant so it can be changed in one place if needed.
library;

enum DurationUnit {
  minutes('min', 1),
  hours('h', 60),
  days('j', 7 * 60);

  const DurationUnit(this.label, this.minutesPerUnit);

  /// Short suffix shown next to the value ("min", "h", "j").
  final String label;

  /// How many minutes one unit of this represents.
  final int minutesPerUnit;
}

/// A labour duration expressed as a value in a chosen unit, convertible to
/// and from the backend's minutes representation.
class LaborDuration {
  const LaborDuration({required this.value, required this.unit});

  /// The raw text the user typed (kept as a string so "1.5" / "1,5" round-
  /// trips through the form field unchanged).
  final String value;
  final DurationUnit unit;

  /// Converts a user-entered [value] in [unit] to whole minutes for the
  /// backend. Returns `null` when the field is empty (no estimate), and
  /// `null` when the value isn't a valid non-negative number.
  static int? toMinutes(String value, DurationUnit unit) {
    final normalized = value.trim().replaceAll(',', '.');
    if (normalized.isEmpty) return null;
    final parsed = double.tryParse(normalized);
    if (parsed == null || parsed < 0) return null;
    return (parsed * unit.minutesPerUnit).round();
  }

  /// Picks the most readable (value, unit) pair for a stored minutes count:
  /// the largest unit that divides it evenly (e.g. 420 -> "1 j", 480 ->
  /// "8 h", 90 -> "90 min"). `null` minutes -> an empty minutes field.
  static LaborDuration fromMinutes(int? minutes) {
    if (minutes == null) {
      return const LaborDuration(value: '', unit: DurationUnit.minutes);
    }
    if (minutes != 0 && minutes % DurationUnit.days.minutesPerUnit == 0) {
      return LaborDuration(
        value: (minutes ~/ DurationUnit.days.minutesPerUnit).toString(),
        unit: DurationUnit.days,
      );
    }
    if (minutes != 0 && minutes % DurationUnit.hours.minutesPerUnit == 0) {
      return LaborDuration(
        value: (minutes ~/ DurationUnit.hours.minutesPerUnit).toString(),
        unit: DurationUnit.hours,
      );
    }
    return LaborDuration(value: minutes.toString(), unit: DurationUnit.minutes);
  }
}
