import 'dart:io';
import 'package:dh_mobile/src/presentations/widgets/super_print.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';
import 'package:path/path.dart' as path;
import 'db_utils.dart';

class ImageUtils {
  // Photo Size Limit
  static const int photoSizeMBlimit = 10000000;
  // Video Size Limit
  static const int videoSizeMBlimit = 55000000;

  // Photo Size MAx Limit
  static const int photoSizeMBMaxlimit = 30000000;
  // Video Size Max Limit
  static const int videoSizeMBMaxlimit = 70000000;

  static final dio = Dio();

  // invalid file
  static const String fileErrorMessage = "Invalid file type";
  //
  static const String notCompressMessage = "can`t compress!";

  //over maximum file limit in upload
  static const String photoErrorMessage =
      'Photo upload size should be maximum 30 Megabytes. Please crop the photo or try another one!';
  static const String videoErrorMessage =
      'Video upload size should be maximum 70 Megabytes.';

  // over minimum file limit after compress
  static const String tooLergeImageContactUs =
      'Compressed Image size is over 3 Megabytes. Please crop the photo or try another one!';
  static const String tooLergeImage =
      'Compressed Image size is over 10 Megabytes. Please crop the photo or try another one!';
  static const String tooLergeVideo =
      'Compressed Video size is over 55 Megabytes.';

  static Future<String> _getBasePhotoUrl() async {
    return await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
  }

  static Future<List<String>> cacheS3Files(
      {required List<String> filePaths}) async {
    final List<String> localPaths = [];
    final baseUrl = await _getBasePhotoUrl();
    for (final filePath in filePaths) {
      final cachedPath = await cacheNetworkFile('$baseUrl/$filePath');
      if (cachedPath != null) {
        localPaths.add(cachedPath);
      }
    }
    return localPaths;
  }

  static Future<String?> cacheNetworkFile(String url) async {
    try {
      String filename = url.split('/').last;
      String localPath = '${(await getTemporaryDirectory()).path}/$filename';
      await dio.download(url, localPath);
      return localPath;
    } catch (e) {
      return null;
    }
  }

  static Future<CompressReturn> compressMediaFile(File? media,
      {double? contactUsSize = 0}) async {
    if (media == null) return CompressReturn(message: fileErrorMessage);
    final isVideo = isVideoFile(media);
    if (isVideo == null) return CompressReturn(message: fileErrorMessage);
    if (isVideo) {
      final compressedVideo = await compressVideo(media);
      return compressedVideo;
    }
    final CompressReturn compressedPhoto =
        await compressPhoto(media, contactUsSize: contactUsSize);
    return compressedPhoto;
  }

  static bool isValidPhotoExtension(File file) {
    String ext = path.extension(file.path).toLowerCase();
    const List<String> allowedExtensions = ['.jpg', '.jpeg', '.png', '.webp'];
    return allowedExtensions.contains(ext);
  }

  static Future<CompressReturn> compressPhoto(File photo,
      {double? contactUsSize}) async {
    final int fileSize = photo.lengthSync();
    superPrint(fileSize);
    if (fileSize > photoSizeMBMaxlimit) {
      return CompressReturn(message: photoErrorMessage);
    }
    final fileExtensionCheck = isValidPhotoExtension(photo);
    if (!fileExtensionCheck) return CompressReturn(message: fileErrorMessage);
    final compressedPath = await getUuidFilename('jpg');
    if (fileSize > photoSizeMBlimit - (contactUsSize ?? 0)) {
      final XFile? compressedFile =
          await FlutterImageCompress.compressAndGetFile(
              photo.absolute.path, compressedPath,
              minWidth: 2000, minHeight: 2000, keepExif: true);
      if (compressedFile == null) {
        return CompressReturn(message: notCompressMessage);
      }
      final int xfileSize = await compressedFile.length();
      superPrint(xfileSize);
      if (xfileSize > photoSizeMBlimit - (contactUsSize ?? 0)) {
        return CompressReturn(
            message:
                contactUsSize == null ? tooLergeImage : tooLergeImageContactUs);
      }
      return CompressReturn(file: File(compressedFile.path));
    }
    final File renamedFile = await photo.rename(compressedPath);
    return CompressReturn(file: renamedFile);
  }

  static Future<CompressReturn> compressVideo(File video) async {
    final int fileSize = await video.length();
    superPrint(fileSize, title: "vidoe length");
    if (fileSize > videoSizeMBMaxlimit) {
      return CompressReturn(message: videoErrorMessage);
    }
    if (fileSize > videoSizeMBlimit) {
      final compressedVideo = await VideoCompress.compressVideo(
        video.absolute.path,
        quality: VideoQuality.LowQuality,
        deleteOrigin: true,
      );
      if (compressedVideo == null) {
        return CompressReturn(message: notCompressMessage);
      }
      final int compressedVideoFileSize = compressedVideo.filesize ?? 0;
      superPrint(compressedVideoFileSize);
      if (compressedVideoFileSize > videoSizeMBlimit) {
        return CompressReturn(message: tooLergeVideo);
      }
      return CompressReturn(file: compressedVideo.file);
    }
    return CompressReturn(file: video);
  }

  static Future<String> getUuidFilename(String extension) async {
    final tempPath = (await getTemporaryDirectory()).path;
    const uuid = Uuid();
    final newFileName = uuid.v4();
    return '$tempPath/$newFileName.$extension';
  }

  static bool? isVideoFile(File media) {
    return isVideoFilepath(media.path);
  }

  static bool? isVideoFilepath(String path) {
    final mimeStr = lookupMimeType(path);
    if (mimeStr == null) return null;
    final fileType = mimeStr.split('/')[0];
    if (fileType == 'image') return false;
    if (fileType == 'video') return true;
    return null;
  }
}

class CompressReturn {
  final File? file;
  final String? message;

  CompressReturn({this.file, this.message});
}
