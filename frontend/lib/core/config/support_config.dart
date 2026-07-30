import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/dio_client.dart';

/// The support/contact address, fetched from the backend's **single source**
/// (`GET /config`) so no part of the app hard-codes it. Every consumer — the
/// Paramètres tile, the legal pages (`{email}` substitution), any future e-mail
/// or contact form — reads it here. Public endpoint (works signed out, for the
/// legal pages). Cached for the session.
final supportEmailProvider = FutureProvider<String>((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get<Map<String, dynamic>>('/config');
  return response.data!['support_email'] as String;
});
