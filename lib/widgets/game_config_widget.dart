import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_settings_viewmodel.dart';

class GameConfigWidget extends StatelessWidget {
  const GameConfigWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<GameSettingsViewModel>();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: BoxBorder.all(color: Colors.grey, width: 2),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.timer_outlined),
                title: const Text('Round time'),
                subtitle: const Text('to guess words'),
                trailing: Text('${viewModel.roundTime}'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => viewModel.roundTime -= 30,
                    child: const Text('-30 sec'),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () => viewModel.roundTime += 30,
                    child: const Text('+30 sec'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: BoxBorder.all(color: Colors.grey, width: 2),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.numbers_outlined),
                title: const Text('Number of words'),
                subtitle: const Text('to win'),
                trailing: Text('${viewModel.winScore}'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => viewModel.winScore -= 10,
                    child: const Text('-10 words'),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () => viewModel.winScore += 10,
                    child: const Text('+10 words'),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListTile(title: Text("isTasksEnabled = ${viewModel.isTasksEnabled}")),
      ],
    );
  }
}
