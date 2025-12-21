import 'enums/team_name.dart';

class Team {
  final TeamName name;
  int score;

  Team(this.name,{this.score = 0});

  // Serialize team to save it
  Map<String, dynamic> toMap() {
    return {
      'name': name.name,
      'score': score,
    };
  }

  // Deserialize team to restore it
  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      TeamName.values.firstWhere((e) => e.name == map['name']),
      score: map['score'],
    );
  }
}