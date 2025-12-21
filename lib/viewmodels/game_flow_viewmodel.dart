import 'package:alias/models/game_settings.dart';
import 'package:alias/models/round.dart';
import 'package:alias/services/database_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/game.dart';
import 'enums/game_state.dart';

class GameFlowViewModel extends ChangeNotifier {
  final DatabaseService _db;
  final Game _game = Game();
  final Round _round = Round();
  GameState _gameState = GameState.settings;

  GameState get gameState => _gameState;
  Game get game => _game;
  Round get round => _round;
  bool hasSavedGame = false;

  GameFlowViewModel(this._db) {
    initialize();
  }

  Future<void> initialize() async {
    await _db.init();
    await checkSavedGame();
  }

  void checkWin() {
    if (game.currentTeamIndex == game.teams.length - 1) {
      game.winners = game.teams
          .where((team) => team.score >= game.winScore)
          .toList();
      _transitionTo(GameState.winners);
    }
  }

  void play() {
    _transitionTo(GameState.playing);
  }

  void showRoundResults() {
    _transitionTo(GameState.roundResults);
  }

  void showResults() {
    saveCurrentGame();
    _transitionTo(GameState.results);
  }

  void _transitionTo(GameState s) {
    _gameState = s;
    notifyListeners();
  }

  /// Start game, show Results screen, load initial words
  void startGameWithSettings(GameSettings settings) {
    _game.setup(settings);
    showResults();
  }

  Future<void> nextWord() async {
    _round.currentWordIndex++;

    if (_round.currentWordIndex >= _round.wordsBatch.length - 2) {
      await loadMoreWords();
    }
    notifyListeners();
  }

  Future<void> loadMoreWords() async {
    _round.wordsBatch.addAll(await _db.getSomeUnusedWords(_game.dictionary));
    notifyListeners();
  }

  Future<void> loadInitialWords() async {
    _round.reset();
    _round.wordsBatch = (await _db.getSomeUnusedWords(_game.dictionary));
    notifyListeners();
  }

  Future<void> loadSavedGame() async {
    try {
      Game savedData = await _db.loadSave();
      _game.loadFrom(savedData);
      showResults();
    } on Exception catch (e) {
      _transitionTo(GameState.settings);
      debugPrint('Error loading saved game: $e');
    }
  }

  Future<void> saveCurrentGame() async {
    await _db.saveGame(_game);
    hasSavedGame = true;
    notifyListeners();
  }

  Future<bool> checkSavedGame() async {
    hasSavedGame = await _db.hasSave();
    notifyListeners();
    return hasSavedGame;
  }

  Future<void> deleteSavedGame() async {
    await _db.deleteSave();
    _round.reset();
    hasSavedGame = false;
    notifyListeners();
    _transitionTo(GameState.settings);
  }
}
