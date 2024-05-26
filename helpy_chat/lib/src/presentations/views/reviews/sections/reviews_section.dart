part of '../../views.dart';

class ReviewsSection extends StatefulWidget {
  const ReviewsSection({super.key});

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  Employer? employer;
  Map? candidateData;
  List<Review> reviewsList = [];
  bool isConnected = false;
  bool isFromChat = false;

  @override
  void initState() {
    _initializeData();
    _getCandidateData();
    super.initState();

    reviewsList = employer!.reviews ?? [];
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
    if (candidateData != null) {
      _requestConnection();
    }
  }

  void _initializeData() {
    if (Get.parameters.isNotEmpty) {
      String data = Get.parameters[DBUtils.candidateTableName] ?? '';
      employer = EmployerModel.fromJson(json.decode(data));
      isFromChat = Get.parameters["isFromChat"] == "true" ? true : false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
        availableBack: true, scaffold: _getReviewsScaffold);
  }

  Scaffold get _getReviewsScaffold => Scaffold(
        appBar: _getAppBar,
        backgroundColor: Colors.transparent,
        body: BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
          return employer != null ? _getReviwsListView : const EmptyReview();
        }, listener: (_, state) {
          if (state is CandidateCreateReviewLoading) {
            Loading.showLoading(message: StringConst.loadingText);
          }
          if (state is CandidateCreateReviewSuccess) {
            if (state.data.data != null) {
              Loading.cancelLoading();
              _showSuccessInfo();
              _requestEmployerPublicProfile();
              Navigator.pop(context);
            }
          }

          if (state is CandidateCreateReviewFail) {
            Loading.cancelLoading();
            if (state.message != '') {
              showErrorSnackBar(state.message);
            }
          }

          if (state is CandidateReviewsSuccess) {
            if (state.data.data != null) {
              List<Review> data = List<Review>.from((state.data.data!['data']
                      ['data'] as List<dynamic>)
                  .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>)));
              setState(() {
                reviewsList = data;
              });
            }
          }

          if (state is CandidateReviewsFail) {
            if (state.message != '') {
              showErrorSnackBar(state.message);
            }
          }
        }),
      );

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      leadingWidth: 52,
      title: Text(
        StringConst.employerReviewText.tr,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w100),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      actions: [
        if (candidateData != null) _listenForConnection(),
        if (candidateData != null) _listenForEmployer(),
      ],
    );
  }

  Widget get _getReviwsListView => reviewsList.isNotEmpty
      ? ListView.builder(
          itemCount: reviewsList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: [
                  _getCreateReviewHeader,
                  const SizedBox(
                    height: 20,
                  ),
                  ReviewItem(review: reviewsList[index])
                ],
              );
            } else {
              return ReviewItem(review: reviewsList[index]);
            }
          })
      : Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_getCreateReviewHeader, const EmptyReview()],
        );

  Widget get _getCreateReviewHeader => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              StringConst.fiftyNewestReview.tr,
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            candidateData != null && isConnected
                ? isFromChat
                    ? GestureDetector(
                        onTap: () =>
                            candidateData![DBUtils.candidateTableName] != null
                                ? _showCreateReviewModal()
                                : showEmptyProfileModal(context,
                                    route: rootRoute),
                        child: const Text(
                          'Write a review',
                          style: TextStyle(
                              color: AppColors.primaryGrey,
                              fontSize: 12,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    : Container()
                : Container(),
          ],
        ),
      );

  void _showCreateReviewModal() {
    showDialog(
      context: context,
      builder: (context) => RatingCreateModal(
        token: candidateData!['token'],
        byUserId: candidateData!['user_id'],
        onUserId: employer!.id!,
      ),
    );
  }

  Widget _listenForConnection() {
    return BlocConsumer<k_connection_bloc.ConnectionBloc,
        k_connection_bloc.ConnectionState>(builder: (_, state) {
      return Container();
    }, listener: (_, state) {
      if (state is k_connection_bloc.ConnectionListRequestSuccess) {
        if (state.connectionData.data != null) {
          Map data = state.connectionData.data!;
          if (data['data'].isNotEmpty) {
            for (int i = 0; i < data['data'].length; i++) {
              if (data['data'][i]['employer_user_id'] == employer!.id!) {
                setState(() {
                  isConnected = true;
                });
                break;
              }
            }
          }
        }
      }

      if (state is k_connection_bloc.ConnectionListRequestFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget _listenForEmployer() {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return Container();
    }, listener: (_, state) {
      if (state is EmployerPublicProfileSuccess) {
        if (state.employerData.data != null) {
          setState(() {
            employer = EmployerModel.fromJson(state.employerData.data!['data']);
            reviewsList = employer!.reviews ?? [];
          });
        }
      }

      if (state is EmployerPublicProfileFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  void _requestConnection() {
    final connectionBloc =
        BlocProvider.of<k_connection_bloc.ConnectionBloc>(context);
    ConnectionListRequestParams params =
        ConnectionListRequestParams(token: candidateData!['token']);
    connectionBloc
        .add(k_connection_bloc.ConnectionListRequested(params: params));
  }

  void _requestEmployerPublicProfile() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerPublicProfileRequestParams params =
        EmployerPublicProfileRequestParams(employerId: employer!.id);
    employerBloc.add(EmployerPublicProfileRequested(params: params));
  }

  void _showSuccessInfo() {
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
                backgroundColor: AppColors.greyBg,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Container(
                    color: AppColors.greyBg,
                    height: 207,
                    width: 326,
                    child: const MessageSentPopUp(
                        title: 'Thanks for submitting your review.',
                        message: 'we love to hear from you.')),
              ));
    }).then((value) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    });
  }
}
