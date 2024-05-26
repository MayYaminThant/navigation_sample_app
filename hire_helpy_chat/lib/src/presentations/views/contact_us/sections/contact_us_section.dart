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
  Map? employerData;
  bool isChecked = false;
  String dataSting = "";
  String language = '';
  bool loadMore = false;

  @override
  void initState() {
    _getEmployerData();
    super.initState();
  }

  void _loadMoreData() {
    _requestFAQList();
    setState(() {
      loadMore = true;
    });
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    language = box.get(DBUtils.language) ?? '';
    _requestFAQList();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _getFAQContainer;
  }

  get _getFAQContainer => Stack(
        children: [
          SingleChildScrollView(
            child: BackgroundScaffold(
                onWillPop: () => Get.offAllNamed(rootRoute),
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
          if (isLoading)
            Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )),
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
      title: const Text(
        'FAQ',
        style: TextStyle(
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
        onChanged: (value) => _searchFAQ(value),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Iconsax.search_normal,
            color: AppColors.primaryGrey,
            size: 20,
          ),
          hintText: 'Search FAQ Database',
          hintStyle: TextStyle(fontSize: 14, color: AppColors.secondaryGrey),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget get _getBuildFAQList =>
      BlocConsumer<FaqBloc, FaqState>(builder: (_, state) {
        if (state is FaqsSearchSuccess) {
          return _buildFaqSearchResultWidget(state.data);
        }
        return _buildFaqWidget;
      }, listener: (_, state) {
        if (state is FaqsLoading) {
          _setLoading(true);
          setState(() {
            loadMore = false;
          });
        }
        if (state is FaqsSuccess) {
          _setLoading(false);
          setState(() {
            loadMore = false;
          });
        }
        if (state is FaqsFail) {
          _setLoading(false);
          setState(() {
            loadMore = false;
          });
        }
      });

  Widget get _buildFaqWidget => isLoading
      ? Container()
      : BlocProvider.of<FaqBloc>(context).faqDataModel.data == null
          ? SizedBox(
              height: 300,
              child: Center(
                child: Text(
                  "No Data!",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            )
          : BlocProvider.of<FaqBloc>(context).faqDataModel.data!.data == null
              ? SizedBox(
                  height: 300,
                  child: Center(
                    child: Text(
                      "No Data!",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                )
              : BlocProvider.of<FaqBloc>(context)
                      .faqDataModel
                      .data!
                      .data!
                      .isEmpty
                  ? SizedBox(
                      height: 300,
                      child: Center(
                        child: Text(
                          "No Data!",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: BlocProvider.of<FaqBloc>(context)
                              .faqDataModel
                              .data!
                              .data!
                              .map((e) => _getAskedQuestion(
                                  "${e.question}", "${e.answer}"))
                              .toList(),
                        ),
                        context.read<FaqBloc>().nextPageUrl
                            ? loadMore
                                ? const SizedBox(
                                    width: 17,
                                    height: 17,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2.0))
                                : CustomPrimaryButton(
                                    heightButton: 40,
                                    text: 'See More',
                                    onPressed: () => _loadMoreData(),
                                    fontSize: 10,
                                  )
                            : Text("No More Data!",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey, fontSize: 11.0))
                      ],
                    );

  /// build FAQ Search Result
  Widget _buildFaqSearchResultWidget(List<faqModel.Datum> data) => data.isEmpty
      ? SizedBox(
          height: 300,
          child: Center(
            child: Text(
              "No Data!",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        )
      : Column(
          children: [
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: data
                  .map((e) => _getAskedQuestion("${e.question}", "${e.answer}"))
                  .toList(),
            ),
          ],
        );

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Widget get _getCommunityGuideLine => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(color: AppColors.secondaryGrey),
            GestureDetector(
              onTap: () => Get.toNamed(termsAndPolicyRoute, arguments: 4),
              child: const ListTile(
                title: Text(
                  'View Our Community Policies And Guidelines',
                  style: TextStyle(fontSize: 18, color: AppColors.primaryColor),
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const Divider(color: AppColors.secondaryGrey),
            const SizedBox(
              height: 25,
            ),
            const Center(
              child: Text(
                'If all else fails...Contact our customer support!',
                style: TextStyle(
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
                onPressed: () => Get.offAllNamed(customerSuportPageRoute),
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
    FaqRequestParams params =
        FaqRequestParams(language: language, page: faqBloc.loadMorePage);
    faqBloc.add(FaqsRequested(params: params));
  }

  //Search FAQ
  _searchFAQ(String value) {
    if (value == '') {
      _requestFAQList();
    } else {
      final faqBloc = BlocProvider.of<FaqBloc>(context);
      faqBloc.add(FaqsSearched(query: value));
    }
  }
}
