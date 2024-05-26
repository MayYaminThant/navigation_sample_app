import 'dart:async';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:dh_mobile/src/core/utils/image_utils.dart';
import 'package:dh_mobile/src/core/utils/snackbar_utils.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/widgets/upload_media_camera.dart';
import 'package:dh_mobile/src/presentations/widgets/upload_preview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class UploadMedia {
  static Future<bool> isVideoPlayable(File videoFile) async {
    try {
      final controller = VideoPlayerController.file(videoFile);
      await controller.initialize();
      await controller.dispose();
      return true;
    } catch (_) {
      return false;
    }
  }

  static bool isMediaFile(PlatformFile file) =>
      ['mp4', 'mov', 'avi'].contains(file.extension?.toLowerCase());

  static Future<bool> isRealImage(PlatformFile file) async {
    if (file.path == null) return false;
    try {
      await FlutterImageCompress.compressWithList(
          await File(file.path!).readAsBytes());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<PlatformFile> convertToPlatformFile(XFile xFile) async {
    String path = xFile.path;
    String fileName = path.split('/').last;
    int fileSize = await File(path).length();
    PlatformFile platformFile = PlatformFile(
      name: fileName,
      size: fileSize,
      path: path,
      bytes: await xFile.readAsBytes(),
    );
    return platformFile;
  }

  static Future<File?> _pickImage(BuildContext ctx,
      {required bool isOnlyPhoto, required bool isContactUs}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? media = isOnlyPhoto
        ? await picker.pickImage(source: ImageSource.gallery)
        : await picker.pickMedia();
    if (media == null) {
      return null;
    }
    if (!isOnlyPhoto) {
      final int fileSize = await media.length();
      if (fileSize > ImageUtils.videoSizeMBMaxlimit) {
        showErrorSnackBar(ImageUtils.videoErrorMessage);
        return null;
      }
    }
    // final PlatformFile platFormFile = await convertToPlatformFile(media);
    // final bool isVideo = isMediaFile(platFormFile);
    // final bool correctData = isVideo
    //     ? await isVideoPlayable(File(media.path))
    //     : await isRealImage(platFormFile);
    // if (!correctData) {
    //   showErrorSnackBar('Invalid media!');
    //   return null;
    // }
    final imageExtension = path.extension(media.path);
    final tempPath = (await getTemporaryDirectory()).path;
    const uuid = Uuid();
    final newFileName = uuid.v4();
    final mediaFile = File(media.path);
    final renamedFile =
        await mediaFile.copy('$tempPath/$newFileName$imageExtension');

    if (ctx.mounted) {
      final confirmedFile = await openUploadPreview(
          context: ctx,
          file: renamedFile,
          isPreview: false,
          isVideo: isVideoFile(renamedFile),
          isContactUs: isContactUs);
      return confirmedFile;
    }
    return null;
  }

  static bool isVideoFile(File media) {
    return isVideoFilepath(media.path);
  }

  static bool isVideoFilepath(String path) {
    final mimeStr = lookupMimeType(path);
    if (mimeStr == null) return false;
    final fileType = mimeStr.split('/')[0];
    if (fileType == 'image') return false;
    if (fileType == 'video') return true;
    return false;
  }

  static Future<File?> openUploadAvatarCamera(BuildContext context,
      {required bool isOnlyPhoto, required bool isContactUs}) async {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UploadMediaCamera(
        isOnlyPhoto: isOnlyPhoto,
        isContactUs: isContactUs,
      ),
    ));
  }

  static Future<File?> openUploadPreview(
      {required BuildContext context,
      required File file,
      required bool isPreview,
      required bool isVideo,
      required bool isContactUs}) async {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UploadPreview(
        originalFile: file,
        preview: isPreview,
        isVideo: isVideo,
        isContactUs: isContactUs,
      ),
    ));
  }

  static Future<File?> uploadMediaData(BuildContext ctx,
      {required bool isOnlyPhoto, bool isContactUs = false}) async {
    Completer<File?> completer = Completer<File?>();
    await showDialog(
        context: ctx,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              height: 177,
              width: 262,
              child: Column(children: [
                const Text(
                  StringConst.updatePhotoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.greyShade2,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.pop(ctx);
                    final File? data = await openUploadAvatarCamera(context,
                        isOnlyPhoto: isOnlyPhoto, isContactUs: isContactUs);
                    if (data != null) {
                      completer.complete(data);
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColors.primaryGrey,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Image.asset('assets/icons/camera.png')),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        const Text(
                          StringConst.cameraText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(ctx);
                    final File? data = await _pickImage(ctx,
                        isOnlyPhoto: isOnlyPhoto, isContactUs: isContactUs);
                    if (data != null) {
                      completer.complete(data);
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColors.primaryGrey,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Image.asset('assets/icons/upload.png'),
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        const Text(
                          StringConst.exportFromDeviceText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          );
        });
    return completer.future;
  }
}
