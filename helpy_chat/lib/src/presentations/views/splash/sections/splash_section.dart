part of '../../views.dart';

class SplashSection extends StatefulWidget {
  const SplashSection({super.key});

  @override
  State<SplashSection> createState() => _SplashSectionState();
}

class _SplashSectionState extends State<SplashSection> {
  int duration = 3000;
  bool isHaveShortLink = false;
  String? timeStamp;
  Map? configs;
  String? country, language;

  @override
  void initState() {
    _ensureLanguage();
    _getSaveData();
    super.initState();
  }

  void _ensureLanguage() {
    if (!LanguageUtils.englishOnly) return;
    LanguageUtils.changeLanguage('default'); // force change to english
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
              'Error loading app. Please check your internet connection and try again.'),
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

  Future<void> _getSaveData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      timeStamp = box.get(DBUtils.lastTimeStamp);
      configs = box.get('configs');
      country = box.get(DBUtils.country);
      language = box.get(DBUtils.language);
    });
    _requestCandidateConfigs();
  }

  @override
  Widget build(BuildContext context) {
    return _getIntroScaffold;
  }

  Widget get _getIntroScaffold {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return Scaffold(
        body: _getIntroContainer,
      );
    }, listener: (_, state) async {
      if (state is CandidateConfigsSuccess) {
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
            superPrint(decodeKeyJson);
            DBUtils.saveConfigsData(decodeKeyJson, 'configs');
            _updateConfigState();
          }

          if (await VersionHelper.shouldForceUpdate()) {
            Get.offAndToNamed(forceUpdateRoute);
            return;
          }

          handleDynamicLinks(true);
          if (isHaveShortLink && Get.currentRoute == splashPageRoute) return;
          if (country == null && language == null) {
            Get.offAllNamed(languageCountryPageRoute);
          } else {
            Get.offAllNamed(rootRoute);
          }
        } else {
          _updateConfigState();
          DBUtils.saveConfigsData(state.data.data, 'configs');
          handleDynamicLinks(true);

          if (await VersionHelper.shouldForceUpdate()) {
            Get.offAndToNamed(forceUpdateRoute);
            return;
          }

          if (isHaveShortLink && Get.currentRoute == splashPageRoute) return;
          Get.offAllNamed(languageCountryPageRoute);
        }
      }
      if (state is CandidateConfigsFail) {
        _showRetryAlert();
        superPrint('data ${state.message}');
      }
    });
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

  //Candidate Configs
  void _requestCandidateConfigs() async {
    final bool refreshConfig = shouldForceRefreshConfig() || await VersionHelper.shouldRefreshConfig();
    if (refreshConfig) {
      await DBUtils.clearData(DBUtils.lastTimeStamp);
      await DBUtils.clearData(DBUtils.dhConfig);
    }
    final DateTime? parseDateTime =
        timeStamp == null ? null : DateTime.tryParse(timeStamp!);
    String? time = parseDateTime != null
        ? DateFormat("yyyy-MM-dd HH:mm:ss").format(parseDateTime)
        : null;
    if (!mounted) return;
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateConfigsRequestParams params = refreshConfig
        ? CandidateConfigsRequestParams()
        : CandidateConfigsRequestParams(lastTimestamp: time);
    candidateBloc.add(CandidateConfigsRequested(params: params));
  }

  //handle dyanmic links for onboarding customer & employee
  Future<void> handleDynamicLinks(bool isResume) async {
    FirebaseDynamicLinks firebaseDynamicLinks = FirebaseDynamicLinks.instance;
    final data = await firebaseDynamicLinks.getInitialLink();
    if (data != null) {
      final Uri deeplink = data.link;
      if (mounted) {
        setState(() => isHaveShortLink = true);
      }
      goToRegisterPage("$deeplink");
    }
    firebaseDynamicLinks.onLink.listen((dynamicLinkData) {
      if (mounted) {
        setState(() => isHaveShortLink = true);
      }
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
