import 'enums/team_name.dart';

class Team {
  final TeamName name;
  int score;

  Team(this.name,{this.score = 0});

  Map<String, dynamic> toMap() {
    return {
      'name': name.name,
      'score': score,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      TeamName.values.firstWhere((e) => e.name == map['name']),
      score: map['score'],
    );
  }
}