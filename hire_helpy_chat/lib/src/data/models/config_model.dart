part of 'models.dart';

class ConfigModel extends Config {
  const ConfigModel({
    String? name,
    String? value,
  }) : super(
    name: name,
    value: value
        );

  factory ConfigModel.fromJson(Map<dynamic, dynamic> map) {
    return ConfigModel(
      name: map['config_name'] != null ? map['config_name'] as String: null,
      value: map['value'] != null ? map['value'] as String: null,
    );
  }

}
