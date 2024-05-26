import 'package:dh_employer/src/config/routes/routes.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EmptyArticlePage extends StatefulWidget {
  const EmptyArticlePage({super.key});

  @override
  State<EmptyArticlePage> createState() => _EmptyArticlePageState();
}

class _EmptyArticlePageState extends State<EmptyArticlePage> {
  @override
  Widget build(BuildContext context) {
    return _getEmptyScaffold;
  }

  Scaffold get _getEmptyScaffold {
    return Scaffold(
      body: SafeArea(top: false, child: _getEmptyArticleContainer),
    );
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Get.offAllNamed(homePageRoute);
          },
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.articleTitle.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w200),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
      );

  Widget get _getEmptyArticleContainer {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill)),
      child: Column(
        children: [
          _getAppBar,
          const SizedBox(
            height: 50,
          ),
          const Image(image: AssetImage('assets/images/no-article.png')),
          const SizedBox(
            height: 50,
          ),
          Column(
            children: [
              const Text('Opps! Invalid Article ...',
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 20,
              ),
              _emptyArticleText
            ],
          )
        ],
      ),
    );
  }

  Widget get _emptyArticleText {
    return Column(
      children: [
        const Text(
          'The Article you are looking for has been',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'deleted.',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Worry not, we have more in store. You will be',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'redirected to the Article page in 7 seconds. ',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
            text: TextSpan(children: [
          const TextSpan(
            text: 'Or you can click on this',
            style: TextStyle(
                fontSize: 15,
                color: AppColors.primaryGrey,
                fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: ' link ',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.offAllNamed(articlesListPageRoute);
              },
            style: const TextStyle(
                fontSize: 15,
                color: AppColors.skyBlue,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline),
          ),
          const TextSpan(
            text: ' to redirect to ',
            style: TextStyle(
                fontSize: 15,
                color: AppColors.primaryGrey,
                fontWeight: FontWeight.w400),
          )
        ])),
        const SizedBox(height: 10),
        const Text(
          'Article page immediately. ',
          style: TextStyle(
              fontSize: 15,
              color: AppColors.primaryGrey,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
