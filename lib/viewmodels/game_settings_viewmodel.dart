import 'package:alias/models/enums/dictionary.dart';
import 'package:alias/models/game_settings.dart';
import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:flutter/cupertino.dart';

import '../models/enums/team_name.dart';
import '../models/team.dart';

class GameSettingsViewModel extends ChangeNotifier {
  GameSettingsViewModel(this.gameFlowVM);

  final GameFlowViewModel gameFlowVM;
  GameSettings settings = GameSettings();

  int get winScore => settings.winScore;
  int get roundTime => settings.roundTime;
  bool get isTasksEnabled => settings.isTasksEnabled;
  Dictionary get dictionary => settings.dictionary;
  List<Team> get teams => settings.teams;

  set winScore(int value) {
    if (value > 0 && value <= 300) {
      settings.winScore = value;
      notifyListeners();
    }
  }

  set roundTime(int value) {
    if (value > 0 && value <= 300) {
      settings.roundTime = value;
      notifyListeners();
    }
  }

  set dictionary(Dictionary value) {
    settings.dictionary = value;
    notifyListeners();
  }

  int _currentStep = 1;
  int get currentStep => _currentStep;
  final int totalSteps = 4;

  void nextStep() {
    if (_currentStep < totalSteps - 1) {
      _currentStep++;
      notifyListeners();
    }
  }

  void prevStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  TeamName getRandomTeamName() {
    return List.of(
      TeamName.values,
    ).firstWhere((e) => !settings.teams.map((team) => team.name).contains(e));
  }

  void addTeam() {
    if (TeamName.values.length - 1 >= settings.teams.length) {
      settings.teams.add(Team(getRandomTeamName()));
      notifyListeners();
    }
  }

  void removeTeam(int index) {
    if (settings.teams.length > 2) {
      settings.teams.removeAt(index);
      notifyListeners();
    }
  }

  void finishSetup() {
    gameFlowVM.startGameWithSettings(settings);
  }
}
