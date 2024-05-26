part of '../../views.dart';

class ContactUsSection extends StatefulWidget {
  const ContactUsSection({super.key});

  @override
  State<ContactUsSection> createState() => _ContactUsSectionState();
}

class _ContactUsSectionState extends State<ContactUsSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();

  String issue = '';
  Map? candidateData;
  bool isChecked = false;
  String dataSting = "";
  String language = '';
  bool loadMore = false;
  Set<FAQDatum> faqDataResult = {};
  int loadMorePage = 1;
  bool nextPageUrl = true;
  bool isLoading = true;
  String search = "";
  Timer? _debounce;

  @override
  void initState() {
    _getcandidateData();
    super.initState();
  }

  void _loadMoreData() {
    _requestFAQList();
  }

  void changeLoading(bool value) {
    if (!loadMore) {
      setState(() {
        isLoading = value;
      });
    }
  }

  Future<void> _getcandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    language = box.get(DBUtils.language) ?? '';
    _requestFAQList();
  }

  @override
  Widget build(BuildContext context) {
    return _getFAQContainer;
  }

  get _getFAQContainer => Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BackgroundScaffold(
                scaffold: Scaffold(
              key: _scaffoldKey,
              appBar: _getAppBar,
              drawer: const SideMenu(
                menuName: StringConst.contactUsText,
              ),
              backgroundColor: Colors.transparent,
              body: _getContactUsContainer,
              bottomNavigationBar: _getCommunityGuideLine,
            )),
          ),
        ],
      );

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: InkWell(
            onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: Image.asset("assets/icons/menu.png")),
      ),
      leadingWidth: 52,
      title: Text(
        StringConst.contactUsText.tr,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  Widget get _getContactUsContainer {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding20,
          vertical: Sizes.padding20,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'How Can We Help You?'.tr,
                style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              _getSearchForm,
              const SizedBox(
                height: 15,
              ),
              Text(
                'Frequently Asked Questions'.tr,
                style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.primaryGrey,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
              _getBuildFAQList,
            ]),
      ),
    );
  }

  Widget _getAskedQuestion(String title, String answer) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
          left: 26,
          right: 16,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.cardColor.withOpacity(0.1)),
        child: ExpansionTileWidget(
            question: title, answer: answer, color: Colors.white));
  }

  //Search Form
  Widget get _getSearchForm {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.cardColor.withOpacity(0.1),
      ),
      child: TextFormField(
        controller: searchController,
        style: const TextStyle(color: AppColors.white, fontSize: 14),
        maxLines: null,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          changeLoading(true);
          if (_debounce?.isActive ?? false) _debounce!.cancel();
          _debounce = Timer(const Duration(milliseconds: 500), () {
            setState(() {
              faqDataResult.clear();
              loadMorePage = 1;
              nextPageUrl = true;
              search = value;
            });
            _requestFAQList();
          });
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Iconsax.search_normal,
            color: AppColors.primaryGrey,
            size: 20,
          ),
          hintText: StringConst.searchFaqDb.tr,
          hintStyle:
              const TextStyle(fontSize: 14, color: AppColors.secondaryGrey),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget get _getBuildFAQList =>
      BlocConsumer<FaqBloc, FaqState>(builder: (_, state) {
        return _buildFaqWidget;
      }, listener: (_, state) {
        if (state is FaqsLoading) {
          changeLoading(true);
        }
        if (state is FaqsSuccess) {
          final DataResponseModel data = state.faqData;
          if (data.data != null) {
            final FaqModel loadmoredata = FaqModel.fromMap(data.data!);
            if (loadmoredata.data != null) {
              final dataList = loadmoredata.data!.data ?? [];
              for (var element in dataList) {
                faqDataResult.add(element);
              }
              faqDataResult
                  .toList()
                  .sort((a, b) => a.faqRankOrder!.compareTo(b.faqRankOrder!));
              if (loadmoredata.data!.nextPageUrl == null) {
                nextPageUrl = false;
              } else {
                loadMorePage++;
              }
            }
          }
          setState(() {
            loadMore = false;
          });
          changeLoading(false);
        }
        if (state is FaqsFail) {
          changeLoading(false);
        }
      });

  Widget get _buildFaqWidget => isLoading
      ? const SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        )
      : faqDataResult.isEmpty
          ? SizedBox(
              height: 300,
              child: Center(
                child: Text(
                  StringConst.noData.tr,
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            )
          : Column(
              children: [
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: faqDataResult
                      .map((e) =>
                          _getAskedQuestion("${e.question}", "${e.answer}"))
                      .toList(),
                ),
                nextPageUrl
                    ? loadMore
                        ? const SizedBox(
                            width: 17,
                            height: 17,
                            child: CircularProgressIndicator(strokeWidth: 2.0))
                        : CustomPrimaryButton(
                            heightButton: 40,
                            widthButton: 70,
                            text: 'See More',
                            onPressed: () {
                              setState(() {
                                loadMore = true;
                              });
                              _loadMoreData();
                            },
                            fontSize: 10,
                          )
                    : Container()
              ],
            );

  Widget get _getCommunityGuideLine => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(color: AppColors.secondaryGrey),
            GestureDetector(
              onTap: () => Get.toNamed(termsAndPolicyRoute, arguments: 4),
              child: ListTile(
                title: Text(
                  StringConst.viewPoliciesAndGuidelines.tr,
                  style: const TextStyle(
                      fontSize: 18, color: AppColors.primaryColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const Divider(color: AppColors.secondaryGrey),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                StringConst.ifAllElsefails.tr,
                style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.primaryGrey,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: CustomPrimaryButton(
                text: 'Contact Customer Support'.tr,
                widthButton: 800,
                onPressed: () => Get.toNamed(customerSuportPageRoute),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      );

  //FAQ List
  void _requestFAQList() {
    final faqBloc = BlocProvider.of<FaqBloc>(context);
    FaqRequestParams params = FaqRequestParams(
        language: language, page: loadMorePage, keyword: search);
    faqBloc.add(FaqsRequested(params: params));
  }
}
