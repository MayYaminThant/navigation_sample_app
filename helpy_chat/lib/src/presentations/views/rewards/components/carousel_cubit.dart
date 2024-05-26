import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselCard extends StatelessWidget {
  final int index;
  final String src;

  const CarouselCard({
    Key? key,
    required this.index,
    required this.src,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.select(
      (CarouselCubit c) => c.state.selectedCardIndex == index,
    );

    return Container(
      height: 170,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(src),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) => Container(
            height: 170,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isSelected ? Colors.white : Colors.grey,
                  width: 1,
                ),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade200,
                  Colors.blueGrey.shade200,
                ],
              ),
              shadows: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: -2,
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSelected ? Colors.white : Colors.grey,
            width: 1,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade200,
            Colors.blueGrey.shade200,
          ],
        ),
        shadows: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: -2,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
    );
  }
}

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit()
      : super(
          const CarouselState(selectedCardIndex: 3),
        );

  void selectCard(int cardIndex) {
    emit(CarouselState(selectedCardIndex: cardIndex));
  }
}

@immutable
class CarouselState {
  final int selectedCardIndex;

  const CarouselState({required this.selectedCardIndex});
}
