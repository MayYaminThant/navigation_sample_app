import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> launchPhoneCall(String? number) async {
    final bool lnchUrl = await launchUrl(
      Uri(
        scheme: 'tel',
        path: number,
      ),
    );
    if (!lnchUrl) {
      throw 'Could not launch';
    }
  }

  static Future<void> launchEmail(String? email) async {
    final bool lnchUrl = await launchUrl(
      Uri(
        scheme: 'mailto',
        path: email,
      ),
    );
    if (!lnchUrl) {
      throw 'Could not launch';
    }
  }

  static Future<void> launchURL(String? uri) async {
    final bool lnchUrl = await launchUrl(
        Uri.parse(
          uri!,
        ),
        mode: LaunchMode.externalApplication);
    if (!lnchUrl) {
      throw Exception('Could not launch $uri');
    }
  }
}
