import 'package:alias/models/enums/word_state.dart';

class Word {
  final int id;
  final String ru, ua, en, sp;
  WordState state = WordState.unused;

  Word({required this.id, required this.ru, required this.ua, required this.en, required this.sp});

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'] as int,
      ru: map['ru'] as String,
      ua: map['ua'] as String,
      en: map['en'] as String,
      sp: map['sp'] as String,
    );
  }
}
