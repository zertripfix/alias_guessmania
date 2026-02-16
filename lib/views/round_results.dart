import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:alias/viewmodels/round_results_viewmodel.dart';
import 'package:alias/widgets/word_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoundResults extends StatelessWidget {
  const RoundResults({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RoundResultsViewmodel>();
    // final words = viewModel.playedWords;

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.currentTeamName),
        centerTitle: true,
        actions: [
          Consumer<RoundResultsViewmodel>(
            builder: (context, vm, _) => Text('${vm.score}'),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 32),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<RoundResultsViewmodel>(
              builder: (context, vm, child) {
                return ListView.builder(
                  itemCount: vm.playedWords.length,
                  itemBuilder: (context, index) {
                    final word = vm.playedWords[index];
                    return WordTile(word: word, index: index);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilledButton(
          child: Text('NEXT'),
          onPressed: () {
            viewModel.saveScore();
          },
        ),
      ),
    );
  }
}

class RoundResultsWrapper extends StatelessWidget {
  const RoundResultsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoundResultsViewmodel>(
      create: (_) => RoundResultsViewmodel(context.read<GameFlowViewModel>()),
      child: const RoundResults(),
    );
  }
}
