import 'package:alias/models/enums/word_state.dart';
import 'package:alias/models/word.dart';
import 'package:alias/widgets/word_state_button_widget.dart';
import 'package:flutter/material.dart';

class WordTile extends StatelessWidget {
  final Word word;
  final int index;
  const WordTile({super.key, required this.word, required this.index});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: Text(word.ua),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          WordStateButtonWidget(index: index, buttonState: WordState.guessed),
          WordStateButtonWidget(index: index, buttonState: WordState.skipped),
          WordStateButtonWidget(index: index, buttonState: WordState.removed),
        ],
      ),
    );
  }
}
