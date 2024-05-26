part of '../../views.dart';

class TermsSection extends StatefulWidget {
  const TermsSection({super.key});

  @override
  State<TermsSection> createState() => _TermsSectionState();
}

class _TermsSectionState extends State<TermsSection> {
  int? arguments;

  @override
  void initState() {
    super.initState();
    arguments = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/no-image-bg.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
          appBar: _getAppBar,
          backgroundColor: Colors.transparent,
          body: _getTermsContainer,
        ),
      ),
    );
  }

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
        _getTitleAppBar(),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  Widget get _getTermsContainer {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding20,
          vertical: Sizes.padding20,
        ),
        child: Text(
          _getMainText,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14,
            height: 2,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  get _getMainText {
    var text = 'null';
    if (arguments == 1) {
      text = StringConst.termsOfService.tr;
    } else if (arguments == 2) {
      text = StringConst.privacyPolicy.tr;
    } else if (arguments == 3) {
      text = StringConst.eula.tr;
    } else if (arguments == 4) {
      text = StringConst.policyAndGuideLinessText.tr;
    }
    return text;
  }

  _getTitleAppBar() {
    var text = 'null';
    if (arguments == 1) {
      text = StringConst.termsOfServiceText.tr;
    } else if (arguments == 2) {
      text = 'Privacy Policy'.tr;
    } else if (arguments == 3) {
      text = StringConst.eulaText.tr;
    } else if (arguments == 4) {
      text = 'Policies and Guidelines'.tr;
    }
    return text;
  }
}
