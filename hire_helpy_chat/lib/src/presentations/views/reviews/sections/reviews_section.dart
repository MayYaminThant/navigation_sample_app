part of '../../views.dart';

class ReviewsSection extends StatefulWidget {
  const ReviewsSection({super.key});

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  Candidate? candidate;
  Map? employerData;
  List<Review> reviewsList = [];
  bool isConnected = false;

  @override
  void initState() {
    _initializeData();
    _getCandidateData();
    super.initState();

    reviewsList = candidate!.reviews ?? [];
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
    if (employerData != null) {
      _requestConnection();
    }
  }

  _initializeData() {
    if (Get.parameters.isNotEmpty) {
      String data = Get.parameters[DBUtils.employerTableName] ?? '';
      candidate = CandidateModel.fromJson(json.decode(data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return BackgroundScaffold(
          onWillPop: () => Get.back(), scaffold: _getReviewsScaffold);
    }, listener: (_, state) {
      if (state is EmployerAcademicQualificationSuccess) {
        Loading.showLoading(message: StringConst.loadingText);
      }
      if (state is EmployerCreateReviewSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          _showSuccessInfo();
          _requestCandidatePublicProfile();
          Navigator.pop(context);
        }
      }

      if (state is EmployerCreateReviewFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerReviewsSuccess) {
        if (state.data.data != null) {
          List<Review> data = List<Review>.from(
              (state.data.data!['data']['data'] as List<dynamic>)
                  .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            reviewsList = data;
          });
        }
      }

      if (state is EmployerReviewsFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Scaffold get _getReviewsScaffold => Scaffold(
        appBar: _getAppBar,
        backgroundColor: Colors.transparent,
        body: candidate != null ? _getReviwsListView : Container(),
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
      title: const Text(
        StringConst.candidateReviewText,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w100),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      actions: [
        if (employerData != null) _listenForConnection(),
        if (employerData != null) _listenForEmployer(),
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
          children: [_getCreateReviewHeader],
        );

  Widget get _getCreateReviewHeader => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '50 Newest Reviews',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            employerData != null && isConnected
                ? GestureDetector(
                    onTap: () =>
                        employerData![DBUtils.employerTableName] != null
                            ? _showCreateReviewModal()
                            : showEmptyProfileModal(context, route: rootRoute),
                    child: const Text(
                      'Write a review',
                      style: TextStyle(
                          color: AppColors.primaryGrey,
                          fontSize: 12,
                          decoration: TextDecoration.underline),
                    ),
                  )
                : Container(),
          ],
        ),
      );

  _showCreateReviewModal() {
    showDialog(
      context: context,
      builder: (context) => RatingCreateModal(
        token: employerData!['token'],
        byUserId: employerData!['user_id'],
        onUserId: candidate!.id!,
      ),
    );
  }

  _listenForConnection() {
    return BlocConsumer<kConnectionBloc.ConnectionBloc,
        kConnectionBloc.ConnectionState>(builder: (_, state) {
      return Container();
    }, listener: (_, state) {
      if (state is kConnectionBloc.ConnectionListRequestSuccess) {
        if (state.connectionData.data != null) {
          Map data = state.connectionData.data!;
          if (data['data'].isNotEmpty) {
            for (int i = 0; i < data['data'].length; i++) {
              if (data['data'][i]['candidate_user_id'] == candidate!.id!) {
                setState(() {
                  isConnected = true;
                });
                break;
              }
            }
          }
        }
      }

      if (state is kConnectionBloc.ConnectionListRequestFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  _listenForEmployer() {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return Container();
    }, listener: (_, state) {
      if (state is CandidatePublicProfileSuccess) {
        if (state.candidateData.data != null) {
          setState(() {
            candidate =
                CandidateModel.fromJson(state.candidateData.data!['data']);
            reviewsList = candidate!.reviews ?? [];
          });
        }
      }

      if (state is CandidatePublicProfileFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  void _requestConnection() {
    final connectionBloc =
        BlocProvider.of<kConnectionBloc.ConnectionBloc>(context);
    ConnectionListRequestParams params =
        ConnectionListRequestParams(token: employerData!['token']);
    connectionBloc.add(kConnectionBloc.ConnectionListRequested(params: params));
  }

  void _requestCandidatePublicProfile() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidatePublicProfileRequestParams params =
        CandidatePublicProfileRequestParams(candidateId: candidate!.id!);
    candidateBloc.add(CandidatePublicProfileRequested(params: params));
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
                content: Builder(
                  builder: (context) {
                    return Container(
                        color: AppColors.greyBg,
                        height: 207,
                        width: 326,
                        child: const MessageSentPopUp(
                            title: 'Thanks for submitting your review.',
                            message: 'we love to hear from you.'));
                  },
                ),
              ));
    }).then((value) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    });
  }
}
