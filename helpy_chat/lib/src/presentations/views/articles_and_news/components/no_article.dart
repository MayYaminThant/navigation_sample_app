import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NoArticle extends StatelessWidget {
  const NoArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/no_article.png"),
          Column(
            children: [
              Text(
                "Opps! Invalid Article ...",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("The Article you are looking for has been deleted.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryGrey,
                        height: 2.5)),
              ),
              Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(children: [
                    TextSpan(
                        text:
                            "Worry not, we have more in store. You will be redirected to the Article page in 7 seconds. Or you can click on this ",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primaryGrey,
                            height: 2.5)),
                    TextSpan(
                        text: "link",
                        recognizer: TapGestureRecognizer()
                          ..onTap = _redirectToArticle,
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xFF03CBFB),
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic,
                            height: 2.5)),
                    TextSpan(
                        text: " to redirect to Article page immediately.",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primaryGrey,
                            height: 2.5))
                  ])),
            ],
          )
        ],
      ),
    );
  }

  void _redirectToArticle() => Get.offAllNamed(articlesListPageRoute);
}
