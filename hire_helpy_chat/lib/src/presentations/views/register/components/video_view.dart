import 'dart:convert';
import 'dart:io';

import 'package:dh_employer/src/core/utils/image_utils.dart';
import 'package:dh_employer/src/core/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/utils/db_utils.dart';
import '../../../values/values.dart';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({
    Key? key,
  }) : super(key: key);

  @override
  _VideoViewPageState createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  VideoPlayerController? _controller;
  Map? candidateData;
  String? path;
  bool isPreview = false;
  String route = '';

  Set<String> tempFiles = {};
  String title = "";
  String description = "";
  String language = "";
  bool submitLoading = false;

  @override
  void initState() {
    _initializeData();
    _getCandidateData();
    super.initState();
    if (isPreview) {
      // ignore: deprecated_member_use
      _controller = VideoPlayerController.network(path!)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    } else {
      _controller = VideoPlayerController.file(File(path!))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }
  }

  _initializeData() {
    if (Get.parameters.isNotEmpty) {
      path = Get.parameters['path'] ?? '';
      isPreview = Get.parameters['preview'].toString() == 'true';
      route = Get.parameters['route'] ?? '';
      getFiles(path);
      title = Get.parameters['title'] ?? '';
      description = Get.parameters['description'] ?? '';
      language = Get.parameters['language'] ?? '';
    }
  }

  void getFiles(String? fileString) {
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

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.employerTableName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        title: Text(
          isPreview ? StringConst.videoText : StringConst.videoPreviewText,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: !isPreview
          ? GestureDetector(
              onTap: _submit,
              child: CircleAvatar(
                radius: 27,
                backgroundColor: AppColors.primaryColor,
                child: submitLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(
                        Iconsax.direct_right,
                        color: Colors.white,
                        size: 27,
                      ),
              ),
            )
          : Container(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: _controller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    )
                  : Container(),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _controller!.value.isPlaying
                        ? _controller!.pause()
                        : _controller!.play();
                  });
                },
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    _controller!.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (submitLoading) return;
    setState(() {
      submitLoading = true;
    });
    final compressedFile = await compressMediaFile(File(path!));
    if (!mounted) return;
    setState(() {
      submitLoading = false;
    });
    if (compressedFile == null) {
      Get.back();
      showErrorSnackBar('File is too large, please try again');
      return;
    }
    print("TEMP FILES");
    print(json.encode(tempFiles.toList()));
    _saveVideo(compressedFile.path);
  }

  _saveVideo(String videoPath) => Get.offAllNamed(route, parameters: {
        'file': videoPath,
        "tempFiles": json.encode(tempFiles.toList()),
        'title': title,
        'description': description,
        'language': language,
      });
}
