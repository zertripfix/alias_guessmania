import 'package:alias/models/enums/team_name.dart';
import 'package:alias/models/enums/word_state.dart';
import 'package:alias/models/word.dart';
import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:flutter/material.dart';

class RoundResultsViewmodel extends ChangeNotifier {
  RoundResultsViewmodel(this.gameFlowVM) {
    updateScore();
  }

  final GameFlowViewModel gameFlowVM;
  int _score = 0;
  int get score => _score;
  List<Word> get words => gameFlowVM.round.wordsBatch;
  String get currentTeamName =>
      gameFlowVM.game.teams[gameFlowVM.game.currentTeamIndex].name.displayName;

  void updateScore() {
    _score = 0;
    for (var word in words) {
      if (word.state == WordState.guessed) {
        _score++;
      }
      if (word.state == WordState.skipped) {
        _score--;
      }
    }
    notifyListeners();
  }

  List<Word> get playedWords =>
      words.where((word) => word.state != WordState.unused).toList();

  void setWordState(int index, WordState newState) {
    words[index].state = newState;
    updateScore();
  }

  void saveScore() {
    gameFlowVM.game.teams[gameFlowVM.game.currentTeamIndex].score += _score;
    if(gameFlowVM.checkWin()) return;
    gameFlowVM.game.setNextTeamIndex();
    gameFlowVM.showResults();
  }
}
