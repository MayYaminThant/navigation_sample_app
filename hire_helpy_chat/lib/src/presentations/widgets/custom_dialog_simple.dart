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
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.greyBg,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15.0),
                        title != null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 10.0,
                                ),
                                child: Text(
                                  title!,
                                  textAlign: TextAlign.center,
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    decoration: TextDecoration.none,
                                    color: AppColors.greyShade2,
                                  ),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Text(
                            message,
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
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: negativeText != null
                              ? MainAxisAlignment.spaceAround
                              : MainAxisAlignment.center,
                          children: [
                            if (negativeText != null)
                              CustomPrimaryButton(
                                onPressed: () {
                                  if (onNegativeButtonClick == null) {
                                    Get.back();
                                    return;
                                  }
                                  onNegativeButtonClick!();
                                },
                                widthButton: 135,
                                heightButton: 47,
                                text: negativeText ?? '',
                                fontSize: 18,
                                customColor: AppColors.white,
                                textColor: AppColors.primaryColor,
                              ),
                            CustomPrimaryButton(
                              onPressed: onButtonClick,
                              widthButton: 135,
                              heightButton: 47,
                              text: positiveText,
                              fontSize: 18,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18.0,
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
