import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ContinueWithSocial extends StatelessWidget {
  const ContinueWithSocial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      ContinueWithWidget(),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: SocialLoginWidget(isSignIn: true)),
    ]);
  }
}
