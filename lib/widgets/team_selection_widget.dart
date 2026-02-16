import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_settings_viewmodel.dart';
import '../models/enums/team_name.dart';

class TeamSelectionWidget extends StatelessWidget {
  const TeamSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<GameSettingsViewModel>();

    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: ListView.builder(
            itemCount: viewModel.teams.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: BoxBorder.all(color: Colors.grey, width: 2),
                ),
                child: ListTile(
                  title: Text(viewModel.teams[index].name.displayName),
                  trailing: IconButton(
                    onPressed: () {
                      viewModel.removeTeam(index);
                    },
                    icon: const Icon(Icons.cancel_outlined),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton.outlined(
            onPressed: () {
              viewModel.addTeam();
            },
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
