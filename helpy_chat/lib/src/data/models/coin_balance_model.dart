import 'dart:convert';

class CoinBalanceModel {
    final int? data;
    final String? message;

    CoinBalanceModel({
        this.data,
        this.message,
    });

    factory CoinBalanceModel.fromJson(String str) => CoinBalanceModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CoinBalanceModel.fromMap(Map<String, dynamic> json) => CoinBalanceModel(
        data: json["data"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "data": data,
        "message": message,
    };
}
