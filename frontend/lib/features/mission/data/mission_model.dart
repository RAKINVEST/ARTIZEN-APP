import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission_model.freezed.dart';
part 'mission_model.g.dart';

/// Mirrors the backend's `MissionRead` (`app/mission/schemas.py`). The Mission
/// Engine owns the real intervention; this is the read projection with computed
/// progress + is_terminal, its attachments and its append-only timeline.
/// `attachments`/`timeline` are kept as dynamic lists (entries are maps).
@freezed
class Mission with _$Mission {
  const factory Mission({
    required String id,
    required String companyId,
    required String customerId,
    String? siteId,
    String? workflowInstanceId,
    required String title,
    required String status,
    required int progress,
    required bool isTerminal,
    @Default(<dynamic>[]) List<dynamic> attachments,
    @Default(<dynamic>[]) List<dynamic> timeline,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Mission;

  factory Mission.fromJson(Map<String, dynamic> json) => _$MissionFromJson(json);
}
