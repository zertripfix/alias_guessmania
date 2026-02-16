import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';

class GameTimerWidget extends StatelessWidget {
  const GameTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timeLeft = context.select<GameViewmodel, int>((vm) => vm.timeLeft);
    return Text(
      '$timeLeft',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
