part of 'widgets.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: CustomImageView(imagePath: imagePath));
  }
}
