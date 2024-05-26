import 'dart:convert';
import 'package:dh_mobile/src/core/utils/environment_manager.dart';
import 'package:dh_mobile/src/presentations/widgets/super_print.dart';
import 'package:http/http.dart' as http;

import 'loading.dart';

enum VerificationMethod { email, phone }

class OtpVerification {
  static Future<String?> requestOtp(
      String to, int duration, VerificationMethod method) async {
    final String url = method == VerificationMethod.email
        ? '$baseUrl/candidate/request-otp'
        : '$baseUrl/candidate/request-phone-otp';
    final Map<String, dynamic> requestData = method == VerificationMethod.email
        ? {
            "email": to,
            "pin_expiry": duration,
          }
        : {"to": to, "pin_expiry": duration};

    // send request
    var response = await apiRequest(url, requestData);
    superPrint(response.body);
    Loading.cancelLoading();
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      return data['request_id'];
    } else {
      return json.decode(response.body);
    }
  }

  static Future<Map?> verifyOtp(
      String requestId, String code, VerificationMethod method) async {
    // construct request
    final String url = method == VerificationMethod.email
        ? '$baseUrl/candidate/verify-otp/$requestId'
        : '$baseUrl/candidate/verify-phone-otp/$requestId';
    final Map requestData = {
      "code": code,
      "verified_method": method == VerificationMethod.email ? "email" : "phone"
    };

    var response = await apiRequest(url, requestData);
    superPrint(response.body);
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      return data;
    } else {
      return json.decode(response.body);
    }
  }

  static Future<http.Response> apiRequest(String url, Map jsonMap) async {
    return http.post(Uri.parse(url),
        body: json.encode(jsonMap),
        headers: {"Content-Type": "application/json"},
        encoding: Encoding.getByName("utf-8"));
  }
}
