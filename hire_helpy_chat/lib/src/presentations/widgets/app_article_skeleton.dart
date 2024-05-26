import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class AppArticlesSkeleton extends StatefulWidget {
  final int? itemCount;
  const AppArticlesSkeleton({super.key, this.itemCount});

  @override
  AppArticlesSkeletonState createState() => AppArticlesSkeletonState();
}

class AppArticlesSkeletonState extends State<AppArticlesSkeleton> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemCount ?? 3,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildItemSkeletonArticle();
      },
    );
  }

  _buildItemSkeletonArticle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        height: 100,
        child: Stack(
          children: const [
            SkeletonContainer.rounded(),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SkeletonContainer.square(
                  width: 90,
                  height: 70,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 74),
              child: Align(
                alignment: Alignment.topCenter,
                child: SkeletonContainer.roundedSoft(
                  width: 200,
                  height: 14,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16, left: 74),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SkeletonContainer.roundedSoft(
                  color: Colors.red,
                  width: 200,
                  height: 36,
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
  }) : this._(key: key,width: width, height: height, borderRadius: borderRadius);

  const SkeletonContainer.roundedSoft({
    Key? key,
    Color? color,
    double width = double.infinity,
    double height = double.infinity,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4)),
  }) : this._(key: key,width: width, height: height, borderRadius: borderRadius);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: SkeletonAnimation(
          borderRadius: borderRadius,
          shimmerDuration: 5000,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: borderRadius,
            ),
          ),
        ),
      );
}
