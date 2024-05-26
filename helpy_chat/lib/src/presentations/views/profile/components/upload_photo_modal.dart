// import 'dart:io';

// import 'package:dh_mobile/src/core/utils/snackbar_utils.dart';
// import 'package:dh_mobile/src/presentations/blocs/blocs.dart';
// import 'package:dh_mobile/src/presentations/values/values.dart';
// import 'package:dh_mobile/src/presentations/widgets/super_print.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:uuid/uuid.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:typed_data';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import '../../../../config/routes/routes.dart';
// import 'package:path/path.dart' as path;

// class UpdatePhotoModal extends StatefulWidget {
//   const UpdatePhotoModal({
//     super.key,
//     this.route,
//     required this.isOnlyPhoto,
//   });

//   final String? route;
//   final bool isOnlyPhoto;

//   @override
//   State<UpdatePhotoModal> createState() => _UpdatePhotoModalState();
// }

// class _UpdatePhotoModalState extends State<UpdatePhotoModal> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//         height: 177,
//         width: 262,
//         child: Column(children: [
//           const Text(
//             StringConst.updatePhotoText,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: AppColors.greyShade2,
//               fontSize: 15,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           InkWell(
//             onTap: () {
//               superPrint("${widget.route}");
//               Get.offNamed(cameraPageRoute,
//                   parameters: {"route": "${widget.route}"});
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 40,
//                     decoration: BoxDecoration(
//                         color: AppColors.primaryGrey,
//                         borderRadius: BorderRadius.circular(30)),
//                     child:
//                         Center(child: Image.asset('assets/icons/camera.png')),
//                   ),
//                   const SizedBox(
//                     width: 18,
//                   ),
//                   const Text(
//                     StringConst.cameraText,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColors.secondaryGrey,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const Divider(),
//           GestureDetector(
//             onTap: () async {
//               await _pickImage(context);
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 40,
//                     decoration: BoxDecoration(
//                         color: AppColors.primaryGrey,
//                         borderRadius: BorderRadius.circular(30)),
//                     child: Center(
//                       child: Image.asset('assets/icons/upload.png'),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 18,
//                   ),
//                   const Text(
//                     StringConst.exportFromDeviceText,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColors.secondaryGrey,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ]),
//       ),
//     );
//   }

//   Future<bool> isVideoPlayable(File videoFile) async {
//     VideoPlayerController controller = VideoPlayerController.file(videoFile);
//     bool isPlayable = false;
//     try {
//       await controller.initialize();
//       isPlayable = true;
//     } catch (e) {
//       debugPrint("Error: $e");
//     } finally {
//       await controller.dispose();
//     }
//     return isPlayable;
//   }

//   bool isMediaFile(PlatformFile file) {
//     String extension = file.extension?.toLowerCase() ?? '';
//     return extension == 'mp4' || extension == 'mov' || extension == 'avi';
//   }

//   Future<bool> isRealImage(PlatformFile file) async {
//     if (file.path == null) return false;
//     try {
//       Uint8List data = await File(file.path!).readAsBytes();
//       await FlutterImageCompress.compressWithList(data);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<void> _pickImage(BuildContext buildContext) async {
//     final ImagePicker picker = ImagePicker();
//     int maxSizeKbs = 10240;
//     final XFile? media = widget.isOnlyPhoto
//         ? await picker.pickImage(source: ImageSource.gallery)
//         : await picker.pickMedia();
//     if (media == null) return;
//     final mediaFile = File(media.path);
//     final fileSize = await mediaFile.length();
//     final fileSizeKb = fileSize / 1024;
//     if (fileSizeKb > maxSizeKbs) {
//       showErrorSnackBar('File size should be less than 10mb.');
//       return;
//     }
//     final imageExtension = path.extension(media.path);

//     /// includes the . e.g. '.png'
//     final tempPath = (await getTemporaryDirectory()).path;
//     const uuid = Uuid();
//     final newFileName = uuid.v4();
//     final renamedFile =
//         await mediaFile.copy('$tempPath/$newFileName$imageExtension');

//     if (context.mounted) {
//       final articleBloc = BlocProvider.of<ArticleBloc>(context);
//       articleBloc.tempFilesSet.add(renamedFile.path);
//       Get.offAllNamed(widget.route!);
//     }
//   }
// }
