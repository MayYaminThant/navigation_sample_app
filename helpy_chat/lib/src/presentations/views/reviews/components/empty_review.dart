part of '../../views.dart';

class EmptyReview extends StatefulWidget {
  const EmptyReview({super.key});

  @override
  State<EmptyReview> createState() => _EmptyReviewState();
}

class _EmptyReviewState extends State<EmptyReview> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 204,
              height: 204,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/no_review.png"))),
            ),
            Text(StringConst.noReviews.tr,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(StringConst.noReviewsBody.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      height: 2.5,
                      fontSize: 15,
                      color: const Color(0xFFBEBEBE),
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
