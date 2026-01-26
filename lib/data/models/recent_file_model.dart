import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minipdfsign/domain/entities/recent_file.dart';

part 'recent_file_model.freezed.dart';
part 'recent_file_model.g.dart';

/// Data model for RecentFile with JSON serialization.
///
/// Uses freezed for immutability and code generation.
@freezed
class RecentFileModel with _$RecentFileModel {
  const RecentFileModel._();

  const factory RecentFileModel({
    required String path,
    required String fileName,
    required DateTime lastOpened,
    required int pageCount,
    required bool isPasswordProtected,
  }) = _RecentFileModel;

  factory RecentFileModel.fromJson(Map<String, dynamic> json) =>
      _$RecentFileModelFromJson(json);

  /// Converts to domain entity.
  RecentFile toEntity() => RecentFile(
        path: path,
        fileName: fileName,
        lastOpened: lastOpened,
        pageCount: pageCount,
        isPasswordProtected: isPasswordProtected,
      );

  /// Creates from domain entity.
  factory RecentFileModel.fromEntity(RecentFile entity) => RecentFileModel(
        path: entity.path,
        fileName: entity.fileName,
        lastOpened: entity.lastOpened,
        pageCount: entity.pageCount,
        isPasswordProtected: entity.isPasswordProtected,
      );
}
