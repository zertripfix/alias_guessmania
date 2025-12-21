import 'package:alias/models/enums/word_state.dart';
import 'package:alias/models/word.dart';

class Round {
  List<Word> wordsBatch;
  int currentWordIndex;
  int guessed;
  int skipped;

  Round({
    this.wordsBatch = const [],
    this.currentWordIndex = 0,
    this.guessed = 0,
    this.skipped = 0,
  });

  void reset() {
    wordsBatch = [];
    currentWordIndex = 0;
    guessed = 0;
    skipped = 0;
  }

  void setAsGuessed() {
    wordsBatch[currentWordIndex].state = WordState.guessed;
  }

  void setAsSkipped() {
    wordsBatch[currentWordIndex].state = WordState.skipped;
  }

  void setAsRemoved() {
    wordsBatch[currentWordIndex].state = WordState.removed;
  }
}
