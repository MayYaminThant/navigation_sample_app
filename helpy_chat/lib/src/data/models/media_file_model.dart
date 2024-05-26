part of 'models.dart';

class MediaFileModel extends MediaFile {
  const MediaFileModel({
    int? id,
    int? candidateId,
    String? mediaType,
    String? mediaFilePath,
    int? mediaDisplayOrder,
    String? mediaCreationDateTime,
    String? mediaFileFullPath,
    String? mediaThumbnailFilepath,
  }) : super(
          id: id,
          candidateId: candidateId,
          mediaType: mediaType,
          mediaFilePath: mediaFilePath,
          mediaThumbnailFilepath:mediaThumbnailFilepath,
          mediaDisplayOrder: mediaDisplayOrder,
          mediaCreationDateTime: mediaCreationDateTime,
          mediaFileFullPath: mediaFileFullPath
        );

  factory MediaFileModel.fromJson(Map<dynamic, dynamic> map) {
    return MediaFileModel(
      id:
          map['media_id'] != null ? map['media_id'] as int : null,
      candidateId: map['user_id'] != null ? map['user_id'] as int: null,
      mediaType: map['media_type'] != null ? map['media_type'] as String: null,
      mediaFilePath: map['media_filepath'] != null ? map['media_filepath'] as String: null,
      mediaThumbnailFilepath: map['media_thumbnail_filepath'] != null ? map['media_thumbnail_filepath'] as String: null,
      mediaDisplayOrder: map['media_display_order'] != null ? map['media_display_order'] as int: null,
      mediaCreationDateTime: map['media_creation_datetime'] != null ? map['media_creation_datetime'] as String: null,
      mediaFileFullPath: map['media_file_full_path'] != null ? map['media_file_full_path'] as String: null,
    );
  }

}
