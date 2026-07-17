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
/// Every nullable field opts out of build.yaml's global
/// `include_if_null: false`.
///
/// That global default exists to protect *partial* updates: the backend's
/// `model_dump(exclude_unset=True)` reads an absent key as "don't touch"
/// and an explicit null as "set to null", so dropping nulls keeps an
/// untouched field untouched. But this model is not a partial update — the
/// edit form always sends every field it has, so "untouched" never
/// happens here. What does happen is an artisan clearing a wrong email:
/// the field went null, the null was dropped, the backend saw no key, and
/// the wrong email came straight back on the next load.
///
/// Sending the null is what makes clearing work, and it is exactly what
/// the artisan asked for. Every column behind these fields is nullable
/// (see `clients/models.py`), so a null is always a legal value.
///
/// Per-field rather than a class-level `@JsonSerializable`: on a freezed
/// class that generates a second `_$ClientInputFromJson` and collides with
/// freezed's own.
class ClientInput with _$ClientInput {
  const factory ClientInput({
    required String lastName,
    @JsonKey(includeIfNull: true) String? firstName,
    @JsonKey(includeIfNull: true) String? companyName,
    @JsonKey(includeIfNull: true) String? address,
    @JsonKey(includeIfNull: true) String? phone,
    @JsonKey(includeIfNull: true) String? email,
    @JsonKey(includeIfNull: true) String? notes,
  }) = _ClientInput;

  factory ClientInput.fromJson(Map<String, dynamic> json) => _$ClientInputFromJson(json);
}
