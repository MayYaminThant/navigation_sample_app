part of 'models.dart';

class DataResponseModel {
  final Map<String, dynamic>? data;
  DataResponseModel({this.data});

  factory DataResponseModel.fromJson(Map<String, dynamic> jsonData) {
    return DataResponseModel(data: jsonData);
  }
}
