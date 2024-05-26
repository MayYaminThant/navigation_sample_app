import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static launchPhoneCall(String? number) async {
    if (!await launchUrl(
      Uri(
        scheme: 'tel',
        path: number,
      ),
    )) {
      throw 'Could not launch';
    }
  }

  static launchEmail(String? email) async {
    if (!await launchUrl(
      Uri(
        scheme: 'mailto',
        path: email,
      ),
    )) {
      throw 'Could not launch';
    }
  }

  static launchURL(String? uri) async {
    if (!await launchUrl(Uri.parse(
      uri!,
    ), mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }
}
