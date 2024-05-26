part of 'widgets.dart';

class LoadingScaffold {
  static getLoading() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            StringConst.loadingText,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
            ),
          )
        ],
      )),
    );
  }
}
