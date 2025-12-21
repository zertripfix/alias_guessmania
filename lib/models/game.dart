import 'dart:convert';

import 'package:alias/models/enums/dictionary.dart';
import 'package:alias/models/game_settings.dart';
import 'package:alias/models/team.dart';

class Game {
  int winScore;
  int roundTime;
  bool isTasksEnabled;
  Dictionary dictionary;
  int currentTeamIndex;
  List<Team> teams;
  List<Team> winners;


  Game({
    this.winScore = 30,
    this.roundTime = 60,
    this.isTasksEnabled = false,
    this.currentTeamIndex = 0,
    this.dictionary = Dictionary.easy,
    this.teams = const [],
    this.winners = const [],
  });

  void setup(GameSettings settings) {
    winScore = settings.winScore;
    roundTime = settings.roundTime;
    isTasksEnabled = settings.isTasksEnabled;
    dictionary = settings.dictionary;
    teams = settings.teams;
  }

  Team getCurrentTeam() {
    return teams[currentTeamIndex];
  }

  void setNextTeamIndex() {
    if(currentTeamIndex+1 <= teams.length - 1) {
      currentTeamIndex++;
    } else {
      currentTeamIndex = 0;
    }
  }

  // Serialize game state to save it
  Map<String, dynamic> toMap() {
    return {
      'winScore': winScore,
      'roundTime': roundTime,
      'isTasksEnabled': isTasksEnabled,
      'dictionary': dictionary.name,
      'nextTeamIndex': currentTeamIndex,
      'teams': teams.map((team) => team.toMap()).toList(),
    };
  }

  /// Deserialize game state to restore it. Note: wordsBatch and currentWordIndex are not restored here.
  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      winScore: map['winScore'],
      roundTime: map['roundTime'],
      isTasksEnabled: map['isTasksEnabled'],
      dictionary: Dictionary.values.firstWhere(
        (d) => d.name == map['dictionary'],
      ),
      currentTeamIndex: map['nextTeamIndex'],
      teams: List<Team>.from(map['teams']?.map((x) => Team.fromMap(x))),
    );
  }

  String toJson() => jsonEncode(toMap());
  factory Game.fromJson(String source) => Game.fromMap(jsonDecode(source));

  void loadFrom(Game savedData) {
    winScore = savedData.winScore;
    roundTime = savedData.roundTime;
    isTasksEnabled = savedData.isTasksEnabled;
    dictionary = savedData.dictionary;
    currentTeamIndex = savedData.currentTeamIndex;
    teams = savedData.teams;
  }
}
