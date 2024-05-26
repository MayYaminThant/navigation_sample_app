import 'dart:convert';
import 'dart:io';

import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/routes/routes.dart';

class UpdatePhotoModal extends StatelessWidget {
  const UpdatePhotoModal({
    super.key,
    this.route,
    required this.isOnlyPhoto,
    this.tempFiles = const {},
    this.title,
    this.description,
    this.language,
  });

  final String? route;
  final bool isOnlyPhoto;
  final Set<String> tempFiles;
  final String? title;
  final String? description;
  final String? language;

  @override
  Widget build(BuildContext context) {
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
            onTap: () {
              Get.toNamed(cameraPageRoute, parameters: {
                'route': route ?? '',
                "tempFiles": jsonEncode(tempFiles.toList()),
                'title': title ?? '',
                'description': description ?? '',
                'language': language ?? '',
                'enableVideo': isOnlyPhoto ? 'false' : ''
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: AppColors.primaryGrey,
                        borderRadius: BorderRadius.circular(30)),
                    child:
                        Center(child: Image.asset('assets/icons/camera.png')),
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
              await _pickImage(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
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
  }

  bool _isVideo(String filePath) {
    final mimeType = lookupMimeType(filePath);
    if (mimeType == null) {
      return false;
    }
    return mimeType.split('/')[0] == 'video';
  }

  Future<void> _pickImage(BuildContext buildContext) async {
    final ImagePicker picker = ImagePicker();
    final XFile? media = isOnlyPhoto
        ? await picker.pickImage(source: ImageSource.gallery)
        : await picker.pickMedia();
    if (media == null) return;
    final mediaFile = File(media.path);
    final imageExtension = path.extension(media.path);

    /// includes the . e.g. '.png'
    final tempPath = (await getTemporaryDirectory()).path;
    const uuid = Uuid();
    final newFileName = uuid.v4();
    final newFilePath = '$tempPath/$newFileName$imageExtension';
    final renamedFile = await mediaFile.copy(newFilePath);

    if (_isVideo(newFilePath)) {
      Get.toNamed(videoViewPageRoute, parameters: {
        'path': renamedFile.path,
        'preview': 'false',
        'route': route ?? '',
        'tempFiles': json.encode(tempFiles.toList()),
        'title': title ?? '',
        'description': description ?? '',
        'language': language ?? '',
      });
      return;
    }

    Get.toNamed(imageViewPageRoute, parameters: {
      'path': renamedFile.path,
      'preview': 'false',
      'route': route ?? '',
      'type': 'assets',
      'tempFiles': json.encode(tempFiles.toList()),
      'title': title ?? '',
      'description': description ?? '',
      'language': language ?? '',
    });
  }
}
