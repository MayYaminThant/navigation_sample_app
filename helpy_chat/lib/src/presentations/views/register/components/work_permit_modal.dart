part of '../../views.dart';

class WorkPermitModal extends StatefulWidget {
  final Function(String)? onSave;
  final String? token;
  final int userId;

  const WorkPermitModal(
      {super.key, this.onSave, this.token, required this.userId});

  @override
  State<WorkPermitModal> createState() => _WorkPermitModalState();
}

class _WorkPermitModalState extends State<WorkPermitModal> {
  String country = '';
  bool isLoading = false;
  bool _submitEnabled = false;

  WorkPermitDetails? uploadedWorkPermit;

  @override
  void initState() {
    super.initState();
    _resetPhotos();
  }

  void _resetPhotos() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    candidateBloc.resetWorkPermit();
  }

  void _photoUpdated(WorkPermitDetails? workPermit) {
    superPrint("UPDATED");
    superPrint(workPermit?.backImageThumbnail);
    if (workPermit == null) {
      return;
    }
    setState(() {
      uploadedWorkPermit = workPermit;
    });
    _checkValid();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 327,
            decoration: BoxDecoration(
              color: AppColors.greyBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  StringConst.workPermitCheckTitle.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      color: AppColors.greyShade2),
                ),
                const SizedBox(height: 20),
                _getCountryOfWorkPermit,
                const SizedBox(height: 20),
                _getWorkPermitPhotoLabel,
                _getWorkPermitPhotoButtons,
                const SizedBox(height: 20),
                ..._getWpDataDisplay,
                const SizedBox(height: 15),
                BlocConsumer<CandidateBloc, CandidateState>(
                  builder: (_, state) {
                    return isLoading
                        ? CustomPrimaryButton(
                            text: StringConst.submitText.tr,
                            fontSize: 16,
                            widthButton: MediaQuery.of(context).size.width,
                            heightButton: 47,
                            customColor: AppColors.primaryGrey,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Please wait ...",
                                    style: GoogleFonts.poppins(
                                        color: AppColors.blackShade9),
                                  ),
                                  const SizedBox(width: 18),
                                  const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                      )))
                                ]))
                        : CustomPrimaryButton(
                            text: StringConst.submitText.tr,
                            fontSize: 16,
                            widthButton: MediaQuery.of(context).size.width,
                            heightButton: 47,
                            onPressed: _submitEnabled
                                ? () => _checkWorkPermit()
                                : null,
                          );
                  },
                  listener: (context, state) {
                    if (state is WorkPermitPhotoUpdated) {
                      _photoUpdated(state.workPermitDetails);
                    }

                    if (state is CandidateWorkPermitLoading) {
                      _setLoading(true);
                    }
                    if (state is CandidateWorkPermitSuccess) {
                      _setLoading(false);
                    }
                    if (state is CandidateWorkPermitFail) {
                      _setLoading(false);
                    }
                  },
                ),
                if (isLoading)
                  Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('This may take up to one minute.'.tr))
              ],
            ),
          ),
        ));
  }

  void _checkValid() => setState(() {
        _submitEnabled = _validate(notify: false);
      });

  List<Widget> get _getWpDataDisplay =>
      uploadedWorkPermit?.birthday == null || uploadedWorkPermit?.fin == null
          ? []
          : [
              _getDateDisplay,
              const SizedBox(height: 20),
              _getFinDisplay,
              const SizedBox(height: 15),
            ];

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Widget get _getWorkPermitPhotoLabel => Row(children: [
        Text(
          StringConst.workPermitPhotoText.tr,
          style: const TextStyle(
              fontWeight: FontWeight.w200, color: AppColors.greyShade2),
        )
      ]);

  Widget get _getWorkPermitPhotoButtons => Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 120),
              child: IntrinsicHeight(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _getWorkPermitButton(isFront: true)),
                  const SizedBox(width: 20),
                  Expanded(child: _getWorkPermitButton(isFront: false)),
                ],
              )))
        ],
      );

  Widget _getWorkPermitButton({required bool isFront}) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () async {
              await Get.toNamed(workPermitCameraRoute, arguments: isFront);
              // await Get.dialog(UploadWorkPermitModal(isFront: isFront));
              if (!mounted) return;
              final candidateBloc = BlocProvider.of<CandidateBloc>(context);
              _photoUpdated(candidateBloc.workPermit);
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                // border: Border.all(color: AppColors.black, width: 1),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (isFront
                              ? uploadedWorkPermit?.frontImageThumbnail
                              : uploadedWorkPermit?.backImageThumbnail) ==
                          null
                      ? [
                          const Icon(
                            Iconsax.camera,
                            size: 25,
                            color: AppColors.greyShade2,
                          ),
                          const SizedBox(height: 5),
                          Text(
                              isFront
                                  ? 'Upload Front of Work Permit'.tr
                                  : 'Upload Back of Work Permit'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200,
                                  color: AppColors.greyShade2,
                                  height: 1.2))
                        ]
                      : [
                          const SizedBox(height: 3),
                          ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 100),
                              child: Image.file(File((isFront
                                      ? uploadedWorkPermit?.frontImageThumbnail
                                      : uploadedWorkPermit
                                          ?.backImageThumbnail) ??
                                  ''))),
                          const SizedBox(height: 8),
                          Text(
                              isFront
                                  ? 'Change Front Photo'.tr
                                  : 'Change Back Photo'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200,
                                  color: AppColors.greyShade2,
                                  height: 1.2))
                        ],
                ),
              ),
            )));
  }

  Widget get _getCountryOfWorkPermit => Table(
        columnWidths: const {0: FixedColumnWidth(100.0)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            Text(
              StringConst.countryOfWorkPermitText.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.w200, color: AppColors.greyShade2),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CountryDropdownItem(
                backgroundColor: AppColors.white,
                textColor: Colors.black,
                topCountries: kEmployerTopCountries,
                title: 'Select',
                onValueChanged: (String data) {
                  setState(() {
                    country = data;
                  });
                  _checkValid();
                },
                prefix: ConfigsKeyHelper.workPermitCountryKey,
                initialValue: '',
              ),
            ),
          ])
        ],
      );

  Widget get _getDateDisplay => uploadedWorkPermit?.birthday == null
      ? Container()
      : Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConst.dateOfBirthText.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.w200, color: AppColors.greyShade2),
              ),
              const SizedBox(height: 1),
              Text(
                uploadedWorkPermit?.birthday == null
                    ? ''
                    : DateFormat('dd-MM-yyyy')
                        .format(uploadedWorkPermit!.birthday!),
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: AppColors.greyShade2),
              )
            ],
          )
        ]);

  Widget get _getFinDisplay => uploadedWorkPermit?.fin == null
      ? Container()
      : Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConst.foreignIdentificationNumberText.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.w200, color: AppColors.greyShade2),
              ),
              const SizedBox(height: 1),
              Text(
                uploadedWorkPermit?.fin ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: AppColors.greyShade2),
              )
            ],
          )
        ]);

  bool _validate({bool notify = false}) {
    if (country == '') {
      if (notify) {
        showErrorSnackBar('Please select your work permit country.'.tr,
            barrierDismissible: true);
      }
      return false;
    }
    if (uploadedWorkPermit?.birthday == null) {
      if (notify) {
        showErrorSnackBar('Please scan your work permit again.'.tr,
            barrierDismissible: true);
      }
      return false;
    }
    if (uploadedWorkPermit?.fin == null) {
      if (notify) {
        showErrorSnackBar('Please scan your work permit again.'.tr,
            barrierDismissible: true);
      }
      return false;
    }
    if (uploadedWorkPermit?.frontImagePath == null) {
      if (notify) {
        showErrorSnackBar('Please scan the front of your work permit.'.tr,
            barrierDismissible: true);
      }
      return false;
    }
    if (uploadedWorkPermit?.backImagePath == null) {
      if (notify) {
        showErrorSnackBar('Please scan the back of your work permit.'.tr,
            barrierDismissible: true);
      }
      return false;
    }
    return true;
  }

  //Check Work Permit
  void _checkWorkPermit() {
    final valid = _validate(notify: true);
    if (!valid) return;

    final birthdayText =
        DateFormat('yyyy-MM-dd').format(uploadedWorkPermit!.birthday!);

    // submit
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateWorkPermitRequestParams params = CandidateWorkPermitRequestParams(
        token: widget.token,
        country: country,
        dob: birthdayText,
        fin: uploadedWorkPermit!.fin,
        workPermitFrontFile: uploadedWorkPermit?.frontImagePath == null
            ? null
            : File(uploadedWorkPermit!.frontImagePath!),
        workPermitBackFile: uploadedWorkPermit?.backImagePath == null
            ? null
            : File(uploadedWorkPermit!.backImagePath!));

    candidateBloc.add(CandidateWorkPermitRequested(params: params));
  }
}
