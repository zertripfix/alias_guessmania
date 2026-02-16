import 'package:alias/models/enums/game_state.dart';
import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:alias/views/game_setup.dart';
import 'package:alias/views/final_results.dart';
import 'package:alias/views/round_results.dart';
import 'package:alias/views/winners.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gameplay.dart';

class GameFlowNavigator extends StatelessWidget {
  const GameFlowNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select<GameFlowViewModel, GameState>(
      (vm) => vm.gameState,
    );

    switch (state) {
      case GameState.settings:
        return GameSettingsScreenWrapper();
      case GameState.results:
        return FinalResults();
      case GameState.playing:
        return GameScreenWrapper();
      case GameState.roundResults:
        return RoundResultsWrapper();
      case GameState.winners:
        return Winners();
    }
  }
}
