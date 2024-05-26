part of 'widgets.dart';

class SocialLoginWidget extends StatefulWidget {
  const SocialLoginWidget({super.key, required this.isSignIn, this.referCode});
  final bool isSignIn;
  final String? referCode;
  

  @override
  State<SocialLoginWidget> createState() => _SocialLoginWidgetState();
}

class _SocialLoginWidgetState extends State<SocialLoginWidget> {
  String language = '';
  String country = '';
  String fcmToken = '';

  @override
  void initState() {
    super.initState();
    _getLocalData();
    firebaseTokenListener();
  }

  firebaseTokenListener() {
    try {
      iosPermission();
      firebaseMessaging.getToken().then((token) {
        if (token != null) {
          setState(() {
            fcmToken = token;
          });
        }
      });
    } catch (e) {
      superPrint(e);
    }
  }

  Future<void> _getLocalData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      language = box.get(DBUtils.language) ?? '';
      country = box.get(DBUtils.country) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getSocialLogin;
  }

  Widget get _getSocialLogin {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _signWithGoogle(),
          child: _getSocialLoginItem('assets/icons/google.png'),
        ),
        Platform.isIOS
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: GestureDetector(
                  onTap: () => _signInWithApple(),
                  child: _getSocialLoginItem('assets/icons/apple.png'),
                ),
              )
            : const SizedBox(
                width: 20,
              ),
        GestureDetector(
          onTap: () => _signWithFacebook(),
          child: _getSocialLoginItem('assets/icons/facebook.png'),
        ),
      ],
    );
  }

  OutlineGradientButton _getSocialLoginItem(String logo) =>
      OutlineGradientButton(
        strokeWidth: 1.0,
        gradient: LinearGradient(
          begin: const Alignment(
            1.03,
            -0.19,
          ),
          end: const Alignment(
            -0.08,
            0.72,
          ),
          colors: [
            AppColors.deepOrange200,
            AppColors.indigoA100Da,
            AppColors.pink50,
          ],
        ),
        corners: const Corners(
          topLeft: Radius.circular(
            10,
          ),
          topRight: Radius.circular(
            10,
          ),
          bottomLeft: Radius.circular(
            10,
          ),
          bottomRight: Radius.circular(
            10,
          ),
        ),
        child: CustomIconButton(
          height: 43,
          width: 43,
          //margin: const EdgeInsets.all(4.0),
          child: CustomImageView(
            image: logo,
          ),
        ),
      );

  Future<void> _signWithGoogle() async {
    k_firebase_user.User? user =
        await Authentication.signInWithGoogle(context: context);

    widget.isSignIn
        ? _candidateSocialLogin(provider: 'google', userId: user!.uid)
        : _registerAccount(
            provider: 'google',
            userId: user!.uid,
            email: user.email ?? '',
            firstName: user.displayName!.split(' ')[0],
            lastName: user.displayName!.split(' ')[1]);
    // ignore: use_build_context_synchronously
    Authentication.signOut(context: context);
  }

  Future<void> _signWithFacebook() async {
    Map user = await Authentication.signInWithFaceBook(context: context) as Map;
    if (user.isNotEmpty) {
      widget.isSignIn
          ? _candidateSocialLogin(provider: 'facebook', userId: user['id'])
          : _registerAccount(
              provider: 'facebook',
              userId: user['id'],
              email: user['email'] ?? '',
              firstName: user['name'].split(' ')[0],
              lastName: user['name'].split(' ')[1]);
    }
  }

  void _candidateSocialLogin(
      {required String provider, required String userId}) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateSocialLoginRequestParams params =
        CandidateSocialLoginRequestParams(
      provider: provider,
      userId: userId,
      fcmToken: fcmToken
    );
    candidateBloc.add(CandidateSocialLoginRequested(params: params));
  }

  void _registerAccount(
      {required String provider,
      required String userId,
      required String email,
      required String firstName,
      required String lastName}) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateSocialRegisterRequestParams params =
        CandidateSocialRegisterRequestParams(
            provider: provider,
            userId: userId,
            email: email,
            firstName: firstName,
            lastName: lastName,
            appLocale: country,
            preferredLanguage: language,
            referCode: widget.referCode);
    candidateBloc.add(CandidateSocialRegisterRequested(params: params));
  }

  Future<void> _signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    widget.isSignIn
        ? _candidateSocialLogin(
            provider: 'apple', userId: credential.userIdentifier!)
        : _registerAccount(
            provider: 'apple',
            userId: credential.userIdentifier ?? '',
            email: credential.email ?? '',
            firstName: credential.givenName ?? '',
            lastName: credential.familyName ?? '',
          );
  }
}
