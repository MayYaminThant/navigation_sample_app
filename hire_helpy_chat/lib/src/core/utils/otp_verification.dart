import 'dart:convert';

import 'package:dh_employer/src/core/utils/environment_manager.dart';
import 'package:http/http.dart' as http;

import 'loading.dart';

enum VerificationMethod { email, phone }

class OtpVerification {
  static Future<String?> requestOtp(
      String to, int duration, VerificationMethod method) async {
    late Map requestData;
    late String url;

    // construct request
    if (method == VerificationMethod.email) {
      url = '$baseUrl/employer/request-otp';
      requestData = {
        "email": to,
        "pin_expiry": duration,
      };
    } else {
      url = '$baseUrl/employer/request-phone-otp';
      requestData = {"to": to, "pin_expiry": to};
    }

    // send request
    var response = await apiRequest(url, requestData);
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
    late Map requestData;
    late String url;

    // construct request
    if (method == VerificationMethod.email) {
      url = '$baseUrl/employer/verify-otp/$requestId';
      requestData  = {
        "code": code,
        "verified_method": "email"
      };
    } else {
      url = '$baseUrl/employer/verify-phone-otp/$requestId';
      requestData = {
        "code": code,
        "verified_method": "phone"
      };
    }


    var response = await apiRequest(url, requestData);

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
