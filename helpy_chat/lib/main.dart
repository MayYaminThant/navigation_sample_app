import 'dart:developer';
import 'dart:io';
import 'package:dh_mobile/src/config/routes/router.dart';
import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/config/theme/theme.dart';
import 'package:dh_mobile/src/core/utils/environment_manager.dart';
import 'package:dh_mobile/src/injector.dart';
import 'package:dh_mobile/src/presentations/widgets/super_print.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:zego_zpns/zego_zpns.dart';
import 'src/core/utils/constants.dart';
import 'src/core/utils/db_utils.dart';
import 'src/core/utils/firebase_utils.dart';
import 'src/core/utils/loading.dart';
import 'src/core/utils/string_utils.dart';
import 'src/core/utils/zegocloud.dart';
import 'src/presentations/blocs/blocs.dart';
import 'src/presentations/views/rewards/components/carousel_cubit.dart';
import 'src/translations/language_translation.dart';
import 'src/translations/locale_constant.dart';
import "package:get/get_navigation/src/routes/transitions_type.dart"
    as transition_type;
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class MyHttpOverrides extends HttpOverrides {
  // ignore: annotate_overrides
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

Future<void> main() async {
  final ImagePickerPlatform imagePickerImplementation =
      ImagePickerPlatform.instance;
  if (imagePickerImplementation is ImagePickerAndroid) {
    imagePickerImplementation.useAndroidPhotoPicker = true;
  }
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();

  ZIMKit().init(
    appID: kZegoAppId, // your appid
    appSign: kZegoAppSign, // your appSign
  );

  await initializeDependencies();
  final directory = await DBUtils.createFolder();
  Hive.init(directory.path);
  HttpOverrides.global = MyHttpOverrides();
  Loading.confligLogin();
  final navigatorKey = GlobalKey<NavigatorState>();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  initializeZegoCongs();
  runApp(MyApp(navigatorKey: navigatorKey));
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().initLog().then((value) {
    ///  Call the `useSystemCallingUI` method
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp(navigatorKey: navigatorKey));
  });
}

