import 'package:alias/models/enums/team_name.dart';
import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Winners extends StatelessWidget {
  const Winners({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<GameFlowViewModel>();
    return Scaffold(
      appBar: AppBar(),

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: winnersWidget(viewModel),
          ),
          SizedBox(height: 20),
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: viewModel.game.teams.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(viewModel.game.teams[index].name.displayName),
                  trailing: Text('${viewModel.game.teams[index].score}'),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilledButton(
          child: Text('END GAME'),
          onPressed: () {
            viewModel.deleteSavedGame();
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget winnersWidget(GameFlowViewModel viewModel) {
    var winners = viewModel.game.winners;
    if (winners.length == viewModel.game.teams.length) {
      return Text('Draw!');
    } else if (winners.length > 1) {
      return Column(
        children: [
          Text('Winners:'),
          for (var team in winners) Text(team.name.displayName),
        ],
      );
    } else {
      return Text('Winner: ${winners[0].name.displayName}');
    }
  }
}
