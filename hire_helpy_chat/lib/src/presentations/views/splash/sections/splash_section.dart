part of '../../views.dart';

class SplashSection extends StatefulWidget {
  const SplashSection({super.key});

  @override
  State<SplashSection> createState() => _SplashSectionState();
}

class _SplashSectionState extends State<SplashSection> {
  bool isDataCalling = false;
  bool isHaveShortLink = false;
  String? timeStamp;
  Map? configs;
  String? country, language;

  @override
  void initState() {
    _getSaveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getIntroScaffold;
  }

  Widget get _getIntroScaffold {
    return BlocConsumer<EmployerBloc, EmployerState>(
      builder: (_, state) {
        return Scaffold(body: _getIntroContainer);
      },
      listener: (_, state) async {
        if (state is EmployerConfigsSuccess) {
          if (state.data.data!['data'] != null && timeStamp != null) {
            if (state.data.data!['data'].length != 0) {
              List<String> keyList = state.data.data!['data'] == null ||
                      state.data.data!['data'].isEmpty
                  ? []
                  : state.data.data!['data'].keys.toList();

              for (int i = 0; i < keyList.length; i++) {
                configs!['data'][keyList[i]] =
                    state.data.data!['data'][keyList[i]];
              }
              var encodeKeyJson = json.encode(configs);
              var decodeKeyJson = json.decode(encodeKeyJson);
              await DBUtils.saveConfigsData(decodeKeyJson, 'configs');
              _updateConfigState();
            }

            if (await VersionHelper.shouldForceUpdate()) {
              Get.offAndToNamed(forceUpdateRoute);
              return;
            }

            await handleDynamicLinks();
            if (isHaveShortLink && Get.currentRoute == splashPageRoute) return;

            if (country == null && language == null) {
              Get.offAllNamed(languageCountryPageRoute);
            } else {
              Get.offAllNamed(rootRoute);
            }
          } else {
            _updateConfigState();
            await DBUtils.saveConfigsData(state.data.data, 'configs');
            await handleDynamicLinks();

            if (await VersionHelper.shouldForceUpdate()) {
              Get.offAndToNamed(forceUpdateRoute);
              return;
            }

            if (isHaveShortLink && Get.currentRoute == splashPageRoute) return;
            Get.offAllNamed(languageCountryPageRoute);
          }
        }

        if (state is EmployerConfigsFail) {
          superPrint('data ${state.message}');
          _showRetryAlert();
        }
      },
    );
  }

  //Stack with background image
  Widget get _getIntroContainer {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/image-bg.png'),
                  fit: BoxFit.cover)),
          child: _getLogo,
        ),
      ],
    );
  }

  //Phluid Logo with titles
  Widget get _getLogo {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.46,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: SizedBox(
            height: 142,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          StringConst.introTitle,
          style: TextStyle(
              color: AppColors.primaryGrey,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  /// display an error dialog when [EmployerConfigsFail]
  /// with a button to retry calling the [_getSaveData] function
  /// and retry fetching the employee config data
  void _showRetryAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Error getting app configuration. Please check your internet connection and try again.'),
          actions: [
            TextButton(
              child: const Text('Retry Now'),
              onPressed: () {
                Navigator.pop(context);
                _getSaveData();
              },
            ),
          ],
        );
      },
    );
  }

  _getSaveData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    timeStamp = box.get(DBUtils.lastTimeStamp);
    configs = box.get('configs');
    country = box.get(DBUtils.country);
    language = box.get(DBUtils.language);
    _requestEmployerConfigs();
  }

  //Employer Configs
  _requestEmployerConfigs() async {
    final bool refreshConfig = shouldForceRefreshConfig() || await VersionHelper.shouldRefreshConfig();
    if (refreshConfig) {
      await DBUtils.clearData(DBUtils.lastTimeStamp);
      await DBUtils.clearData(DBUtils.dhConfig);
    }
    _setDataCalling(true);
    if (!mounted) return;
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    String? time = timeStamp != null
        ? DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.parse(timeStamp!))
        : null;
    EmployerConfigsRequestParams params = refreshConfig
        ? EmployerConfigsRequestParams()
        : EmployerConfigsRequestParams(lastTimestamp: time);
    employerBloc.add(EmployerConfigsRequested(params: params));
  }

  _setDataCalling(value) {
    if (mounted) {
      setState(() {
        isDataCalling = value;
      });
    }
  }

  /// handle dyanmic links for onboarding customer & employee
  Future<void> handleDynamicLinks() async {
    FirebaseDynamicLinks firebaseDynamicLinks = FirebaseDynamicLinks.instance;
    final data = await firebaseDynamicLinks.getInitialLink();
    if (data != null) {
      final Uri deeplink = data.link;
      setState(() => isHaveShortLink = true);
      goToRegisterPage(deeplink.toString());
    }
    firebaseDynamicLinks.onLink.listen((dynamicLinkData) {
      setState(() => isHaveShortLink = true);
      goToRegisterPage(dynamicLinkData.link.toString());
    }).onError((error) {});
  }

  void _updateConfigState() async {
    String time = DateFormat("yyyy-MM-dd HH:mm:ss").format(
      DateTime.now().toUtc(),
    );
    DBUtils.saveString(time, DBUtils.lastTimeStamp);
    VersionHelper.storeCurrentConfigDetails();
  }
}
