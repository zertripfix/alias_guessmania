import 'package:alias/viewmodels/game_viewmodel.dart';
import 'package:alias/views/main_menu/main_menu.dart';
import 'package:alias/widgets/swipe_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/game_flow_viewmodel.dart';

class Gameplay extends StatelessWidget {
  const Gameplay({super.key});

  @override
  Widget build(BuildContext context) {
    var guessed = context.select((GameViewmodel vm) => vm.guessed);
    var skipped = context.select((GameViewmodel vm) => vm.skipped);

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
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('${context.watch<GameViewmodel>().timeLeft}'),
        centerTitle: true,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 350.0),
            child: Container(
              height: 60,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.lightGreen.withAlpha(200),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                guessed.toString(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350.0),
            child: Container(
              height: 60,
              width: 100,
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(150),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                skipped.toString(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
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
