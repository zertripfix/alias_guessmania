import 'package:alias/models/enums/word_state.dart';
import 'package:alias/viewmodels/game_viewmodel.dart';
import 'package:alias/views/main_menu.dart';
import 'package:alias/widgets/game_score_widget.dart';
import 'package:alias/widgets/game_timer_widget.dart';
import 'package:alias/widgets/swipe_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/game_flow_viewmodel.dart';

class Gameplay extends StatelessWidget {
  const Gameplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MainMenu()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const GameTimerWidget(),
        centerTitle: true,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 350.0),
            child: const GameScoreWidget(state: WordState.guessed),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350.0),
            child: const GameScoreWidget(state: WordState.skipped),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(height: 300, width: 250, child: SwipeCardWidget()),
          ),
        ],
      ),
    );
  }
}

class GameScreenWrapper extends StatelessWidget {
  const GameScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameViewmodel>(
      create: (_) => GameViewmodel(context.read<GameFlowViewModel>()),
      child: Gameplay(),
    );
  }
}
