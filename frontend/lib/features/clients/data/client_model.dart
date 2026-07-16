import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_model.freezed.dart';
part 'client_model.g.dart';

/// Mirrors the backend's `ClientRead` schema (`app/clients/schemas.py`)
/// field-for-field. Doubles as the domain entity for this MVP — a separate
/// "domain model" would just duplicate every field for no behavioral
/// difference, which the brief's "pas de Clean Architecture excessive"
/// rules out.
@freezed
class Client with _$Client {
  const factory Client({
    required String id,
    required String companyId,
    required String lastName,
    String? firstName,
    String? companyName,
    String? address,
    String? phone,
    String? email,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Client;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  const Client._();

  /// "Prénom Nom", falling back to the company name, for compact display
  /// (list tiles, dropdowns) where a single line is needed.
  String get displayName {
    final full = [firstName, lastName].where((part) => part != null && part.isNotEmpty).join(' ');
    if (full.isNotEmpty) return full;
    return companyName ?? 'Client sans nom';
  }
}

/// Payload for create/update — no `id`/timestamps, matching the backend's
/// `ClientCreate`/`ClientUpdate` schemas.
@freezed
class ClientInput with _$ClientInput {
  const factory ClientInput({
    required String lastName,
    String? firstName,
    String? companyName,
    String? address,
    String? phone,
    String? email,
    String? notes,
  }) = _ClientInput;

  factory ClientInput.fromJson(Map<String, dynamic> json) => _$ClientInputFromJson(json);
}
