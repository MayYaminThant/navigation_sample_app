import 'package:dh_mobile/src/presentations/views/splash/sections/environment_selection_section.dart';
import 'package:dh_mobile/src/presentations/views/splash/sections/force_update_section.dart';
import 'package:dh_mobile/src/presentations/widgets/fullscreen_image_view.dart';
import 'package:get/get.dart';
import '../../presentations/views/views.dart';
import 'routes.dart';

List<GetPage<dynamic>> pages = [
  GetPage(name: rootRoute, page: () => const HomeSection()),

  GetPage(
      name: environmentSelectionRoute,
      page: () => const EnvironmentSelectionSection()),

  GetPage(name: splashPageRoute, page: () => const SplashSection()),

  GetPage(name: forceUpdateRoute, page: () => const ForceUpdateSection()),

  GetPage(name: registerPageRoute, page: () => const RegisterSection()),

  GetPage(name: verifyOTPPageRoute, page: () => const VerifyOTPSection()),

  GetPage(
      name: verifiedSuccessPageRoute,
      page: () => const VerifiedSuccessSection()),

  GetPage(name: signInPageRoute, page: () => const SignInSection()),
  GetPage(name: signInEmailPageRoute, page: () => const SignInEmailSection()),

  GetPage(name: signInPhonePageRoute, page: () => const SignInPhoneSection()),

  GetPage(name: accountCheckPageRoute, page: () => const AccountCheckSection()),

  GetPage(
      name: forgotPasswordPageRoute, page: () => const ForgotPasswordSection()),

  GetPage(name: forgotOTPPageRoute, page: () => const ForgotOTPSection()),

  GetPage(
      name: resetPasswordPageRoute, page: () => const ResetPasswordSection()),

  GetPage(
      name: recoverSuccessPageRoute,
      page: () => const RecoveredSuccessSection()),

  //Home
  GetPage(name: homePageRoute, page: () => const HomeSection()),

  //Terms, policys and EULA
  GetPage(name: termsAndPolicyRoute, page: () => const TermsSection()),

  GetPage(name: settingsSectionRoute, page: () => const SettingSection()),

  GetPage(
      name: fullscreenImageViewPageRoute,
      page: () => const FullscreenImageView()),

  GetPage(name: chatListPageRoute, page: () => const ChatListSection()),
  GetPage(name: requestChatPageRoute, page: () => const ChatRequestSection()),

  //Refers To Friends
  GetPage(
      name: refersToFriendPageRoute, page: () => const ReferFriendSection()),

  //Notification
  GetPage(name: notificationPageRoute, page: () => const NotificationSection()),

  //Non Login Info
  GetPage(name: nonLoginInfoPageRoute, page: () => const NonLoginInfoSection()),

  //Unauthenicated
  GetPage(
      name: unauthenicatedPageRoute, page: () => const UnauthenicatedSection()),

  //Installed App
  GetPage(name: installedPageRoute, page: () => const InstalledAppSection()),

  //Language And Country
  GetPage(
      name: languageCountryPageRoute,
      page: () => const LanguageCountrySection()),
  GetPage(name: countryOfWorkPageRoute, page: () => const CountryWorkSection()),
  GetPage(
      name: languageChangePageRoute, page: () => const LanguageChangeSection()),
];
