part of 'widgets.dart';

class ContinueWithWidget extends StatefulWidget {
  const ContinueWithWidget({super.key});

  @override
  State<ContinueWithWidget> createState() => _ContinueWithWidgetState();
}

class _ContinueWithWidgetState extends State<ContinueWithWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 1,
          color: AppColors.primaryGrey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            StringConst.orContinueWith,
            style: const TextStyle(color: AppColors.primaryGrey),
          ),
        ),
        Container(
          width: 70,
          height: 1,
          color: AppColors.primaryGrey,
        ),
      ],
    );
  }
}
