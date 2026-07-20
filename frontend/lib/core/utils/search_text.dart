/// Text normalization for the app's "smart search": an artisan typing
/// `chauff` must find *Chauffe-eau*, *Chauffage* and *Chauffe-eau Atlantic*,
/// and typing `evacuation` must find *Évacuation* — so matching is
/// case-insensitive **and** accent-insensitive.
///
/// Dart has no built-in Unicode folding, so the accented characters that
/// actually occur in a French catalog are folded explicitly.
const Map<String, String> _fold = {
  'à': 'a', 'á': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'å': 'a',
  'ç': 'c',
  'è': 'e', 'é': 'e', 'ê': 'e', 'ë': 'e',
  'ì': 'i', 'í': 'i', 'î': 'i', 'ï': 'i',
  'ñ': 'n',
  'ò': 'o', 'ó': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o',
  'ù': 'u', 'ú': 'u', 'û': 'u', 'ü': 'u',
  'ý': 'y', 'ÿ': 'y',
  'œ': 'oe', 'æ': 'ae',
  '’': "'", '‘': "'",
};

/// Lowercases [input] and strips French accents, so it can be compared with
/// another normalized string via `contains`.
String normalizeForSearch(String input) {
  final buffer = StringBuffer();
  for (final rune in input.toLowerCase().runes) {
    final character = String.fromCharCode(rune);
    buffer.write(_fold[character] ?? character);
  }
  return buffer.toString();
}

/// True when [haystack] contains [normalizedQuery] once both are folded.
/// [normalizedQuery] is expected to already be normalized, so a search over
/// a long list doesn't re-normalize the query for every candidate.
bool matchesQuery(String haystack, String normalizedQuery) {
  if (normalizedQuery.isEmpty) return true;
  return normalizeForSearch(haystack).contains(normalizedQuery);
}
