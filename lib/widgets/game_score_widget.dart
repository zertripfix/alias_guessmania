import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';
import '../models/enums/word_state.dart';

class GameScoreWidget extends StatelessWidget {
  final WordState state;

  const GameScoreWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final score = context.select<GameViewmodel, int>((vm) {
      if (state == WordState.guessed) return vm.guessed;
      if (state == WordState.skipped) return vm.skipped;
      return 0;
    });

    final color = state == WordState.guessed
        ? Colors.lightGreen.withAlpha(200)
        : Colors.red.withAlpha(150);

    return Container(
      height: 60,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        score.toString(),
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
