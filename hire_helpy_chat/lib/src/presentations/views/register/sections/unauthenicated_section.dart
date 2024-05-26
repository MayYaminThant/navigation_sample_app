part of '../../views.dart';

class UnauthenicatedSection extends StatefulWidget {
  const UnauthenicatedSection({Key? key}) : super(key: key);

  @override
  State<UnauthenicatedSection> createState() => _UnauthenicatedSectionState();
}

class _UnauthenicatedSectionState extends State<UnauthenicatedSection> {
  Message message = Message();

  @override
  void initState() {
    super.initState();
    if (Get.parameters.isNotEmpty) {
      String msg = Get.parameters['data'] ?? '';
      Map<String, dynamic> data = json.decode(msg)["errors"];
      setState(() {
        message = Message.fromMap(data);
      });
    }
  }

  void _redirectTocontactUsPage() => Get.offAllNamed(contactUsPageRoute);

  void _redirectToTermsAndPolicy() =>
      Get.toNamed(termsAndPolicyRoute, arguments: 4);

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(scaffold: _getVerifyScaffold);
  }

  Scaffold get _getVerifyScaffold {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _getAppBar,
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 120),
                child: _getVerifiedColumn)));
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.offAllNamed(rootRoute),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: const Text(
          StringConst.contactUsText,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
        actions: const [],
      );

  Widget get _getVerifiedColumn {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                message.status == "DELETED"
                    ? "assets/images/account_bun.png"
                    : "assets/images/no_account.png",
                fit: BoxFit.cover,
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              message.status == "DELETED"
                  ? Text(
                      StringConst.accountArchived.tr,
                      style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      StringConst.accountEvaluation.tr,
                      style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
              const SizedBox(height: 20.0),
              message.status == "DELETED"
                  ? Text(
                      "${message.message}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: AppColors.primaryGrey,
                          fontSize: 16,
                          height: 2),
                    )
                  : Text.rich(
                      style: GoogleFonts.poppins(
                          color: AppColors.primaryGrey,
                          fontSize: 16,
                          height: 2),
                      textAlign: TextAlign.center,
                      TextSpan(children: [
                        TextSpan(text: StringConst.evaluationSubTitle),
                        TextSpan(
                            text: "link.",
                            recognizer: TapGestureRecognizer()
                              ..onTap = _redirectToTermsAndPolicy,
                            style: GoogleFonts.poppins(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline)),
                        const TextSpan(
                            text:
                                "You can try to login in after 48 hrs or click this "),
                        TextSpan(
                            text: "link",
                            recognizer: TapGestureRecognizer()
                              ..onTap = _redirectTocontactUsPage,
                            style: GoogleFonts.poppins(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline)),
                        const TextSpan(text: " to email us."),
                      ])),
            ],
          ),
        ),
        message.status == "DELETED"
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    child: CustomPrimaryButton(
                      text: 'Send Email',
                      onPressed: () => UrlLauncher.launchEmail(message.message),
                    )),
              )
            : const SizedBox(),
      ],
    );
  }
}

class Message {
  final String? message;
  final String? status;

  Message({
    this.message,
    this.status,
  });

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "status": status,
      };
}
