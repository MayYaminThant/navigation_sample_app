import 'dart:convert';
import 'dart:io';

import 'package:dh_employer/src/core/utils/image_utils.dart';
import 'package:dh_employer/src/core/utils/snackbar_utils.dart';
import 'package:dh_employer/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../../core/utils/db_utils.dart';
import '../../../values/values.dart';

class CameraViewPage extends StatefulWidget {
  const CameraViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CameraViewPage> createState() => _CameraViewPageState();
}

class _CameraViewPageState extends State<CameraViewPage> {
  Map? employerData;
  String? displayImagePath;
  String? originalImagePath;
  bool isPreview = false;
  String route = '';
  String type = '';
  final TransformationController _transformationController =
      TransformationController();
  bool submitLoading = false;

  Set<String> tempFiles = {};
  String title = "";
  String description = "";
  String language = "";

  _initializeData() {
    if (Get.parameters.isNotEmpty) {
      originalImagePath = Get.parameters['path'] ?? '';
      displayImagePath = originalImagePath;
      isPreview = Get.parameters['preview'].toString() == 'true';
      route = Get.parameters['route'] ?? '';
      type = Get.parameters['type'] ?? '';
      getFiles();
      title = Get.parameters['title'] ?? '';
      description = Get.parameters['description'] ?? '';
      language = Get.parameters['language'] ?? '';
    }
  }

  @override
  void initState() {
    _initializeData();
    _getEmployerData();
    super.initState();
  }

  Future<void> _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
  }

  void getFiles() {
    List<String> dataList = [];
    final String data = Get.parameters['tempFiles'] ?? "";
    if (data.isNotEmpty && data != "[]") {
      Iterable iterable = json.decode(data);
      for (var element in iterable) {
        dataList.add(element);
      }
      if (dataList.isNotEmpty) {
        tempFiles = dataList.toSet();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        title: Text(
          isPreview ? StringConst.imagePreviewText : StringConst.imageText,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
      ),
      floatingActionButton: !isPreview
          ? GestureDetector(
              onTap: _submit,
              child: CircleAvatar(
                radius: 27,
                backgroundColor: AppColors.primaryColor,
                child: submitLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Icon(
                        Iconsax.direct_right,
                        color: Colors.white,
                        size: 27,
                      ),
              ),
            )
          : Container(),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InteractiveViewer(
            transformationController: _transformationController,
            maxScale: 4.0,
            child: Center(
              child: type == 'network'
                  ? Image.network(displayImagePath!)
                  : Image.file(
                      File(displayImagePath!),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        if (!isPreview)
          Positioned(
              left: 20,
              bottom: 15,
              child: CustomOutlineButton(
                icon: const Icon(Iconsax.crop, color: Colors.black),
                customColor: Colors.white,
                textColor: Colors.black,
                text: 'Crop'.tr,
                onPressed: _cropImage,
              )),
      ]),
    );
  }

  void _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: originalImagePath!,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Photo'.tr,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop Photo'.tr,
        ),
      ],
    );
    if (croppedFile == null) return;

    setState(() {
      displayImagePath = croppedFile.path;
    });
  }

  void _addImageToTempFiles() {
    if (displayImagePath != null) {
      tempFiles.add(displayImagePath!);
    }
  }

  void _submit() async {
    if (submitLoading) return;
    setState(() {
      submitLoading = true;
    });
    final compressedFile = await compressMediaFile(File(displayImagePath!));
    if (!mounted) return;
    setState(() {
      submitLoading = false;
    });
    if (compressedFile == null) {
      Get.back();
      showErrorSnackBar('File is too large, please try again');
      return;
    }
    _saveImage(compressedFile.path);
  }

  void _saveImage(String imagePath) {
    Get.offAllNamed(route, parameters: {
      'file': imagePath,
      'tempFiles': json.encode(tempFiles.toList()),
      'title': title,
      'description': description,
      'language': language,
    });
  }
}
