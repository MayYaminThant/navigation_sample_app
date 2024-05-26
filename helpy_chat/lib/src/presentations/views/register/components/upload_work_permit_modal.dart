part of '../../views.dart';

class UploadWorkPermitModal extends StatefulWidget {
  const UploadWorkPermitModal({
    super.key,
    required this.isFront,
  });

  final bool isFront;

  @override
  State<UploadWorkPermitModal> createState() => _UploadWorkPermitModalState();
}

class _UploadWorkPermitModalState extends State<UploadWorkPermitModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            width: MediaQuery.of(context).size.width - 85,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 18,
                      ),
                      Text(
                        widget.isFront
                            ? 'Front of Work Permit'.tr
                            : 'Back of Work Permit'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.greyShade2,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Iconsax.close_circle,
                            size: 24,
                            color: AppColors.secondaryGrey,
                          ))
                    ]),
                const SizedBox(height: 12),
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      await Get.toNamed(workPermitCameraRoute,
                          arguments: widget.isFront);
                      Get.back();
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 20),
                        child: Row(children: [
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
                          Text(
                            'Camera'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.secondaryGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]))),
                const Divider(),
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      final imagePath = await _pickImage();
                      if (imagePath == null) return;
                      await Get.toNamed(workPermitSelectImageRoute, arguments: {
                        "isFront": widget.isFront,
                        "photoPath": imagePath
                      });
                      Get.back();
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 20),
                        child: Row(children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: AppColors.primaryGrey,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                                child: Image.asset('assets/icons/upload.png')),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Text(
                            'Select from Gallery'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.secondaryGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]))),
                const SizedBox(height: 2)
              ],
            )));
  }

  Future<String?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? media = await picker.pickImage(source: ImageSource.gallery);
    if (media == null) return null;
    final mediaFile = File(media.path);
    final CompressReturn compressReturn =
        await ImageUtils.compressMediaFile(mediaFile);
    if (compressReturn.file == null) {
      showErrorSnackBar("${compressReturn.message}");
      return null;
    }
    return compressReturn.file!.path;
  }
}
