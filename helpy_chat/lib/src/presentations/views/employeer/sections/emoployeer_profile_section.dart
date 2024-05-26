part of '../../views.dart';

class EmployeerProfileSection extends StatefulWidget {
  const EmployeerProfileSection({super.key});

  @override
  State<EmployeerProfileSection> createState() =>
      _EmployeerProfileSectionState();
}

class _EmployeerProfileSectionState extends State<EmployeerProfileSection> {
  Employer? employer;
  Map? candidateData;
  bool isShowConnect = false;
  String route = '';
  int _currentPage = 0;
  late PageController _pageController = PageController(keepPage: false);
  List<Employer> employerList = [];

  @override
  void initState() {
    _initializeDatas();
    _getCandidateData();
    super.initState();
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    candidateData = box.get(DBUtils.candidateTableName);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      availableBack: isShowConnect ? false : true,
      onWillPop: () async {
        isShowConnect ? _showLetChat() : null;
        return isShowConnect ? false : true;
      },
      scaffold: BlocConsumer<EmployerBloc, EmployerState>(
        builder: (_, state) {
          return employerList.isEmpty
              ? LoadingScaffold.getLoading()
              : _getEmployeerProfileScaffold;
        },
        listener: (_, state) {
          if (state is EmployerPublicProfileSuccess) {
            if (state.employerData.data != null) {
              employer =
                  EmployerModel.fromJson(state.employerData.data!['data']);
              setState(() {
                employerList = [employer!];
              });
            }
          }

          if (state is EmployerPublicProfileFail) {
            if (state.message != '') {
              showErrorSnackBar(state.message);
            }
          }
        },
      ),
    );
  }

  Scaffold get _getEmployeerProfileScaffold {
    return Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                pageSnapping: true,
                physics:
                    isShowConnect ? const NeverScrollableScrollPhysics() : null,
                children: [
                  ...employerList.map(
                    (e) => _buildEmployerProfileContainer(e),
                  ),
                  const ProfilDeskSection()
                ],
              )),
          isShowConnect
              ? GestureDetector(
                  onTap: () => _showLetChat(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.3),
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ))
              : Container()
        ],
      ),
      bottomNavigationBar: isShowConnect && employerList.length > 1
          ? Container(
              color: AppColors.primaryColor,
              height: 70,
              child: GestureDetector(
                onTap: () => _removeFromList(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Iconsax.trash,
                      size: 24,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      StringConst.removeFromStackText,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white),
                    ),
                  ],
                ),
              ),
            )
          : PageViewIndicator(
              currentPage: _currentPage,
              pageCount: employerList.length + 1,
            ),
    );
  }

  AppBar get _getAppBar => isShowConnect
      ? AppBar(
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false,
          title: BlocConsumer<k_connection_bloc.ConnectionBloc,
              k_connection_bloc.ConnectionState>(builder: (_, state) {
            return GestureDetector(
              onTap: () {
                _checkValidation();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.message,
                    size: 24,
                    color: AppColors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    StringConst.letChatText.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white),
                  ),
                ],
              ),
            );
          }, listener: (_, state) {
            if (state is k_connection_bloc.ConnectionSendRequestLoading) {}
            if (state is k_connection_bloc.ConnectionSendRequestSuccess) {
              if (state.connectionData.data != null) {
                showInfoModal(
                    title: 'You have successfully sent a chat request.',
                    message: 'You can check it on the chat page.',
                    type: 'success');
                setState(() {
                  isShowConnect = false;
                });
              }
            }
            if (state is k_connection_bloc.ConnectionSendRequestFail) {
              if (state.message != '') {
                setState(() {
                  isShowConnect = false;
                });
              }
            }
          }),
          elevation: 0.0,
          titleSpacing: 0.0,
          centerTitle: true,
        )
      : AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => route != '' ? Get.offAllNamed(route) : Get.back(),
            child: const Icon(
              Iconsax.arrow_left,
              color: AppColors.white,
            ),
          ),
          leadingWidth: 52,
          title: Text(
            StringConst.employeerProfile.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w100),
          ),
          elevation: 0.0,
          titleSpacing: 0.0,
          centerTitle: true,
          actions: const [],
        );

  Widget _buildEmployerProfileContainer(Employer data) {
    return Column(
      children: [
        Expanded(
          child: EmployeerProfileItem(
            employer: data,
            onChatPressed: () => _showLetChat(),
            isStarList: false,
            isBottomBar: true,
          ),
        ),
      ],
    );
  }

  void _initializeDatas() {
    if (Get.parameters.isNotEmpty) {
      int employerId = int.parse(Get.parameters['id'].toString());
      route = Get.parameters['route'] ?? '';
      //superPrint('data ${json.decode(Get.parameters['list'].toString())}');
      employerList = Get.parameters['list'] != null
          ? List<Employer>.from(json
              .decode(Get.parameters['list'].toString())
              ?.map((p) => EmployerModel.fromJson(p)))
          : [];
      _currentPage = Get.parameters['index'] != null
          ? int.parse(Get.parameters['index'].toString())
          : 0;
      if (_currentPage != 0) {
        _pageController = PageController(initialPage: _currentPage);
      }

      if (employerList.isEmpty) {
        _requestEmployerPublicProfile(employerId);
      }
    }
  }

  void _requestEmployerPublicProfile(int employerId) {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerPublicProfileRequestParams params =
        EmployerPublicProfileRequestParams(employerId: employerId);
    employerBloc.add(EmployerPublicProfileRequested(params: params));
  }

  void _showLetChat() => setState(() {
        isShowConnect = !isShowConnect;
      });

  void _checkValidation() {
    if (candidateData != null) {
      candidateData![DBUtils.candidateTableName] != null
          ? _createSendConnection()
          : showEmptyProfileModal(context, route: searchResultPageRoute);
    } else {
      _showJoinModal();
      _showLetChat();
    }
  }

  void _showJoinModal() {
    Future.delayed(const Duration(milliseconds: 100), () {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return const RegisterEnjoyPopUp();
        },
      );
    });
  }

  //Send Connection
  void _createSendConnection() {
    final connnectionBloc =
        BlocProvider.of<k_connection_bloc.ConnectionBloc>(context);
    ConnectionSendRequestParams params = ConnectionSendRequestParams(
        senderUserId: candidateData!['user_id'],
        token: candidateData!['token'],
        appSiloName: kAppSilo,
        receiverUserId: employerList[_currentPage].id);
    connnectionBloc
        .add(k_connection_bloc.ConnectionSendRequested(params: params));
  }

  void _removeFromList() {
    setState(() {
      employerList.removeAt(_currentPage);
      if (employerList.length == 1) isShowConnect = false;
    });
  }
}
