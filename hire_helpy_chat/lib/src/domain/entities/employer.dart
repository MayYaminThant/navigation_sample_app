part of 'entities.dart';

// ignore: must_be_immutable
class Employer extends Equatable {
  final int? id;
  final String? selfDesc;
  final String? expectCandidate;
  final String? availabilityStatus;
  final String? familyStatus;
  final String? specialRequestElderly;
  final String? specialRequestChildern;
  final String? specialRequestPet;
  final List<dynamic>? familyMembers;
  final List<MediaFile>? media;
  final User? user;
  final bool? languageProficientEnglish;
  final bool? languageChineseMandarin;
  final bool? languageBahasaMelayu;
  final bool? languageTamil;
  final bool? languageHokkien;
  final bool? languageTeochew;
  final bool? languageCantonese;
  final bool? languageBahasaIndonesian;
  final bool? languageJapanese;
  final bool? languageKorean;
  final bool? languageFrench;
  final bool? languageGerman;
  final bool? languageArabic;
  final String? languageOthersSpecify;
  //final FamilyStatus? familyStatusType;
  final int? numOfSiblings;
  final String? dateOfBirth;
  final int? profileProgressBar;
  final Offer? offer;

  const Employer({
    this.id,
    this.availabilityStatus,
    this.selfDesc,
    this.expectCandidate,
    this.familyStatus,
    this.specialRequestChildern,
    this.specialRequestElderly,
    this.specialRequestPet,
    this.familyMembers,
    this.media,
    this.user,
    this.languageProficientEnglish,
    this.languageChineseMandarin,
    this.languageBahasaMelayu,
    this.languageTamil,
    this.languageHokkien,
    this.languageTeochew,
    this.languageCantonese,
    this.languageBahasaIndonesian,
    this.languageJapanese,
    this.languageKorean,
    this.languageFrench,
    this.languageGerman,
    this.languageArabic,
    this.languageOthersSpecify,
    //this.familyStatusType,
    this.numOfSiblings,
    this.dateOfBirth,
    this.profileProgressBar,
    this.offer
  });

  @override
  List<Object?> get props => [
        id,
        availabilityStatus,
        selfDesc,
        expectCandidate,
        familyStatus,
        specialRequestChildern,
        specialRequestElderly,
        specialRequestPet,
        familyMembers,
        media,
        user,
        languageProficientEnglish,
        languageChineseMandarin,
        languageBahasaMelayu,
        languageTamil,
        languageHokkien,
        languageTeochew,
        languageCantonese,
        languageBahasaIndonesian,
        languageJapanese,
        languageKorean,
        languageFrench,
        languageGerman,
        languageArabic,
        languageOthersSpecify,
        //familyStatusType,
        numOfSiblings,
        dateOfBirth,
        availabilityStatus,
        profileProgressBar,
        offer
      ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
        "user_id": id,
        "availability_status": availabilityStatus,
        "language_proficient_english": languageProficientEnglish,
        "language_chinese_mandarin": languageChineseMandarin,
        "language_bahasa_melayu": languageBahasaMelayu,
        "language_tamil": languageTamil,
        "language_hokkien": languageHokkien,
        "language_teochew": languageTeochew,
        "language_cantonese": languageCantonese,
        "language_bahasa_indonesian": languageBahasaIndonesian,
        "language_japanese": languageJapanese,
        "language_korean": languageKorean,
        "language_arabic": languageArabic,
        "language_others_specify": languageOthersSpecify,
        "self_desc": selfDesc,
        "expect_candidate": expectCandidate,
        "family_status": familyStatus,
        "special_req_children": specialRequestChildern,
        "special_req_elderly": specialRequestElderly,
        "special_req_pet": specialRequestPet,
        //"family_status_type": familyStatusType,
        "family_members": familyMembers,
        "date_of_birth": dateOfBirth,
        "num_of_siblings": numOfSiblings,
        "profile_progress_bar": profileProgressBar,
        "offer": offer,
        "user": user
      };
}