initializeZegoCongs() {
  ZPNs.getInstance().applyNotificationPermission();
  ZPNsEventHandlerManager.loadingEventHandler();
  ZPNsConfig zpnsConfig = ZPNsConfig();
  zpnsConfig.enableHWPush = true;
  zpnsConfig.enableFCMPush = true;
  zpnsConfig.enableOppoPush = true;
  zpnsConfig.enableMiPush = true;
  zpnsConfig.enableVivoPush = true;
  ZPNs.setPushConfig(zpnsConfig);
  ZPNs.getInstance().registerPush();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.navigatorKey});

  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String initialRoute = currentEnvironment == Environment.moderator ? environmentSelectionRoute : splashPageRoute;
  Map? candidateData;

  final callInvitationController = ZegoUIKitPrebuiltCallController();

  void firebaseCloudMessagingListeners() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null && message.notification != null) {
        superPrint('message ${message.data}');
        if (message.data['screen'] != null) {
          switch (message.data['screen']) {
            case 'A40':
              Get.offAllNamed(phluidCoinsPageRoute);
              break;

            case 'A56':
              Get.offAllNamed(requestChatPageRoute,
                  parameters: {'route': rootRoute});
              break;

            case 'A26':
              Get.offAllNamed(articlesAndEventsDetailPageRoute,
                  parameters: {'id': message.data['id']});
              break;

            case 'A54':
              Get.offAllNamed(chatListPageRoute,
                  parameters: {'route': rootRoute});
              break;

            case 'notification2':
              Get.offAllNamed(rootRoute, parameters: {
                'dialog': "true",
                'employer_id': message.data["employer_id"],
                'notificationId': message.data["notificationId"],
                'currency': message.data["currency"],
                'expiry': message.data["expiry"],
                'salary': message.data["salary"]
              });
              break;

            default:
              Get.offAllNamed(signInPageRoute);
              break;
          }
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(onDone: () {
      //showSuccessSnackbar(context, 'onMessageOpenedApp success');
    }, (RemoteMessage message) {
      if (message.notification != null) {
        if (message.data['screen'] != null) {
          switch (message.data['screen']) {
            case 'A40':
              Get.offAllNamed(phluidCoinsPageRoute);
              break;

            case 'A56':
              Get.offAllNamed(requestChatPageRoute,
                  parameters: {'route': rootRoute});
              break;

            case 'A26':
              Get.offAllNamed(articlesAndEventsDetailPageRoute,
                  parameters: {'id': message.data['id']});
              break;

            case 'A54':
              Get.offAllNamed(chatListPageRoute,
                  parameters: {'route': rootRoute});
              break;

            case 'notification2':
              Get.offAllNamed(rootRoute, parameters: {
                'dialog': "true",
                'employer_id': message.data["employer_id"],
                'notificationId': message.data["notificationId"],
                'currency': message.data["currency"],
                'expiry': message.data["expiry"],
                'salary': message.data["salary"]
              });
              break;
          }
        }
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _getCandidateData();
    firebaseCloudMessagingListeners();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      handleDynamicLinks(true);
    }
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        Get.updateLocale(locale);
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider<CandidateBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<NotificationBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<ArticleBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<EmployerBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<ConnectionBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<AdsBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<FaqBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<RewardBloc>(
          create: (_) => injector(),
        ),
        BlocProvider<CarouselCubit>(
          create: (_) => CarouselCubit(),
        )
      ],
      child: GetMaterialApp(
        defaultTransition: transition_type.Transition.noTransition,
        navigatorKey: widget.navigatorKey,
        theme: lightTheme,
        darkTheme: lightTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        getPages: pages,
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaleFactor.clamp(0.8, 1);
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaleFactor: scale.toDouble()),
              child: EasyLoading.init()(context, child));
        },
        translations: LanguageTranslations(),
        locale: Get.locale,
        fallbackLocale: const Locale('en', 'US'),
      ),
    );
  }

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  //handle dyanmic links for onboarding customer & employee
  void handleDynamicLinks(bool isResume) async {
    if (isResume) {
      dynamicLinks.onLink.listen((dynamicLinkData) {
        setState(() {
          initialRoute = registerPageRoute;
        });
        Future.delayed(Duration(seconds: isResume ? 0 : 3), () {
          goToRegisterPage(dynamicLinkData.link.toString());
        });
      }).onError((error) {});
    }
  }

  //Routing Firebase ShortLink
  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.candidateTableName);
    if (data != null) {
      setState(() {
        candidateData = data;
      });

      await _loginToZegoCloud();
    }
  }

  Future<void> _loginToZegoCloud() async {
    try {
      ZIMAppConfig appConfig = ZIMAppConfig();
      appConfig.appID = kZegoAppId;
      appConfig.appSign = kZegoAppSign;
      ZIM.create(appConfig);
      ZIMUserInfo userInfo = ZIMUserInfo();

      userInfo.userID = candidateData!['user_id'].toString();
      userInfo.userName = StringUtils.getFullName(
          candidateData!['first_name'] ?? '',
          candidateData!['last_name'] ?? '');

      await ZIM.getInstance()!.login(userInfo, '');

      if (mounted) {
        onUserLogin(candidateData!['user_id'].toString(),
            '${candidateData!['first_name']} ${candidateData!['last_name']}');
        await loginToZimKit();
      }
      //  await uploadUserAvatar();
    } on PlatformException catch (onError) {
      log('zim error $onError');
    }
  }

  // Future<void> uploadUserAvatar() async {
  // String photoUrl = '$basePhotoUrl/${candidateData!['avatar_s3_filepath']}';
  // try {
  //   ZIMUserAvatarUrlUpdatedResult result =
  //       await ZIM.getInstance()!.updateUserAvatarUrl(photoUrl);
  // } on PlatformException catch (onError) {
  //   log('zim avatar error $onError');
  // }
  // }

  void onUserLogin(String id, String name) {
    /// 2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: kZegoAppId,
      // your appid
      appSign: kZegoAppSign,
      userID: id,
      userName: name,
      iOSNotificationConfig: ZegoIOSNotificationConfig(
        isSandboxEnvironment: true,
      ),
      androidNotificationConfig:
          ZegoAndroidNotificationConfig(channelID: 'zegouikit_call'),
      certificateIndex: ZegoSignalingPluginMultiCertificate.firstCertificate,
      controller: callInvitationController,

      events: ZegoUIKitPrebuiltCallInvitationEvents(
        onIncomingCallReceived:
            (callID, caller, callType, callees, customData) {},
      ),
      notifyWhenAppRunningInBackgroundOrQuit: true,
      plugins: [ZegoUIKitSignalingPlugin()],
      requireConfig: (ZegoCallInvitationData data) {
        var config = ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall();

        // Modify your custom configurations here.
        config.durationConfig.isVisible = true;
        config.durationConfig.onDurationUpdate = (Duration duration) async {
          int maxCallLength =
              await DBUtils.getKeyDataList('MAX_CALL_TIME_LENGTH');
          int minCallLength =
              await DBUtils.getKeyDataList('MIN_CALL_TIME_LENGTH');

          if (duration.inSeconds >= maxCallLength * 60) {
            callInvitationController
                .hangUp(widget.navigatorKey!.currentState!.context);
          } else if (duration.inSeconds == minCallLength * 60) {}
        };

        return config;
      },
    );
  }

  Future<void> loginToZimKit() async {
    await ZIMKit()
        .connectUser(
            id: candidateData!['user_id'].toString(),
            name:
                '${candidateData!['first_name']} ${candidateData!['last_name']}')
        .then((errorCode) {});
  }
}
