import 'dart:convert';

import 'package:dh_employer/src/core/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'loading.dart';

class Vonage {

  // v1 api
  static Future<String?> createVonageOTP(
      String toValue, String channel, int time) async {
    final url =
        'https://api.nexmo.com/verify/json?api_key=$kVonageApiKey&api_secret=$kVonageApiSecret&number=$toValue&brand=PHLUID&code_length=6';
    var response = await getRequest(url);
    Loading.cancelLoading();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map data = jsonDecode(response.body);
      return data['request_id'];
    } else {
      return response.body;
    }
  }

  static Future<Map?> verifyVonageOTP(String requestId, String code) async {
    final url ='https://api.nexmo.com/verify/check/json?api_key=$kVonageApiKey&api_secret=$kVonageApiSecret&request_id=$requestId&code=$code';
    var response = await getRequest(url);
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      return data;
    } else {
      return json.decode(response.body);
    }
  }


  // v2 api
  // static Future<String?> createVonageOTP(
  //     String toValue, String channel, int time) async {
  //   const url =
  //       '$kVonageUrl/verify/?api_key=$kVonageApiKey&api_secret=$kVonageApiSecret';
  //   Map map = {
  //     "brand": kVonageBrandName,
  //     "code_length": 6,
  //     "channel_timeout": time,
  //     "workflow": [
  //       {"channel": channel, "to": toValue}
  //     ]
  //   };
  //   var response = await apiRequest(url, map);
  //   Loading.cancelLoading();
  //   if (response.statusCode == 202) {
  //     Map data = jsonDecode(response.body);
  //     return data['request_id'];
  //   } else {
  //     return response.body;
  //   }
  // }
  //
  // static Future<Map?> verifyVonageOTP(String requestId, String code) async {
  //   final url =
  //       '$kVonageUrl/verify/$requestId?api_key=$kVonageApiKey&api_secret=$kVonageApiSecret';
  //   Map map = {"code": code};
  //   var response = await apiRequest(url, map);
  //   if (response.statusCode == 200) {
  //     Map data = jsonDecode(response.body);
  //
  //     return data;
  //   } else {
  //     return json.decode(response.body);
  //   }
  // }

  static Future<http.Response> apiRequest(String url, Map jsonMap) async {
    return http.post(Uri.parse(url),
        body: json.encode(jsonMap),
        headers: {"Content-Type": "application/json"},
        encoding: Encoding.getByName("utf-8"));
  }



  static Future<http.Response> getRequest(String url) async {
    return http.get(Uri.parse(url));
  }
}
