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
        return 'Snotty Trolls'; // Сопливые тролли
      case TeamName.smartSlimes:
        return 'Smart Slimes'; // Умные слизни
      case TeamName.dumplingsOfWisdom:
        return 'Dumplings Of Wisdom'; // Пельмешки мудрости
      case TeamName.spaceBums:
        return 'Space Bums'; // Космические бомжики
      case TeamName.bunsOfPower:
        return 'Buns Of Power'; // Пиріжечки влади | Булочки власти
      case TeamName.predatoryDandelions:
        return 'Predatory Dandelions'; //Хижі кульбабки | Хищные одуванчики
    }
  }
}
