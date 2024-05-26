import 'package:dh_mobile/src/core/utils/environment_manager.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/remote/ads_api_service.dart';
import 'data/datasources/remote/article_api_service.dart';
import 'data/datasources/remote/candidate_api_service.dart';
import 'data/datasources/remote/connection_api_service.dart';
import 'data/datasources/remote/employer_api_service.dart';
import 'data/datasources/remote/faq_api_service.dart';
import 'data/datasources/remote/notification_api_service.dart';
import 'data/datasources/remote/rewards_api_service.dart';
import 'data/repositories/repositories_impl.dart';
import 'domain/repositories/repositories.dart';
import 'domain/usecases/usecases.dart';
import 'presentations/blocs/blocs.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: baseUrl)));

  //Dependencies
  injector
      .registerSingleton<CandidateApiService>(CandidateApiService(injector()));
  injector.registerSingleton<CandidateRepository>(
      CandidateRepositoryImpl(injector()));

  injector.registerSingleton<ArticleApiSerice>(ArticleApiSerice(injector()));
  injector
      .registerSingleton<ArticleRepository>(ArticleRepositoryImpl(injector()));

  injector.registerSingleton<EmployerApiSerice>(EmployerApiSerice(injector()));
  injector.registerSingleton<EmployerRepository>(
      EmployerRepositoryImpl(injector()));

  injector.registerSingleton<NotificationApiService>(
      NotificationApiService(injector()));
  injector.registerSingleton<NotificationRepository>(
      NotificationRepositoryImpl(injector()));

  injector.registerSingleton<ConnectionApiService>(
      ConnectionApiService(injector()));
  injector.registerSingleton<ConnectionRepository>(
      ConnectionRepositoryImpl(injector()));

  injector.registerSingleton<AdsApiService>(AdsApiService(injector()));
  injector.registerSingleton<AdsRepository>(AdsRepositoryImpl(injector()));

  injector.registerSingleton<FaqApiSerice>(FaqApiSerice(injector()));
  injector.registerSingleton<FaqsRepository>(FaqRepositoryImpl(injector()));

  injector.registerSingleton<RewardApiSerice>(RewardApiSerice(injector()));
  injector
      .registerSingleton<RewardsRepository>(RewardsRepositoryImpl(injector()));

  //Usecases
  //Candidate
  injector.registerSingleton<CreateCandidateLoginUseCase>(
      CreateCandidateLoginUseCase(injector()));
  injector.registerSingleton<CreateCandidateRegisterUseCase>(
      CreateCandidateRegisterUseCase(injector()));
  injector.registerSingleton<CreateCandidateSocialLoginUseCase>(
      CreateCandidateSocialLoginUseCase(injector()));
  injector.registerSingleton<CreateCandidateSocialRegisterUseCase>(
      CreateCandidateSocialRegisterUseCase(injector()));
  injector.registerSingleton<GetCandidateLoginOutUseCase>(
      GetCandidateLoginOutUseCase(injector()));
  injector.registerSingleton<GetCandidateConfigsUseCase>(
      GetCandidateConfigsUseCase(injector()));
  injector.registerSingleton<GetCandidateCountriesUseCase>(
      GetCandidateCountriesUseCase(injector()));
  injector.registerSingleton<GetCandidateGendersUseCase>(
      GetCandidateGendersUseCase(injector()));
  injector.registerSingleton<GetCandidateLanguageTypesUseCase>(
      GetCandidateLanguageTypesUseCase(injector()));
  injector.registerSingleton<GetCandidateReligionsUseCase>(
      GetCandidateReligionsUseCase(injector()));
  injector.registerSingleton<CreateCandidateContactUsUseCase>(
      CreateCandidateContactUsUseCase(injector()));
  injector.registerSingleton<CreateCandidateAboutUseCase>(
      CreateCandidateAboutUseCase(injector()));
  injector.registerSingleton<CreateCandidateEmploymentUseCase>(
      CreateCandidateEmploymentUseCase(injector()));
  injector.registerSingleton<CreateCandidateAvatarUseCase>(
      CreateCandidateAvatarUseCase(injector()));
  injector.registerSingleton<DeleteCandidateEmploymentUseCase>(
      DeleteCandidateEmploymentUseCase(injector()));
  injector.registerSingleton<DeleteCandidateAvatarUseCase>(
      DeleteCandidateAvatarUseCase(injector()));
  injector.registerSingleton<GetCandidateEmploymentsUseCase>(
      GetCandidateEmploymentsUseCase(injector()));
  injector.registerSingleton<GetCandidateProfileUseCase>(
      GetCandidateProfileUseCase(injector()));
  injector.registerSingleton<UpdateCandidateAvailabilityUseCase>(
      UpdateCandidateAvailabilityUseCase(injector()));
  injector.registerSingleton<UpdateCandidateEmploymentUseCase>(
      UpdateCandidateEmploymentUseCase(injector()));
  injector.registerSingleton<UpdateCandidateFamilyInformationUseCase>(
      UpdateCandidateFamilyInformationUseCase(injector()));
  injector.registerSingleton<UpdateCandidateSkillQualificationUseCase>(
      UpdateCandidateSkillQualificationUseCase(injector()));
  injector.registerSingleton<GetCandidateAvailabilityUseCase>(
      GetCandidateAvailabilityUseCase(injector()));
  injector.registerSingleton<GetCandidateStarListUseCase>(
      GetCandidateStarListUseCase(injector()));
  injector.registerSingleton<CreateCandidateStarListUseCase>(
      CreateCandidateStarListUseCase(injector()));
  injector.registerSingleton<RemoveCandidateStarListUseCase>(
      RemoveCandidateStarListUseCase(injector()));
  injector.registerSingleton<CreateCandidateForgotPasswordUseCase>(
      CreateCandidateForgotPasswordUseCase(injector()));
  injector.registerSingleton<CreateCandidateResetPasswordUseCase>(
      CreateCandidateResetPasswordUseCase(injector()));
  injector.registerSingleton<CreateCandidateSpotlightsUseCase>(
      CreateCandidateSpotlightsUseCase(injector()));
  injector.registerSingleton<CreateCandidateWorkingPreferenceUseCase>(
      CreateCandidateWorkingPreferenceUseCase(injector()));
  injector.registerSingleton<UpdateCandidateFCMUseCase>(
      UpdateCandidateFCMUseCase(injector()));
  injector.registerSingleton<GetCandidateSaveSearchUseCase>(
      GetCandidateSaveSearchUseCase(injector()));
  injector.registerSingleton<UpdateCandidateSaveSearchUseCase>(
      UpdateCandidateSaveSearchUseCase(injector()));
  injector.registerSingleton<DeleteCandidateSaveSearchUseCase>(
      DeleteCandidateSaveSearchUseCase(injector()));
  injector.registerSingleton<CreateCandidateBigDataUseCase>(
      CreateCandidateBigDataUseCase(injector()));
  injector.registerSingleton<CreateCandidateReviewUseCase>(
      CreateCandidateReviewUseCase(injector()));
  injector.registerSingleton<CreateCandidateVerificationUseCase>(
      CreateCandidateVerificationUseCase(injector()));
  injector.registerSingleton<DeleteCandidateBigDataUseCase>(
      DeleteCandidateBigDataUseCase(injector()));
  injector.registerSingleton<DeleteCandidateAccountUseCase>(
      DeleteCandidateAccountUseCase(injector()));
  injector.registerSingleton<DeleteCandidateProfileUseCase>(
      DeleteCandidateProfileUseCase(injector()));
  injector.registerSingleton<DeleteCandidateReviewUseCase>(
      DeleteCandidateReviewUseCase(injector()));
  injector.registerSingleton<GetCandidateReviewUseCase>(
      GetCandidateReviewUseCase(injector()));
  injector.registerSingleton<GetCandidateCoinHistoryUseCase>(
      GetCandidateCoinHistoryUseCase(injector()));
  injector.registerSingleton<GetCandidateCoinBalanceUseCase>(
      GetCandidateCoinBalanceUseCase(injector()));
  injector.registerSingleton<GetCandidateReferFriendUseCase>(
      GetCandidateReferFriendUseCase(injector()));
  injector.registerSingleton<UpdateCandidateAccountUseCase>(
      UpdateCandidateAccountUseCase(injector()));
  injector.registerSingleton<CreateCandidateEmploymentSortUseCase>(
      CreateCandidateEmploymentSortUseCase(injector()));
  injector.registerSingleton<UpdateCandidateSaveSearchNotifyUseCase>(
      UpdateCandidateSaveSearchNotifyUseCase(injector()));
  injector.registerSingleton<UpdateCandidateShareableLinkUseCase>(
      UpdateCandidateShareableLinkUseCase(injector()));
  injector.registerSingleton<GetCandidateCheckVerifiedUseCase>(
      GetCandidateCheckVerifiedUseCase(injector()));
  injector.registerSingleton<CreateCandidateWorkPermitUseCase>(
      CreateCandidateWorkPermitUseCase(injector()));
  injector.registerSingleton<CreateCandidateComplaintUseCase>(
      CreateCandidateComplaintUseCase(injector()));
  injector.registerSingleton<UpdateCandidateConfigsUseCase>(
      UpdateCandidateConfigsUseCase(injector()));

  //Article
  injector.registerSingleton<GetArticleListUseCase>(
      GetArticleListUseCase(injector()));
  injector.registerSingleton<CreateArticleUseCase>(
      CreateArticleUseCase(injector()));
  injector.registerSingleton<GetArticleDetailUseCase>(
      GetArticleDetailUseCase(injector()));
  injector.registerSingleton<GetArticleCommentUseCase>(
      GetArticleCommentUseCase(injector()));
  injector.registerSingleton<CreateArticleCommentUseCase>(
      CreateArticleCommentUseCase(injector()));
  injector.registerSingleton<UpdateArticleCommentUseCase>(
      UpdateArticleCommentUseCase(injector()));
  injector.registerSingleton<ReplyArticleCommentUseCase>(
      ReplyArticleCommentUseCase(injector()));
  injector.registerSingleton<DeleteArticleCommentUseCase>(
      DeleteArticleCommentUseCase(injector()));
  injector.registerSingleton<CreateUpvoteArticleUseCase>(
      CreateUpvoteArticleUseCase(injector()));
  injector.registerSingleton<CreateDownvoteArticleUseCase>(
      CreateDownvoteArticleUseCase(injector()));
  injector.registerSingleton<GetNewListUseCase>(GetNewListUseCase(injector()));
  injector.registerSingleton<CreateArticleComplainUseCase>(
      CreateArticleComplainUseCase(injector()));
  injector.registerSingleton<CreateCommentComplainUseCase>(
      CreateCommentComplainUseCase(injector()));
  injector
      .registerSingleton<GetNewDetailUseCase>(GetNewDetailUseCase(injector()));
  injector.registerSingleton<CreateCandidateExchangeUseCase>(
      CreateCandidateExchangeUseCase(injector()));
  injector.registerSingleton<CreateCandidateOfferActionUseCase>(
      CreateCandidateOfferActionUseCase(injector()));
  injector.registerSingleton<DeleteArticleUseCase>(
      DeleteArticleUseCase(injector()));
  injector.registerSingleton<UpdateArticleUseCase>(
      UpdateArticleUseCase(injector()));

  //Employer Search
  injector.registerSingleton<CreateEmployerSearchUseCase>(
      CreateEmployerSearchUseCase(injector()));
  injector.registerSingleton<GetEmployerProfileUseCase>(
      GetEmployerProfileUseCase(injector()));

  //Notifications
  injector.registerSingleton<GetNotificationsUseCase>(
      GetNotificationsUseCase(injector()));
  injector.registerSingleton<CreateNotificationReadUseCase>(
      CreateNotificationReadUseCase(injector()));
  injector.registerSingleton<CreateNotificationUnReadUseCase>(
      CreateNotificationUnReadUseCase(injector()));
  injector.registerSingleton<DeleteNotificationUseCase>(
      DeleteNotificationUseCase(injector()));
  injector.registerSingleton<DeleteAllNotificationUseCase>(
      DeleteAllNotificationUseCase(injector()));

  //Connections
  injector.registerSingleton<GetMyConnectionRequestUseCase>(
      GetMyConnectionRequestUseCase(injector()));
  injector.registerSingleton<GetIncomingConnectionRequestUseCase>(
      GetIncomingConnectionRequestUseCase(injector()));
  injector.registerSingleton<CreateSendConnectionUseCase>(
      CreateSendConnectionUseCase(injector()));
  injector.registerSingleton<CreateAcceptConnectionUseCase>(
      CreateAcceptConnectionUseCase(injector()));
  injector.registerSingleton<CreateRejectConnectionUseCase>(
      CreateRejectConnectionUseCase(injector()));
  injector.registerSingleton<DeleteMyConnectionRequestUseCase>(
      DeleteMyConnectionRequestUseCase(injector()));
  injector.registerSingleton<GetConnectionListUseCase>(
      GetConnectionListUseCase(injector()));
  injector.registerSingleton<DeleteConnectionLinkUseCase>(
      DeleteConnectionLinkUseCase(injector()));

  //Ads
  injector.registerSingleton<GetAdsListUseCase>(GetAdsListUseCase(injector()));
  injector.registerSingleton<GetAdsCountUseCase>(GetAdsCountUseCase(injector()));
  //Faq
  injector.registerSingleton<GetFaqUseCase>(GetFaqUseCase(injector()));

  //Reward
  injector.registerSingleton<GetRewardsListUseCase>(
      GetRewardsListUseCase(injector()));
  injector.registerSingleton<GetClaimRewardUseCase>(
      GetClaimRewardUseCase(injector()));

  //Blocs
  injector.registerFactory<CandidateBloc>(() => CandidateBloc(
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector()));

  injector.registerFactory<NotificationBloc>(() => NotificationBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<ArticleBloc>(() => ArticleBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<EmployerBloc>(
      () => EmployerBloc(injector(), injector()));

  injector.registerFactory<ConnectionBloc>(() => ConnectionBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<AdsBloc>(() => AdsBloc(injector(), injector()));

  injector.registerFactory<FaqBloc>(() => FaqBloc(injector()));
  injector
      .registerFactory<RewardBloc>(() => RewardBloc(injector(), injector()));
}
