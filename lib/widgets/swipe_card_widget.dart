import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';

class SwipeCardWidget extends StatefulWidget {
  const SwipeCardWidget({super.key});

  @override
  State<SwipeCardWidget> createState() => _SwipeCardWidgetState();
}

class _SwipeCardWidgetState extends State<SwipeCardWidget> {
  final controller = CardSwiperController();
  bool isTopCardChanged = true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var gameViewModel = context.read<GameViewmodel>();
    final showInitialCard = context.select<GameViewmodel, bool>(
      (vm) => vm.showInitialCard,
    );

    return CardSwiper(
      controller: controller,
      cardsCount: 2,
      scale: 0.7,
      padding: const EdgeInsets.all(24.0),
      backCardOffset: const Offset(0, 0),
      duration: const Duration(milliseconds: 300),
      onSwipe: (previousIndex, currentIndex, direction) async {
        if (gameViewModel.showInitialCard) {
          gameViewModel.startGame();
        } else {
          bool isUp = direction == CardSwiperDirection.top;

          if (isUp) {
            // Добавить очки за свайп вверх
            gameViewModel.setAsGuessed();
          } else {
            // Вычесть очки за свайп вниз
            gameViewModel.setAsSkipped();
          }

          await gameViewModel.nextWord();
          isTopCardChanged = !isTopCardChanged;
        }
        return true;
      },
      allowedSwipeDirection: const AllowedSwipeDirection.only(
        up: true,
        down: true,
      ),
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
        if (showInitialCard && index == 0) {
          // Стартовая карточка
          return CardContainer(
            child: const Text(
              'Swipe up or down,\nto start!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        } else {
          final String? word =
              index == 0 && !isTopCardChanged && !showInitialCard ||
                  index == 1 && isTopCardChanged && !showInitialCard
              ? gameViewModel.currentWord
              : null;

          return CardContainer(
            child: word != null
                ? Text(
                    word,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          );
        }
      },
    );
  }
}

class CardContainer extends StatelessWidget {
  final Widget? child;

  const CardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
