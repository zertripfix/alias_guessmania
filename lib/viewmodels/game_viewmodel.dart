import 'dart:async';

import 'package:alias/models/word.dart';
import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:flutter/material.dart';

class GameViewmodel extends ChangeNotifier {
  GameViewmodel(this.gameFlowVM) {
    loadInitialWords();
  }

  final GameFlowViewModel gameFlowVM;
  bool showInitialCard = true;
  Timer? _timer;
  int _timeLeft = 0;

  int get guessed => gameFlowVM.round.guessed;
  int get skipped => gameFlowVM.round.skipped;
  int get timeLeft => _timeLeft;
  bool get isTimerRunning => _timer != null && _timer!.isActive;
  List<Word> get words => gameFlowVM.round.wordsBatch;
  int get currentWordIndex => gameFlowVM.round.currentWordIndex;
  String get currentWord => words[currentWordIndex].ru;

  Future<void> startGame() async {
    if (showInitialCard) {
      showInitialCard = false;
      startTimer();
      notifyListeners();
    }
  }

  void startTimer() {
    _timeLeft = gameFlowVM.game.roundTime;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        timer.cancel();
        gameFlowVM.showRoundResults();
      }
    });
  }

  Future<void> loadInitialWords() async {
    await gameFlowVM.loadInitialWords();
  }

  Future<void> loadMoreWords() async {
    gameFlowVM.loadMoreWords();
  }

  Future<void> nextWord() async {
    gameFlowVM.nextWord();
  }

  void setAsGuessed() {
    gameFlowVM.round.guessed++;
    gameFlowVM.round.setAsGuessed();
    notifyListeners();
  }

  void setAsSkipped() {
    gameFlowVM.round.skipped++;
    gameFlowVM.round.setAsSkipped();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
