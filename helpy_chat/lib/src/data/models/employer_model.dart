part of 'models.dart';

class EmployerModel extends Employer {
  const EmployerModel(
      {int? id,
      String? availabilityStatus,
      bool? proficientEnglish,
      bool? chineseMandarin,
      bool? bahasaMelayu,
      bool? tamil,
      bool? hokkien,
      bool? teochew,
      bool? cantonese,
      bool? bahasaIndonesian,
      bool? japanese,
      bool? korean,
      bool? french,
      bool? german,
      bool? arabic,
      String? othersSpecify,
      String? selfDesc,
      String? expectCandidate,
      String? familyStatus,
      String? specialRequestChildern,
      String? specialRequestElderly,
      String? specialRequestPet,
      List<MediaFile>? media,
      User? user,
      List<Review>? reviews,
      Offer? offer,
      })
      : super(
            id: id,
            availabilityStatus: availabilityStatus,
            languageProficientEnglish: proficientEnglish,
            languageChineseMandarin: chineseMandarin,
            languageBahasaMelayu: bahasaMelayu,
            languageTamil: tamil,
            languageHokkien: hokkien,
            languageTeochew: teochew,
            languageCantonese: cantonese,
            languageBahasaIndonesian: bahasaIndonesian,
            languageJapanese: japanese,
            languageKorean: korean,
            languageFrench: french,
            languageGerman: german,
            languageArabic: arabic,
            languageOthersSpecify: othersSpecify,
            selfDesc: selfDesc,
            expectCandidate: expectCandidate,
            familyStatus: familyStatus,
            specialRequestChildern: specialRequestChildern,
            specialRequestElderly: specialRequestElderly,
            specialRequestPet: specialRequestPet,
            media: media,
            user: user,
            reviews: reviews,
            offer: offer
            );

  factory EmployerModel.fromJson(Map<dynamic, dynamic> map) {
    return EmployerModel(
      id: map['user_id'] != null ? map['user_id'] as int : 0,
      availabilityStatus: map['availability_status'] != null
          ? map['availability_status'] as String
          : "",
      proficientEnglish: map['language_proficient_english'] != null
          ? map['language_proficient_english'] as bool
          : null,
      chineseMandarin: map['language_chinese_mandarin'] != null
          ? map['language_chinese_mandarin'] as bool
          : null,
      bahasaMelayu: map['language_bahasa_melayu'] != null
          ? map['language_bahasa_melayu'] as bool
          : null,
      tamil:
          map['language_tamil'] != null ? map['language_tamil'] as bool : null,
      hokkien: map['language_hokkien'] != null
          ? map['language_hokkien'] as bool
          : null,
      teochew: map['language_teochew'] != null
          ? map['language_teochew'] as bool
          : null,
      cantonese: map['language_cantonese'] != null
          ? map['language_cantonese'] as bool
          : null,
      bahasaIndonesian: map['language_bahasa_indonesian'] != null
          ? map['language_bahasa_indonesian'] as bool
          : null,
      japanese: map['language_japanese'] != null
          ? map['language_japanese'] as bool
          : null,
      korean: map['language_korean'] != null
          ? map['language_korean'] as bool
          : null,
      french: map['language_french'] != null
          ? map['language_french'] as bool
          : null,
      german: map['language_german'] != null
          ? map['language_german'] as bool
          : null,
      arabic: map['language_arabic'] != null
          ? map['language_arabic'] as bool
          : null,
      othersSpecify: map['language_other_specify'] as String? ?? "",
      selfDesc: map['self_desc'] as String? ?? "",
      expectCandidate: map['expect_candidate'] as String? ?? "",
      familyStatus: map['family_status'] as String? ?? '',
      specialRequestChildern: map['special_req_children'] as String? ?? "",
      specialRequestElderly: map['special_req_elderly'] as String? ?? "",
      specialRequestPet: map['special_req_pet'] as String? ?? "",
      media: map['media'] != null
          ? List<MediaFile>.from((map['media'] as List<dynamic>)
              .map((e) => MediaFileModel.fromJson(e as Map<String, dynamic>)))
          : null,
      user: map['user'] != null ? UserModel.fromJson(map['user']) : map['profile'] != null ? UserModel.fromJson(map['profile']) : null,
      reviews: map['reviews'] != null
          ? List<Review>.from((map['reviews'] as List<dynamic>)
              .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>)))
          : null,
      offer: map['offer_data'] != null
          ? OfferModel.fromJson(map['offer_data'])
          : null,
    );
  }
}
