part of 'entities.dart';

// ignore: must_be_immutable
class MediaFile extends Equatable {
  final int? id;
  final int? candidateId;
  final String? mediaType;
  final String? mediaFilePath;
  final String? mediaThumbnailFilepath;
  final int? mediaDisplayOrder;
  final String? mediaCreationDateTime;
  final String? mediaFileFullPath;

  const MediaFile({
    this.id,
    this.candidateId,
    this.mediaType,
    this.mediaFilePath,
    this.mediaThumbnailFilepath,
    this.mediaDisplayOrder,
    this.mediaCreationDateTime,
    this.mediaFileFullPath,
  });

  @override
  List<Object?> get props => [
        id,
        candidateId,
        mediaType,
        mediaFilePath,
        mediaThumbnailFilepath,
        mediaDisplayOrder,
        mediaCreationDateTime,
        mediaFileFullPath
      ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "media_id": id,
        "user_id": candidateId,
        "media_type": mediaType,
        "media_filepath": mediaFilePath,
        "media_thumbnail_filepath": mediaThumbnailFilepath,
        "media_display_order": mediaDisplayOrder,
        "media_creation_datetime": mediaCreationDateTime,
        "media_file_full_path": mediaFileFullPath,
      };
}
