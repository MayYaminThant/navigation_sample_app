part of 'models.dart';

class EmployerModel extends Employer {
  const EmployerModel({
    int? id,
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
    List<dynamic>? familyMembers,
    List<MediaFile>? media,
    User? user,
    int? numOfSiblings,
    String? countryOfResidence,
    String? dateOfBirth,
    int? profileProgressBar,
  }) : super(
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
            familyMembers: familyMembers,
            media: media,
            user: user,
            // familyStatusType: familyStatus,
            numOfSiblings: numOfSiblings,
            dateOfBirth: dateOfBirth,
            profileProgressBar: profileProgressBar);

  factory EmployerModel.fromJson(Map<dynamic, dynamic> map) {
    return EmployerModel(
      id: map['user_id'] != null ? map['user_id'] as int : 0,
      availabilityStatus: map['availability_status'] != null
          ? map['availability_status'] as String
          : "",
      proficientEnglish: map['language_proficient_english'] as bool? ?? false,
      chineseMandarin: map['language_chinese_mandarin'] as bool? ?? false,
      bahasaMelayu: map['language_bahasa_melayu'] as bool? ?? false,
      tamil: map['language_tamil'] as bool? ?? false,
      hokkien: map['language_hokkien'] as bool? ?? false,
      teochew: map['language_teochew'] as bool? ?? false,
      cantonese: map['language_cantonese'] as bool? ?? false,
      bahasaIndonesian: map['language_bahasa_indonesian'] as bool? ?? false,
      japanese: map['language_japanese'] as bool? ?? false,
      korean: map['language_korean'] as bool? ?? false,
      french: map['language_french'] as bool? ?? false,
      german: map['language_german'] as bool? ?? false,
      arabic: map['language_arabic'] as bool? ?? false,
      othersSpecify: map['language_other_specify'] as String? ?? "",
      selfDesc: map['self_desc'] as String? ?? "",
      expectCandidate: map['expect_candidate'] as String? ?? "",
      familyStatus: map['family_status'] as String? ?? '',
      specialRequestChildern: map['special_req_children'] as String? ?? "",
      specialRequestElderly: map['special_req_elderly'] as String? ?? "",
      specialRequestPet: map['special_req_pet'] as String? ?? "",
      familyMembers: map['family_members'] != null
          ? map['family_members'] as List<dynamic>
          : null,
      media: map['media'] != null
          ? List<MediaFile>.from((map['media'] as List<dynamic>)
              .map((e) => MediaFileModel.fromJson(e as Map<dynamic, dynamic>)))
          : null,
      user: map['user'] != null ? UserModel.fromJson(map['user']) : map['profile'] != null ? UserModel.fromJson(map['profile']): null,
      // familyStatus: map['family_status_type'] != null
      //     ? FamilyStatusModel.fromJson(map['family_status_type'])
      //     : null,
      numOfSiblings:
          map['num_of_siblings'] != null ? map['num_of_siblings'] as int : null,
      dateOfBirth:
          map['date_of_birth'] != null ? map['date_of_birth'] as String : null,
      profileProgressBar: map['profile_progress_bar'] != null
          ? map['profile_progress_bar'] as int
          : null,
    );
  }
}
