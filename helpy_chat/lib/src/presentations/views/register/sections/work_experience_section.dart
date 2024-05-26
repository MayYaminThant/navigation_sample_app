part of '../../views.dart';

class WorkExperienceSection extends StatefulWidget {
  const WorkExperienceSection({super.key});

  @override
  State<WorkExperienceSection> createState() => _WorkExperienceSectionState();
}

class _WorkExperienceSectionState extends State<WorkExperienceSection> {
  Candidate? candidate;
  Map? candidateData;
  List<Employment> employmentList = [];
  bool isSorted = false;
  final TextEditingController numberOfSiblingsController =
      TextEditingController();

  String route = '';
  bool isClickNext = true;
  bool needShowDialog = true;
  bool isLoading = true;
  bool waitingForCandidateProfile = true;

  @override
  void initState() {
    _getCandidateData();
    _initializeData();
    super.initState();
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Material(
          elevation: 0,
          color: AppColors.primaryGrey.withOpacity(0.1),
          child: child,
        );
      },
      child: child,
    );
  }

  void changeLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
    if (candidateData != null) {
      if (candidateData![DBUtils.candidateTableName] != null) {
        _requestCandidateProfile();
        return;
      }
    }
    setState(() => waitingForCandidateProfile = false);
  }

  _initializeData() {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
    }
  }

  void _requestCandidateProfile() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateRequestParams params = CandidateRequestParams(
        token: candidateData!['token'], userId: candidateData!['user_id']);
    candidateBloc.add(CandidateProfileRequested(params: params));
  }

  Scaffold get _getFamilyInformationScaffold {
    return Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      body: _getFamilyInformationContainer,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationItem(
        onNextButtonPressed: () => _checkWorkExperienceSort(),
        onSaveAndQuitButtonPressed: () => _checkWorkExperienceSortAndQuit(),
      ),
    );
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => route != '' ? Get.back() : Get.offNamed(rootRoute),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.workExperienceTitle.tr,
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

  Widget get _getFamilyInformationContainer => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: _getWorkExperienceListView,
      );

  Widget get _getWorkExperienceItems => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _getWorkExperienceDropDown,
      );

  //Add Work Experience
  List<Widget> get _getWorkExperienceDropDown {
    return [
      Text(
        StringConst.addWorkExperienceText.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      GestureDetector(
          onTap: () => _showAddWorkExperienceModal(),
          child: const Icon(
            Iconsax.add_circle,
            color: AppColors.white,
          ))
    ];
  }

  void changeNeedShow(bool value) {
    setState(() {
      needShowDialog = value;
    });
  }

  void _showAddWorkExperienceModal() {
    changeNeedShow(false);
    List<int> dataList = [];
    if (candidate != null) {
      if (candidate!.employments != null) {
        for (var element in candidate!.employments!) {
          if (element.id != null) {
            dataList.add(element.id!);
          }
        }
      }
    }
    dataList.isNotEmpty
        ? isSorted
            ? _createCandidateSorting(dataList)
            : null
        : null;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        void closeDialog() {
          setState(() {
            Navigator.of(context).pop();
          });
        }

        return BlocConsumer<CandidateBloc, CandidateState>(
          builder: (context, state) => StatefulBuilder(
            builder: (context, setState) => EmploymentHistoryModal(
              token: candidateData!['token'],
              onSave: isLoading
                  ? null
                  : (enteredText) {
                      changeNeedShow(true);
                    },
              userId: candidateData!['user_id'],
              displayOrder: dataList.length + 1,
            ),
          ),
          listener: (context, state) {
            if (state is CandidateCreateEmploymentLoading) {
              changeLoading(true);
            }
            if (state is CandidateCreateEmploymentSuccess) {
              changeLoading(false);
              closeDialog();
            }
            if (state is CandidateCreateEmploymentFail) {
              changeLoading(false);
              closeDialog();
            }
          },
        );
      },
    );
  }

  Widget get _getWorkExperienceListView => candidate != null || !waitingForCandidateProfile
      ? ReorderableListView(
          physics: const BouncingScrollPhysics(),
          header: Column(
            children: [
              const ProfileStepper(
                currentIndex: 3,
              ),
              const SizedBox(
                height: 20,
              ),
              _getWorkExperienceItems,
            ],
          ),
          dragStartBehavior: DragStartBehavior.start,
          shrinkWrap: true,
          proxyDecorator: proxyDecorator,
          onReorder: (oldIndex, newIndex) {
            if (candidate == null) {
              return;
            }
            setState(() {
              isSorted = true;
              if (newIndex > oldIndex) {
                newIndex = newIndex - 1;
              }
              final item = candidate!.employments!.removeAt(oldIndex);
              candidate!.employments!.insert(newIndex, item);
            });
          },
          children: candidate != null ? candidate!.employments!
              .map((e) => EmploymentItem(
                    key: ValueKey(e),
                    employment: e,
                    token: candidateData!['token'],
                    userId: candidateData!['user_id'],
                    isShowMenu: true,
                  ))
              .toList() : [],
        )
      : const Center(child: CircularProgressIndicator());

  void _checkWorkExperienceSort() {
    changeNeedShow(true);
    if (isSorted) {
      List<int> dataList = [];
      if (candidate != null) {
        if (candidate!.employments != null) {
          for (var element in candidate!.employments!) {
            if (element.id != null) {
              dataList.add(element.id!);
            }
          }
        }
      }
      _createCandidateSorting(dataList);
    } else {
      _goToWorkingPerferencePage();
    }
  }

  void _createCandidateSorting(List<int> data) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateCreateEmploymentSortRequestParams params =
        CandidateCreateEmploymentSortRequestParams(
            token: candidateData!['token'], employments: data);
    candidateBloc.add(CandidateEmploymentSortRequested(params: params));
  }

  void _goToWorkingPerferencePage() {
    Get.toNamed(workingPreferencesPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return BackgroundScaffold(
          availableBack: true, scaffold: _getFamilyInformationScaffold);
    }, listener: (_, state) {
      if (state is CandidateProfileSuccess) {
        setState(() {
          waitingForCandidateProfile = false;
        });
        if (state.data.data != null) {
          Candidate data = CandidateModel.fromJson(state.data.data!['data']);
          setState(() {
            candidate = data;
          });
        }
      }

      if (state is CandidateProfileFail) {
        setState(() {
          waitingForCandidateProfile = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateCreateEmploymentSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          Navigator.of(context).pop();
          _requestCandidateProfile();
        }
      }

      if (state is CandidateCreateEmploymentFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
      if (state is CandidateDeleteEmploymentSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          _requestCandidateProfile();
        }
      }

      if (state is CandidateDeleteEmploymentFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateUpdateEmploymentSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          Navigator.of(context).pop();
          _requestCandidateProfile();
        }
      }

      if (state is CandidateUpdateEmploymentFail) {
        if (state.message != '') {
          superPrint('error ${state.message}');
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateEmploymentSortSuccess) {
        if (needShowDialog) {
          if (state.data.data != null) {
            isClickNext
                ? _goToWorkingPerferencePage()
                : Get.offAllNamed(rootRoute);
            showSuccessSnackBar(state.data.data!['message']);
          }
        }
      }

      if (state is CandidateEmploymentSortFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  void _checkWorkExperienceSortAndQuit() {
    changeNeedShow(true);
    if (isSorted) {
      List<int> dataList = [];
      if (candidate != null) {
        if (candidate!.employments != null) {
          for (var element in candidate!.employments!) {
            if (element.id != null) {
              dataList.add(element.id!);
            }
          }
        }
      }
      _createCandidateSorting(dataList);
      setState(() {
        isClickNext = false;
      });
    } else {
      Get.offAllNamed(rootRoute);
    }
  }
}
