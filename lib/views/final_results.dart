import 'package:alias/models/enums/team_name.dart';
import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinalResults extends StatelessWidget {
  const FinalResults({super.key});

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
            child: Text(viewModel.game.getCurrentTeam().name.displayName),
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
          child: Text('PLAY'),
          onPressed: () {
            viewModel.play();
          },
        ),
      ),
    );
  }
}
