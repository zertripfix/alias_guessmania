import 'dart:math';

import 'package:alias/models/enums/dictionary.dart';
import 'package:alias/models/enums/team_name.dart';
import 'package:alias/models/team.dart';
import 'package:alias/models/word.dart';

class GameSettings {
  int winScore;
  int roundTime;
  bool isTasksEnabled;
  Dictionary dictionary;
  late final List<Team> teams;

  List<Word> wordsBatch;

  GameSettings({
    this.winScore = 30,
    this.roundTime = 60,
    this.isTasksEnabled = false,
    this.wordsBatch = const [],
    this.dictionary = Dictionary.easy,
  }) {
    teams = _getInitialTeams();
  }

  List<Team> _getInitialTeams() {
    var list = List.of(TeamName.values);
    list.shuffle(Random());
    return [Team(list[0]), Team(list[1])];
  }




}
