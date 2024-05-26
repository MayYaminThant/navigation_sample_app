// import 'package:dh_mobile/src/presentations/blocs/blocs.dart';
// import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:iconsax/iconsax.dart';

// import '../../../../core/utils/db_utils.dart';
// import '../../../values/values.dart';

// class CameraViewPage extends StatefulWidget {
//   const CameraViewPage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<CameraViewPage> createState() => _CameraViewPageState();
// }

// class _CameraViewPageState extends State<CameraViewPage> {
//   Map? candidateData;
//   final TransformationController _transformationController =
//       TransformationController();
//   String route = "";
//   bool preview = false;
//   double _scale = 1.0;
//   double _previousScale = 1.0;

//   @override
//   void initState() {
//     initialData();
//     _getCandidateData();
//     super.initState();
//   }

//   void initialData() {
//     setState(() {
//       route = Get.parameters["route"] ?? '';
//       preview = Get.parameters['preview'] == "true" ? true : false;
//     });
//   }

//   Future<void> _getCandidateData() async {
//     Box box = await Hive.openBox(DBUtils.dbName);
//     setState(() {
//       candidateData = box.get(DBUtils.candidateTableName);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final articleBloc = BlocProvider.of<ArticleBloc>(context);
//     return Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           leading: GestureDetector(
//             onTap: () => Get.back(),
//             child: const Icon(
//               Iconsax.arrow_left,
//               color: AppColors.white,
//             ),
//           ),
//           title: Text(
//             preview ? StringConst.imageText : StringConst.imagePreviewText,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//                 color: AppColors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w100),
//           ),
//         ),
//         floatingActionButton: !preview
//             ? GestureDetector(
//                 onTap: () => _saveImage(),
//                 child: const CircleAvatar(
//                   radius: 27,
//                   backgroundColor: AppColors.primaryColor,
//                   child: Icon(
//                     Iconsax.direct_right,
//                     color: Colors.white,
//                     size: 27,
//                   ),
//                 ),
//               )
//             : Container(),
//         body: GestureDetector(
//           onScaleStart: (ScaleStartDetails details) {
//             _previousScale = _scale;
//           },
//           onScaleUpdate: (ScaleUpdateDetails details) {
//             setState(() {
//               _scale = (_previousScale * details.scale).clamp(1.0, 4.0);
//               _transformationController.value = Matrix4.identity()
//                 ..scale(_scale);
//             });
//           },
//           child: InteractiveViewer(
//             transformationController: _transformationController,
//             maxScale: 4.0,
//             child: Center(
//               child: CustomImageView(
//                 image: articleBloc.tempData,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         ));
//   }

//   void _saveImage() {
//     final articleBloc = BlocProvider.of<ArticleBloc>(context);
//     articleBloc.tempFilesSet.add(articleBloc.tempData);
//     Get.offAllNamed(route);
//   }
// }
