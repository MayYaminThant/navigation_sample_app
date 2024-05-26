part of 'models.dart';

class CoinHistoryModel extends CoinHistory {
  const CoinHistoryModel({
    final int? id,
    final String? date,
    final int? userId,
    final String? transactionType,
    final String? transactionDetail,
    final String? subTitle,
    final String? description,
    final int? debit,
    final int? credit,
  }) : super(
            id: id,
            date: date,
            userId: userId,
            transactionType: transactionType,
            transactionDetail: transactionDetail,
            subTitle: subTitle,
            description: description,
            debit: debit,
            credit: credit);

  factory CoinHistoryModel.fromJson(Map<String, dynamic> map) {
    String subTitle = "";
    String? refereeName =
        map['reference_detail_display']['referee_name'] != null
            ? map['reference_detail_display']['referee_name'] as String
            : null;
    String refereeCountryCallingCode = map['reference_detail_display']
            ['referee_country_calling_code']
        .toString();
    String refereePhoneNumber =
        map['reference_detail_display']['referee_phone_number'].toString();
    String? desc = map['reference_detail_display']['desc'] != null
        ? map['reference_detail_display']['desc'] as String
        : null;
    int? countryCallingCode =
        map['reference_detail_display']['country_calling_code'] != null
            ? map['reference_detail_display']['country_calling_code'] as int
            : null;
    int? phoneNumber = map['reference_detail_display']['phone_number'] != null
        ? map['reference_detail_display']['phone_number'] as int
        : null;
    subTitle = refereeCountryCallingCode == "null" ||
            refereePhoneNumber == "null"
        ? countryCallingCode == null || phoneNumber == null
            ? refereeName ??
                (desc ??
                    "${map['transaction_detail_int']['work_permit_status']}")
            : "+$countryCallingCode $phoneNumber"
        : "+$refereeCountryCallingCode $refereePhoneNumber";
    return CoinHistoryModel(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      date: map['date'] != null ? map['date'] as String : null,
      transactionType: map['transaction_type'] != null
          ? map['transaction_type'] as String
          : null,
      transactionDetail: map['reference_detail_display']['title'] != null
          ? map['reference_detail_display']['title'] as String
          : null,
      subTitle: subTitle,
      description: map['reference_detail_display']?['desc'] as String?,
      debit: map['debit'] != null ? map['debit'] as int : 0,
      credit: map['credit'] != null ? map['credit'] as int : 0,
    );
  }

  String formatISBN(String isbn) {
    String cleanISBN = isbn.replaceAll(RegExp(r'[-\s]'), '');
    if (cleanISBN.isNotEmpty) {
      List<String> groups = [];
      for (int i = 0; i < cleanISBN.length; i += 3) {
        groups.add(cleanISBN.substring(i, i + 3));
      }
      String formattedISBN = groups.join('-');
      return formattedISBN;
    }
    return '';
  }
}
