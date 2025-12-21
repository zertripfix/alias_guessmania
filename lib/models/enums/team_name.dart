enum TeamName {
  snottyTrolls,
  smartSlimes,
  dumplingsOfWisdom,
  spaceBums,
  bunsOfPower,
  predatoryDandelions,
}

extension TeamNameExtension on TeamName {
  String get displayName {
    switch (this) {
      case TeamName.snottyTrolls:
        return 'Сопливые тролли';
      case TeamName.smartSlimes:
        return 'Умные слизни';
      case TeamName.dumplingsOfWisdom:
        return 'Пельмешки мудрости';
      case TeamName.spaceBums:
        return 'Космические бомжики';
      case TeamName.bunsOfPower:
        return 'Булочки власти'; //Пиріжечки влади
      case TeamName.predatoryDandelions:
        return 'Хищные одуванчики'; //Хижі кульбабки
    }
  }
}
