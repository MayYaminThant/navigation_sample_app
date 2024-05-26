import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

import 'db_utils.dart';

final dio = Dio();

Future<String> _getBasePhotoUrl() async {
  return await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
}

Future<List<String>> cacheS3Files({required List<String> filePaths}) async {
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

Future<String?> cacheNetworkFile(String url) async {
  try {
    String filename = url
        .split('/')
        .last;
    String localPath = '${(await getTemporaryDirectory()).path}/$filename';
    await dio.download(url, localPath);
    return localPath;
  } catch (e) {
    return null;
  }
}

Future<File?> compressMediaFile(File? media) async {
  const maxVideoFileSize = 10 * 1024 * 1024;
  const maxPhotoFileSize = 3 * 1024 * 1024;
  if (media == null) return null;
  final isVideo = isVideoFile(media);
  if (isVideo == null) return null;
  if (isVideo) {
    final compressedVideo = await compressVideo(media);
    if (compressedVideo == null ||
        compressedVideo.lengthSync() > maxVideoFileSize) return null;
    return compressedVideo;
  }
  final compressedPhoto = await compressPhoto(media);
  if (compressedPhoto == null ||
      compressedPhoto.lengthSync() > maxPhotoFileSize) return null;
  return compressedPhoto;
}

Future<File?> compressPhoto(File photo) async {
  final compressedPath = await getUuidFilename('jpg');
  final compressedFile = await FlutterImageCompress.compressAndGetFile(
      photo.absolute.path, compressedPath,
      minWidth: 2000, minHeight: 2000, keepExif: true);
  if (compressedFile == null) return null;
  return File(compressedFile.path);
}

Future<File?> compressVideo(File video) async {
  final compressedVideo = await VideoCompress.compressVideo(
    video.absolute.path,
    quality: VideoQuality.Res1280x720Quality,
    deleteOrigin: true,
  );
  if (compressedVideo == null) return null;
  return compressedVideo.file;
}

Future<String> getUuidFilename(String extension) async {
  final tempPath = (await getTemporaryDirectory()).path;
  const uuid = Uuid();
  final newFileName = uuid.v4();
  return '$tempPath/$newFileName.$extension';
}

bool? isVideoFile(File media) {
  return isVideoFilepath(media.path);
}

bool? isVideoFilepath(String path) {
  final mimeStr = lookupMimeType(path);
  if (mimeStr == null) return null;
  final fileType = mimeStr.split('/')[0];
  if (fileType == 'image') return false;
  if (fileType == 'video') return true;
  return null;
}
