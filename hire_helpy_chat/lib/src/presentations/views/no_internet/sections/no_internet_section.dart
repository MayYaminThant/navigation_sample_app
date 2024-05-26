
part of '../../views.dart';
class NoInternetSection extends StatefulWidget {
  const NoInternetSection({super.key});

  @override
  State<NoInternetSection> createState() => _NoInternetSectionState();
}

class _NoInternetSectionState extends State<NoInternetSection> {
  @override
  Widget build(BuildContext context) {
    return _getNoInternetContainer;
  }

  Widget get _getNoInternetContainer {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/no-image-bg.png'),
              fit: BoxFit.cover)),
      child: _getNoInternetResult,
    );
  }

  Widget get _getNoInternetResult => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset('assets/images/no_wifi.png'),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'No internet connection!',
              style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Try these steps to get back online:',
                style: TextStyle(
                    color: AppColors.primaryGrey,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    height: 2),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '\u2022 Check your modem and router',
                style: TextStyle(
                    color: AppColors.primaryGrey,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    height: 2),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '\u2022 Reconnect to Wi-Fi ',
                style: TextStyle(
                    color: AppColors.primaryGrey,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    height: 2),
                textAlign: TextAlign.center,
              ),
            )
              ],
            )
          ],
        ),
      );

}