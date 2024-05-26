part of '../../views.dart';

class WorkingPreferencesSection extends StatefulWidget {
  const WorkingPreferencesSection({super.key});

  @override
  State<WorkingPreferencesSection> createState() =>
      _WorkingPreferencesSectionState();
}

class _WorkingPreferencesSectionState extends State<WorkingPreferencesSection> {
  final TextEditingController additionalPreferenceController =
      TextEditingController();
  final TextEditingController foodAllergyController = TextEditingController();
  int restDay = 0;
  bool isWorkOnRestDay = false;
  Map? candidateData;
  Candidate? candidate;
  List<dynamic> taskList = [];
  String selecetedTask = '';
  bool? isSorted = false;
  bool clickedExit = false;
  String route = '';
  bool isClicked = false;

  @override
  void initState() {
    _getCandidateData();
    _initializeData();
    super.initState();
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });

    if (candidateData![DBUtils.candidateTableName] != null) {
      _requestCandidateProfile();
    }
  }

  void _initializeData() {
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return BackgroundScaffold(
          availableBack: true, scaffold: _getWorkingPreferencesScaffold);
    }, listener: (_, state) {
      if (state is CandidateProfileSuccess) {
        if (state.data.data != null) {
          Candidate data = CandidateModel.fromJson(state.data.data!['data']);
          setState(() {
            candidate = data;
            _initializeCandidateData();
          });
        }
      }

      if (state is CandidateProfileFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateUpdateWorkingPreferencesSuccess) {
        if (state.data.data != null) {
          state.data.data!['data']['token'] = candidateData!['token'];
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);

          clickedExit
              ? Get.offAllNamed(rootRoute)
              : Get.toNamed(profileCreationSuccessPageRoute);
        }
      }

      if (state is CandidateUpdateWorkingPreferencesFail) {
        setState(() {
          clickedExit = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Scaffold get _getWorkingPreferencesScaffold {
    return Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      body: _getWorkingPreferencesContainer,
      bottomNavigationBar: BottomNavigationItem(
          onNextButtonPressed: () => _checkValidation(),
          nextButtonText: StringConst.saveAndfinish.tr,
          onSaveAndQuitButtonPressed: () {
            setState(() {
              clickedExit = true;
            });
            _createCandidateWorkingPreferences();
          }),
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
          StringConst.workingPreferenceTitle.tr,
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

  Widget get _getWorkingPreferencesContainer => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const ProfileStepper(
                currentIndex: 4,
              ),
              //_getImageUpload(),

              const SizedBox(
                height: 20,
              ),
              _getWorkingPrefernecesItems,
              const SizedBox(
                height: 20,
              ),
              _getIsWorkRestDays,
              const SizedBox(
                height: 20,
              ),
              _getAddPreferredTasksContainer,

              _getTextField(
                  "additional working key",
                  additionalPreferenceController,
                  StringConst.additionalWorkingPreferenceText,
                  false,
                  6),
              _getTextField("tell the employee key", foodAllergyController,
                  StringConst.drugAllergyPreferenceText, false, 6),
            ],
          ),
        ),
      );

  Widget get _getWorkingPrefernecesItems => Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _getSpacingTableRow,
          TableRow(
            children: _getRestDaysDropDown,
          ),
        ],
      );

  //Rest Days
  List<Widget> get _getRestDaysDropDown {
    return [
      Text(
        StringConst.restDaysText.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
      RestDayDropdownItem(
        initialValue: restDay.toString(),
        title: StringConst.selectRestDaysText,
        onValueChanged: (RestDay data) => setState(() {
          restDay = data.value ?? -1;
        }),
        suffixIcon: Iconsax.arrow_down5,
        prefix: ConfigsKeyHelper.adSearchRestDayKey,
      )
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  //Work on Rest Days
  Widget get _getIsWorkRestDays {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomCheckBox(
          initialValue: isWorkOnRestDay,
          onValueChanged: (bool value) {
            setState(() {
              isWorkOnRestDay = value;
            });
          },
          trailing: SizedBox(
            width: MediaQuery.of(context).size.width - 80,
            child: Text(StringConst.workOnRestDaysText.tr,
                style: const TextStyle(
                    color: AppColors.primaryGrey, fontSize: 15)),
          ),
        ),
      ],
    );
  }

  TableRow get _getSpacingTableRow => const TableRow(children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        )
      ]);

  Widget _getTextField(
    String key,
    TextEditingController controller,
    String title,
    bool hasSuffixIcon,
    int? maxLine,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: CustomTextField(
        key: Key(key),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.cardColor.withOpacity(0.1)),
        maxLine: maxLine ?? 1,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
        controller: controller,
        textInputType: TextInputType.text,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
        hasPrefixIcon: false,
        hasTitle: true,
        isRequired: true,
        hasSuffixIcon: hasSuffixIcon,
        titleStyle: const TextStyle(
          color: AppColors.white,
          fontSize: Sizes.textSize14,
        ),
        hasTitleIcon: false,
        enabledBorder: Borders.noBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: const BorderSide(color: AppColors.white),
        ),
        hintTextStyle:
            const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
        textStyle: const TextStyle(color: AppColors.primaryGrey),
        hintText: title,
      ),
    );
  }

  //Add Preferred Tasks
  Widget get _getAddPreferredTasksContainer => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringConst.prefereedTasks.tr,
            style: const TextStyle(color: AppColors.white, fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: AppColors.backgroundGrey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border:
                  taskList.isEmpty ? Border.all(color: AppColors.red) : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  StringConst.addedYourPreferredTasks,
                  style: TextStyle(color: AppColors.primaryGrey, fontSize: 14),
                ),
                _getTasksList,
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    1: FixedColumnWidth(67.0),
                  },
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                          ),
                          child: DropdownItem(
                            initialValue: selecetedTask,
                            title: StringConst.selectTasksText,
                            onValueChanged: (String value) {
                              setState(() {
                                selecetedTask = value;
                              });
                            },
                            datas: const [],
                            prefix: ConfigsKeyHelper.profileStep5TaskTypeKey,
                            suffixIcon: Iconsax.arrow_down5,
                            isRequired: false,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _addTaks(),
                          child: Container(
                            margin: const EdgeInsets.only(top: 15, left: 10),
                            width: 42,
                            height: 47,
                            decoration: BoxDecoration(
                                color: selecetedTask.isNotEmpty
                                    ? !(taskList.any((model) =>
                                            model["task_type"] ==
                                            selecetedTask))
                                        ? AppColors.green
                                        : AppColors.primaryGrey
                                    : AppColors.primaryGrey,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Center(
                                child: Icon(
                              Iconsax.add_circle,
                              color: AppColors.white,
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      );

  Widget get _getTasksList {
    if (taskList.isNotEmpty) {
      return ReorderableListView(
        shrinkWrap: true,
        proxyDecorator: proxyDecorator,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            isSorted = true;
            if (newIndex > oldIndex) {
              newIndex = newIndex - 1;
            }
            final item = taskList.removeAt(oldIndex);
            taskList.insert(newIndex, item);
          });
        },
        children: taskList
            .map((e) => Row(
                  key: ValueKey(e['task_type'].toString()),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e['task_type'].toString(),
                      style:
                          const TextStyle(color: AppColors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        taskList.removeWhere((element) => element == e);
                      }),
                      child: Container(
                          margin: const EdgeInsets.all(10.0),
                          width: 25,
                          height: 25,
                          child: const Icon(
                            Iconsax.trash,
                            size: 20,
                            color: AppColors.red,
                          )),
                    )
                  ],
                ))
            .toList(),
      );
    } else {
      return Container();
    }
  }

  //Create Candidate Working Preferences
  void _createCandidateWorkingPreferences() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateUpdateWorkingPreferenceRequestParams params =
        CandidateUpdateWorkingPreferenceRequestParams(
            token: candidateData!['token'],
            restDayWorkPref: isWorkOnRestDay ? 1 : 0,
            additionalWorkPref: additionalPreferenceController.text,
            drugAllergy: foodAllergyController.text,
            restDayChoice: restDay,
            tasks: _getTaskListData(),
            updateProgress: candidate?.restDayChoice == null ? 1 : 0);

    candidateBloc
        .add(CandidateUpdateWorkingPreferencesRequested(params: params));
  }

  void _initializeCandidateData() {
    restDay = candidate!.restDayChoice ?? 0;
    isWorkOnRestDay = candidate!.restDayWorkPref ?? false;
    additionalPreferenceController.text = candidate!.workReligionPref ?? '';
    foodAllergyController.text = candidate!.foodAllergy ?? '';
    if (candidate!.tasksTypes != null) {
      for (int i = 0; i < candidate!.tasksTypes!.length; i++) {
        taskList.add({
          "task_type": candidate!.tasksTypes![i].taskType ?? '',
        });
      }
    }
  }

  void _checkValidation() {
    if (taskList.isEmpty) {
      showErrorSnackBar('Please select preferred tasks.');
    } else {
      _createCandidateWorkingPreferences();
    }
  }

  void _addTaks() {
    if (selecetedTask.isNotEmpty) {
      setState(() {
        if (!(taskList.any((model) => model["task_type"] == selecetedTask))) {
          taskList.add({
            "task_type": selecetedTask,
          });
        }
        selecetedTask = '';
      });
    }
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

  List<dynamic> _getTaskListData() {
    List<dynamic> data = [];
    for (int i = 0; i < taskList.length; i++) {
      data.add(
          {"task_type": taskList[i]['task_type'], "task_display_order": i});
    }
    return data;
  }
}
