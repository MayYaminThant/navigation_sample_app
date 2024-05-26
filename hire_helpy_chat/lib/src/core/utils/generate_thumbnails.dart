import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<List<File>> generateThumbnails(List<File> mediaFiles) async {
  List<File> thumbnailFiles = [];
  for (final file in mediaFiles) {
    final thumbnailFile = await generateFileThumbnail(file);
    thumbnailFiles.add(thumbnailFile);
  }
  return thumbnailFiles;
}

Future<File> generateFileThumbnail(File mediaFile) async {
  final mimeStr = lookupMimeType(mediaFile.path);
  if (mimeStr == null) {
    return mediaFile;
  }
  final fileType = mimeStr.split('/')[0];

  if (fileType == 'video') {
    final thumbnailFileName = await VideoThumbnail.thumbnailFile(
      video: mediaFile.path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxWidth:
          1000, // specify the width of the thumbnail, let the height auto-scale to keep the source aspect ratio
      quality: 75,
    );
    if (thumbnailFileName == null) {
      return mediaFile;
    }
    return File(thumbnailFileName);
  }

  if (fileType == 'image') {
    img.Image? image = img.decodeImage(mediaFile.readAsBytesSync());
    if (image == null) {
      return mediaFile;
    }
    img.Image thumbnail = img.copyResize(image, height: 256);
    final tempPath = (await getTemporaryDirectory()).path;
    final thumbnailData = img.encodePng(thumbnail);
    const uuid = Uuid();
    final fileName = uuid.v4();
    final thumbnailFile =
        await File('$tempPath/$fileName.png').writeAsBytes(thumbnailData);
    return thumbnailFile;
  }

  return mediaFile;
}

bool isVideoFile(String fileName) {
  RegExp regExp = RegExp(
    r'\.(mp4|avi|flv|wmv|mov|mkv|webm)$',
    caseSensitive: false,
  );
  return regExp.hasMatch(fileName);
}
