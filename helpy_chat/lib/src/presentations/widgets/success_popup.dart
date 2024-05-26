part of 'widgets.dart';


class SuccessPopup extends StatelessWidget {
  const SuccessPopup(
      {super.key,
      required this.title,
      required this.message});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return _getSuccessContainer(context);
  }

  Widget _getSuccessContainer(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: Icon(
                    Iconsax.tick_circle5,
                    size: 60,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: TextStyle(
                color: AppColors.black.withOpacity(0.5),
                fontSize: 18,
                fontWeight: FontWeight.w700
              ),
              textAlign: TextAlign.center,
              
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: const TextStyle(
                color: AppColors.primaryGrey,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
