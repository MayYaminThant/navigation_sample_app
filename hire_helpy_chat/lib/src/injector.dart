import 'package:dh_employer/src/core/utils/environment_manager.dart';
import 'package:dh_employer/src/data/datasources/remote/faq_api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/remote/ads_api_service.dart';
import 'data/datasources/remote/article_api_service.dart';
import 'data/datasources/remote/candidate_api_service.dart';
import 'data/datasources/remote/connection_api_service.dart';
import 'data/datasources/remote/employer_api_service.dart';
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

  injector
      .registerSingleton<EmployerApiService>(EmployerApiService(injector()));
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
  //Employer
  injector.registerSingleton<CreateEmployerLoginUseCase>(
      CreateEmployerLoginUseCase(injector()));
  injector.registerSingleton<CreateEmployerRegisterUseCase>(
      CreateEmployerRegisterUseCase(injector()));
  injector.registerSingleton<CreateEmployerSocialLoginUseCase>(
      CreateEmployerSocialLoginUseCase(injector()));
  injector.registerSingleton<CreateEmployerSocialRegisterUseCase>(
      CreateEmployerSocialRegisterUseCase(injector()));
  injector.registerSingleton<GetEmployerLoginOutUseCase>(
      GetEmployerLoginOutUseCase(injector()));
  injector.registerSingleton<GetEmployerConfigsUseCase>(
      GetEmployerConfigsUseCase(injector()));
  injector.registerSingleton<CreateEmployerContactUsUseCase>(
      CreateEmployerContactUsUseCase(injector()));
  injector.registerSingleton<CreateEmployerAboutUseCase>(
      CreateEmployerAboutUseCase(injector()));
  injector.registerSingleton<CreateEmployerAvatarUseCase>(
      CreateEmployerAvatarUseCase(injector()));
  injector.registerSingleton<DeleteEmployerAvatarUseCase>(
      DeleteEmployerAvatarUseCase(injector()));
  injector.registerSingleton<GetEmployerProfileUseCase>(
      GetEmployerProfileUseCase(injector()));
  injector.registerSingleton<UpdateEmployerAvailabilityUseCase>(
      UpdateEmployerAvailabilityUseCase(injector()));
  injector.registerSingleton<UpdateEmployerFamilyInformationUseCase>(
      UpdateEmployerFamilyInformationUseCase(injector()));
  injector.registerSingleton<GetEmployerAvailabilityUseCase>(
      GetEmployerAvailabilityUseCase(injector()));
  injector.registerSingleton<GetEmployerStarListUseCase>(
      GetEmployerStarListUseCase(injector()));
  injector.registerSingleton<CreateEmployerStarListUseCase>(
      CreateEmployerStarListUseCase(injector()));
  injector.registerSingleton<RemoveEmployerStarListUseCase>(
      RemoveEmployerStarListUseCase(injector()));
  injector.registerSingleton<CreateEmployerForgotPasswordUseCase>(
      CreateEmployerForgotPasswordUseCase(injector()));
  injector.registerSingleton<CreateEmployerResetPasswordUseCase>(
      CreateEmployerResetPasswordUseCase(injector()));
  injector.registerSingleton<CreateEmployerSpotlightsUseCase>(
      CreateEmployerSpotlightsUseCase(injector()));
  injector.registerSingleton<CreateEmployerWorkingPreferenceUseCase>(
      CreateEmployerWorkingPreferenceUseCase(injector()));
  injector.registerSingleton<UpdateEmployerFCMUseCase>(
      UpdateEmployerFCMUseCase(injector()));
  injector.registerSingleton<GetEmployerSaveSearchUseCase>(
      GetEmployerSaveSearchUseCase(injector()));
  injector.registerSingleton<UpdateEmployerSaveSearchUseCase>(
      UpdateEmployerSaveSearchUseCase(injector()));
  injector.registerSingleton<DeleteEmployerSaveSearchUseCase>(
      DeleteEmployerSaveSearchUseCase(injector()));
  injector.registerSingleton<CreateEmployerOfferUseCase>(
      CreateEmployerOfferUseCase(injector()));
  injector.registerSingleton<CreateEmployerReviewsUseCase>(
      CreateEmployerReviewsUseCase(injector()));
  injector.registerSingleton<CreateEmployerVerificationUseCase>(
      CreateEmployerVerificationUseCase(injector()));
  injector.registerSingleton<DeleteEmployerOfferUseCase>(
      DeleteEmployerOfferUseCase(injector()));
  injector.registerSingleton<DeleteEmployerAccountUseCase>(
      DeleteEmployerAccountUseCase(injector()));
  injector.registerSingleton<DeleteEmployerProfileUseCase>(
      DeleteEmployerProfileUseCase(injector()));
  injector.registerSingleton<DeleteEmployerReviewsUseCase>(
      DeleteEmployerReviewsUseCase(injector()));
  injector.registerSingleton<GetEmployerReviewsUseCase>(
      GetEmployerReviewsUseCase(injector()));
  injector.registerSingleton<GetEmployerCoinHistoryUseCase>(
      GetEmployerCoinHistoryUseCase(injector()));
  injector.registerSingleton<GetEmployerCoinBalanceUseCase>(
      GetEmployerCoinBalanceUseCase(injector()));
  injector.registerSingleton<GetEmployerReferFriendUseCase>(
      GetEmployerReferFriendUseCase(injector()));
  injector.registerSingleton<UpdateEmployerAccountUseCase>(
      UpdateEmployerAccountUseCase(injector()));
  injector.registerSingleton<UpdateEmployerSaveSearchNotifyUseCase>(
      UpdateEmployerSaveSearchNotifyUseCase(injector()));
  injector.registerSingleton<UpdateEmployerShareableLinkUseCase>(
      UpdateEmployerShareableLinkUseCase(injector()));
  injector.registerSingleton<UpdateEmployerLanguageUseCase>(
      UpdateEmployerLanguageUseCase(injector()));
  injector.registerSingleton<GetEmployerCheckVerifiedUseCase>(
      GetEmployerCheckVerifiedUseCase(injector()));
  injector.registerSingleton<CreateEmployerHiringUseCase>(
      CreateEmployerHiringUseCase(injector()));
  injector.registerSingleton<CreateEmployerComplaintUseCase>(
      CreateEmployerComplaintUseCase(injector()));
  injector.registerSingleton<UpdateEmployerConfigsUseCase>(
      UpdateEmployerConfigsUseCase(injector()));
  injector.registerSingleton<CreateEmployerExchangeUseCase>(
      CreateEmployerExchangeUseCase(injector()));

  //Article
  injector.registerSingleton<GetArticleListUseCase>(
      GetArticleListUseCase(injector()));
  injector.registerSingleton<CreateArticleUseCase>(
      CreateArticleUseCase(injector()));

  injector.registerSingleton<GetArticleCommentUseCase>(
      GetArticleCommentUseCase(injector()));
  injector.registerSingleton<GetArticleDetailUseCase>(
      GetArticleDetailUseCase(injector()));
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
  injector
      .registerSingleton<GetNewDetailUseCase>(GetNewDetailUseCase(injector()));
  injector.registerSingleton<DeleteArticleUseCase>(
      DeleteArticleUseCase(injector()));
  injector.registerSingleton<UpdateArticleUseCase>(
      UpdateArticleUseCase(injector()));

  injector.registerSingleton<CreateArticleComplainUseCase>(
      CreateArticleComplainUseCase(injector()));
  injector.registerSingleton<CreateCommentComplainUseCase>(
      CreateCommentComplainUseCase(injector()));

  //Candidate
  injector.registerSingleton<CreateCandidateSearchUseCase>(
      CreateCandidateSearchUseCase(injector()));
  injector.registerSingleton<GetCandidateProfileUseCase>(
      GetCandidateProfileUseCase(injector()));

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

  //Faq
  injector.registerSingleton<GetFaqUseCase>(GetFaqUseCase(injector()));

  //Reward
  injector.registerSingleton<GetRewardsListUseCase>(
      GetRewardsListUseCase(injector()));
  injector.registerSingleton<GetClaimRewardUseCase>(
      GetClaimRewardUseCase(injector()));

  //Blocs
  //Employer
  injector.registerFactory<EmployerBloc>(() => EmployerBloc(
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
      ));

  injector.registerFactory<NotificationBloc>(() => NotificationBloc(
      injector(), injector(), injector(), injector(), injector()));

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
      injector()));

  injector.registerFactory<CandidateBloc>(
      () => CandidateBloc(injector(), injector()));

  injector.registerFactory<ConnectionBloc>(() => ConnectionBloc(
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector()));

  injector.registerFactory<AdsBloc>(() => AdsBloc(injector()));

  injector.registerFactory<FaqBloc>(() => FaqBloc(injector()));
  injector
      .registerFactory<RewardBloc>(() => RewardBloc(injector(), injector()));
}
