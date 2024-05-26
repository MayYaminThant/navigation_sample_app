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

  @override
  void initState() {
    super.initState();
    _getLocalData();
  }

  _getLocalData() async {
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
        Platform.isIOS ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: GestureDetector(
              onTap: () => _signInWithApple(),
              child: _getSocialLoginItem('assets/icons/apple.png'),
            ),
          ): const SizedBox(
                width: 20,
              ),
        GestureDetector(
          onTap: () => _signWithFacebook(),
          child: _getSocialLoginItem('assets/icons/facebook.png'),
        ),
      ],
    );
  }

  _getSocialLoginItem(String logo) {
    return OutlineGradientButton(
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
          imagePath: logo,
        ),
      ),
    );
  }

  _signWithGoogle() async {
    kFirebaseUser.User? user =
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

  _signWithFacebook() async {
    Map user = await Authentication.signInWithFaceBook(context: context) as Map;
    if(user.isNotEmpty){
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

  _candidateSocialLogin({required String provider, required String userId}) {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerSocialLoginRequestParams params =
        EmployerSocialLoginRequestParams(
      provider: provider,
      userId: userId,
    );
    candidateBloc.add(EmployerSocialLoginRequested(params: params));
  }

  _registerAccount(
      {required String provider,
      required String userId,
      required String email,
      required String firstName,
      required String lastName}) {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerSocialRegisterRequestParams params =
        EmployerSocialRegisterRequestParams(
      provider: provider,
      userId: userId,
      email: email,
      firstName: firstName,
      lastName: lastName,
      referCode: widget.referCode,
      appLocale: country,
      preferredLanguage: language,
    );
    candidateBloc.add(EmployerSocialRegisterRequested(params: params));
  }

  _signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    widget.isSignIn
        ? _candidateSocialLogin(provider: 'apple', userId: credential.userIdentifier!)
        : _registerAccount(
            provider: 'apple',
            userId: credential.userIdentifier ?? '',
            email: credential.email ?? '',
            firstName: credential.givenName ?? '',
            lastName: credential.familyName ?? '');
  }
}
