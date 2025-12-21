import 'package:alias/models/enums/team_name.dart';
import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Winners extends StatelessWidget {
  const Winners({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<GameFlowViewModel>();
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
            viewModel.play();
          },
        ),
      ),
    );
  }

  Widget winnersWidget(GameFlowViewModel viewModel) {
    if (viewModel.game.winners.length > 1) {
      return Column(
        children: [
          Text('Победители:'),
          for (var team in viewModel.game.winners) Text(team.name.displayName),
        ],
      );
    } else {
      return Text(viewModel.game.getCurrentTeam().name.displayName);
    }
  }
}
