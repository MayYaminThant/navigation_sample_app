import 'dart:io';

import 'package:dh_employer/src/config/routes/router.dart';
import 'package:dh_employer/src/config/routes/routes.dart';
import 'package:dh_employer/src/config/theme/theme.dart';
import 'package:dh_employer/src/core/utils/environment_manager.dart';
import 'package:dh_employer/src/injector.dart';
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
import 'package:intl/intl.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'src/core/utils/constants.dart';
import 'src/core/utils/db_utils.dart';
import 'src/core/utils/firebase_utils.dart';
import 'src/core/utils/loading.dart';
import 'src/core/utils/string_utils.dart';
import 'src/presentations/blocs/blocs.dart';
import 'src/presentations/views/rewards/components/carousel_cubit.dart';
import 'src/translations/language_translation.dart';
import 'src/translations/locale_constant.dart';
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
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
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
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  runApp(MyApp(
    navigatorKey: navigatorKey,
  ));
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
  String basePhotoUrl = '';
  final callInvitationController = ZegoUIKitPrebuiltCallController();

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix) ?? '';
    if (data != '') {
      setState(() {
        basePhotoUrl = data;
      });
    }
  }

  void firebaseCloudMessagingListeners() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null && message.notification != null) {
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
              Get.offAllNamed(rootRoute, parameters: {'route': rootRoute});
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
      print("LOOK LOOK LOOK 2");
      print(message.data['screen']);
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
          }
        }
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _getPhotoUrl();
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
        navigatorKey: widget.navigatorKey,
        theme: lightTheme,
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
      }).onError((error) {
        print("DYNAMIC LINK ERROR");
      });
    }
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.employerTableName);
    if (data != null) {
      setState(() {
        candidateData = data;
      });

      _loginToZegoCloud();
    }
  }

  void _loginToZegoCloud() async {
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
        loginToZimKit();
      }
      uploadUserAvatar();
    } on PlatformException catch (onError) {
      print('zim error $onError');
    }
  }

  uploadUserAvatar() async {
    String photoUrl = '$basePhotoUrl/${candidateData!['avatar_s3_filepath']}';
    try {
      ZIMUserAvatarUrlUpdatedResult result =
          await ZIM.getInstance()!.updateUserAvatarUrl(photoUrl);
    } on PlatformException catch (onError) {
      print('zim avatar error $onError');
    }
  }

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
      certificateIndex: ZegoSignalingPluginMultiCertificate.firstCertificate,
      controller: callInvitationController,
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
          } else if (duration.inSeconds == minCallLength * 60) {
            _saveCallingData(data.invitees[0].id);
          }
        };

        return config;
      },
    );
  }

  loginToZimKit() async {
    await ZIMKit()
        .connectUser(
            id: candidateData!['user_id'].toString(),
            name:
                '${candidateData!['first_name']} ${candidateData!['last_name']}')
        .then((errorCode) {});
  }

  void _saveCallingData(String id) async {
    String savedKey = 'video_call_${getMonthYearFormatDate(DateTime.now())}';
    List<String> callTimeCacheDataList = await _getSavedVideoCall();
    callTimeCacheDataList.add(id);
    DBUtils.saveListData(callTimeCacheDataList, savedKey);
  }

  getMonthYearFormatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  _getSavedVideoCall() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    String savedKey = 'video_call_${getMonthYearFormatDate(DateTime.now())}';
    List<String>? callTimeCacheData = box.get(savedKey) ?? [];

    return callTimeCacheData;
  }
}
