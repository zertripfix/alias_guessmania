import 'package:alias/models/enums/word_state.dart';
import 'package:alias/viewmodels/round_results_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordStateButtonWidget extends StatelessWidget {
  final int index;
  final WordState buttonState;

  const WordStateButtonWidget({
    super.key,
    required this.index,
    required this.buttonState,
  });

  @override
  Widget build(BuildContext context) {
    final wordState = context.select(
      (RoundResultsViewmodel vm) => vm.words[index].state,
    );
    final isActive = wordState == buttonState;
    final circleColor = isActive ? _activeColor(buttonState) : Colors.grey;
    final icon = _iconForState(buttonState);

    return GestureDetector(
      onTap: () => context.read<RoundResultsViewmodel>().setWordState(index, buttonState),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(shape: BoxShape.circle, color: circleColor),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Color _activeColor(WordState buttonState) {
    switch (buttonState) {
      case WordState.guessed:
        return Colors.green;
      case WordState.skipped:
        return Colors.red;
      case WordState.removed:
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  IconData _iconForState(WordState state) {
    switch (state) {
      case WordState.guessed:
        return Icons.check;
      case WordState.skipped:
        return Icons.close;
      case WordState.removed:
        return Icons.delete_outline;
      default:
        return Icons.help_outline;
    }
  }
}
