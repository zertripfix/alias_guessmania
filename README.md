# Alias GuessMania 🎮

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A modern, feature-rich mobile implementation of the classic word-guessing party game "Alias". Built with Flutter, this app brings the beloved tabletop experience to your pocket with a fresh, animated interface and thoughtful gameplay enhancements.

---

## ✨ Features

### 🎯 Current Implementation
- **Dynamic Game Flow**: Complete game lifecycle from setup to winners screen
- **Swipe-based Gameplay**: Intuitive card swiping mechanics using `flutter_card_swiper`
- **Multiple Dictionaries**: Easy and Hard word packs (more to come!)
- **Flexible Team Management**: Create custom teams with fun, generated names
- **Round Timer**: Countdown timer for each round with auto-transition
- **Score Tracking**: Real-time score updates with guessed/skipped counters
- **Round Results Review**: Post-round screen to adjust word states (guessed/skipped/removed)
- **Game Save/Load**: Persistent game state using SQLite and SharedPreferences
- **Bouncy Buttons**: Engaging haptic-like animations with `bouncy_button` package

### 🏗️ Architecture Highlights
- **Provider State Management**: Clean separation of UI and business logic with `ChangeNotifier`
- **Modular MVVM Pattern**: ViewModels handle game logic, Models store data, Views render UI
- **Database Integration**: SQLite for word storage, JSON import from assets
- **Step-by-step Setup**: Multi-step configuration wizard with progress tracking

---

## 🚀 Roadmap

### 📋 Short-term Goals
- [ ] **UI Polish**: Implement custom designs for a premium feel
- [ ] **Multi-language Support**: Russian, Ukrainian, English, Spanish
- [ ] **Monster Companions**: Animated creatures that react to gameplay

### 🔮 Future Enhancements
- **Monster Interaction System**: 
  - Pets that react to correct/incorrect answers
  - Customizable monster skins and animations
  - Toggleable in settings (on/off)
- **Advanced Localization**: Full app translation in 4 languages
- **Sound Effects & Music**: Immersive audio feedback
- **Statistics Dashboard**: Track team performance over time
- **Custom Dictionary Builder**: Create and share word packs

---

## 🎮 How to Play

1. **Start a New Game** from the main menu
2. **Choose Dictionary** (Easy or Hard mode)
3. **Select Teams** (minimum 2 teams)
4. **Configure Round Settings** (time limit, win score)
5. **Play!** 
   - Swipe **UP** for guessed words
   - Swipe **DOWN** for skipped words
   - Complete words before timer runs out
6. **Review Round Results** - adjust word states if needed
7. **Continue** until a team reaches the win score

---

## 🛠️ Built With

| Package | Purpose |
|---------|---------|
| [Flutter](https://flutter.dev) | UI Framework |
| [Provider](https://pub.dev/packages/provider) | State Management |
| [SQFlite](https://pub.dev/packages/sqflite) | Local Database |
| [SharedPreferences](https://pub.dev/packages/shared_preferences) | Simple Storage |
| [flutter_card_swiper](https://pub.dev/packages/flutter_card_swiper) | Card Animations |
| [bouncy_button](https://pub.dev/packages/bouncy_button) | Interactive Buttons |
| [google_fonts](https://pub.dev/packages/google_fonts) | Custom Typography |
| [path](https://pub.dev/packages/path) | File Path Handling |

---

## 📱 Screenshots

Coming soon!
🏗️ UI redesign in progress

---

## 🤝 Contributing

This is a personal pet project, but feel free to fork and experiment! If you have ideas for improvements or find bugs, please open an issue.

### Development Phases

- 🔴 **Phase 1**: Core gameplay ✓
- 🟡 **Phase 2**: UI/UX Polish (In Progress)
- 🟢 **Phase 3**: Multi-language Support
- 🔵 **Phase 4**: Monster Features
- 🟣 **Phase 5**: Play Store Release

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Inspired by the classic Alias board game
- Word dictionaries compiled from various open sources
- Thanks to the Flutter community for amazing packages
- Special thanks to all contributors and testers

---

## 📬 Contact

- **GitHub**: [@zertripfix](https://github.com/zertripfix)
- **Email**: zertripfix@gmail.com
  
---

**Built with ❤️ and ☕ in Flutter**
