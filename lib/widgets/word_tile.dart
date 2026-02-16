import 'package:alias/models/enums/word_state.dart';
import 'package:alias/models/word.dart';
import 'package:alias/viewmodels/round_results_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordTile extends StatelessWidget {
  final Word word;
  final int index;
  const WordTile({super.key, required this.word, required this.index});

    Color _circleColorForState(WordState current, WordState buttonState) {
    if (current == buttonState) {
      switch (buttonState) {
        case WordState.guessed:
          return Colors.green;
        case WordState.skipped:
          return Colors.red;
        case WordState.removed:
          return Colors.amber; // yellow-ish
        default:
          return Colors.grey;
      }
    }
    return Colors.grey.shade400; // inactive circle color
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

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RoundResultsViewmodel>();

    void toggle(WordState target) {
      final newState = (word.state == target) ? WordState.unused : target;
      viewModel.setWordState(index, newState);
    }

    Widget buildCircleButton(WordState buttonState) {
      final circleColor = _circleColorForState(word.state, buttonState);
      final icon = _iconForState(buttonState);

      return GestureDetector(
        onTap: () => toggle(buttonState),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColor,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      );
    }

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: Text(word.ua),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildCircleButton(WordState.guessed),
          buildCircleButton(WordState.skipped),
          buildCircleButton(WordState.removed),
        ],
      ),
    );
  }
}
