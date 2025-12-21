enum Dictionary {
  easy, hard
}

extension DictionaryExtension on Dictionary {
  String get name {
    switch (this) {
      case Dictionary.easy:
        return 'easy_dictionary';
      case Dictionary.hard:
        return 'hard_dictionary';
    }
  }

  String get displayName {
    switch (this) {
      case Dictionary.easy:
        return 'Легкий словарь';
      case Dictionary.hard:
        return 'Сложный словарь';
    }
  }
}