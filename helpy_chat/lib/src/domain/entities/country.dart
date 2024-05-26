part of 'entities.dart';

class Country {
  /// The name of the [Country]
  final String? name;

  /// The alpha 2 isoCode of the [Country]
  final String? alpha2Code;

  /// The dialCode of the [Country]
  final String? dialCode;

  /// The flagUri which links to the flag for the [Country] in the library assets
  final String flagUri;

  /// The nameTranslation for translation
  final Map<String, String>? nameTranslations;

  final String? currency;

  Country({
    required this.name,
    required this.alpha2Code,
    required this.dialCode,
    required this.flagUri,
    this.nameTranslations,
    this.currency
  });

  /// Convert [Countries.countryList] to [Country] model
  factory Country.fromJson(Map<dynamic, dynamic> data) {
    return Country(
      name: data['country_name'] ?? data['app_locale'],
      alpha2Code: data['iban_alpha_2_code'],
      dialCode: data['country_calling_code'].toString(),
      flagUri:
          'assets/flags/${data['iban_alpha_2_code'].toString().toLowerCase()}.png',
      currency: data['currency_code']
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Country &&
        other.alpha2Code == alpha2Code &&
        other.dialCode == dialCode;
  }

  @override
  int get hashCode => Object.hashAll([alpha2Code, dialCode]);

  @override
  String toString() => '[Country] { '
      'name: $name, '
      'alpha2: $alpha2Code, '
      'dialCode: $dialCode, '
      'flagUri: $flagUri,'
      'currency: $currency, '
      '}';
}
