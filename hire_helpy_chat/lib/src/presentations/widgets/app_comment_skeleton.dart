part of 'widgets.dart';

class AppCommentSkeleton extends StatefulWidget {
  const AppCommentSkeleton({super.key});

  @override
  AppCommentSkeletonState createState() => AppCommentSkeletonState();
}

class AppCommentSkeletonState extends State<AppCommentSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItemSkeletonComment,
          _buildItemSkeletonComment,
          _buildItemSkeletonComment,
          _buildItemSkeletonComment,
        ],
      ),
    );
  }

  Widget get _buildItemSkeletonComment {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      child: SizedBox(
        height: 40,
        child: Stack(
          children: const [
            SkeletonContainer.rounded(),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SkeletonContainer.circular(
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24, left: 48),
              child: Align(
                alignment: Alignment.topLeft,
                child: SkeletonContainer.roundedSoft(
                  width: 200,
                  height: 14,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6, left: 48),
              child: Align(
                alignment: Alignment.topLeft,
                child: SkeletonContainer.roundedSoft(
                  color: Colors.white,
                  width: 200,
                  height: 14,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6, right: 12),
              child: Align(
                alignment: Alignment.centerRight,
                child: SkeletonContainer.square(
                  color: Colors.white,
                  width: 20,
                  height: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const SkeletonContainer._({
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    Key? key,
  }) : super(key: key);

  const SkeletonContainer.square({
    Key? key,
    Color? color,
    double width = double.infinity,
    double height = double.infinity,
  }) : this._(key: key, width: width, height: height);

  const SkeletonContainer.rounded({
    Key? key,
    Color? color,
    double width = double.infinity,
    double height = double.infinity,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : this._(
            key: key, width: width, height: height, borderRadius: borderRadius);

  const SkeletonContainer.circular({
    Key? key,
    Color? color,
    double width = double.infinity,
    double height = double.infinity,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(80)),
  }) : this._(
            key: key, width: width, height: height, borderRadius: borderRadius);

  const SkeletonContainer.roundedSoft({
    Key? key,
    Color? color,
    double width = double.infinity,
    double height = double.infinity,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4)),
  }) : this._(
            key: key, width: width, height: height, borderRadius: borderRadius);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: SkeletonAnimation(
          borderRadius: borderRadius,
          shimmerDuration: 5000,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.28),
              borderRadius: borderRadius,
            ),
          ),
        ),
      );
}
