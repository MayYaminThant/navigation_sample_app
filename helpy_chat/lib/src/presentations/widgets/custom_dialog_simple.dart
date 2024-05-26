part of 'widgets.dart';

class CustomDialogSimple extends StatelessWidget {
  final String? title;
  final String message;
  final String positiveText;
  final String? negativeText;

  //onButtonClick 0=Negative, 1=Positive
  final VoidCallback? onButtonClick;
  final VoidCallback? onNegativeButtonClick;

  const CustomDialogSimple({
    super.key,
    this.title,
    required this.message,
    this.negativeText,
    required this.positiveText,
    required this.onButtonClick,
    this.onNegativeButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Center(
              child: Container(
                height: 161,
                width: 327,
                decoration: const BoxDecoration(
                  color: AppColors.greyBg,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        message.tr,
                        textAlign: TextAlign.center,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.none,
                          color: AppColors.greyShade2,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: negativeText != null
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.center,
                      children: [
                        if (negativeText != null)
                          CustomPrimaryButton(
                            onPressed: () => Get.back(),
                            widthButton: 135,
                            heightButton: 47,
                            text: negativeText ?? '',
                            fontSize: 15,
                            customColor: AppColors.white,
                            textColor: AppColors.primaryColor,
                          ),
                        CustomPrimaryButton(
                          onPressed: onButtonClick,
                          widthButton: 150,
                          heightButton: 47,
                          text: positiveText,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
