import 'package:alias/models/enums/dictionary.dart';
import 'package:alias/models/enums/team_name.dart';
import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:alias/viewmodels/game_settings_viewmodel.dart';
import 'package:alias/widgets/dictionary_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress/step_progress.dart';


class GameSetup extends StatelessWidget {
  const GameSetup({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<GameSettingsViewModel>();
    return PopScope(
      canPop: viewModel.currentStep == 1,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && viewModel.currentStep > 1) {
          viewModel.prevStep();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: _currentStepName(viewModel),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: StepProgress(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              visibilityOptions: StepProgressVisibilityOptions.lineOnly,
              totalSteps: viewModel.totalSteps,
              currentStep: viewModel.currentStep,
              theme: const StepProgressThemeData(
                  stepLineSpacing: 6,
                  stepAnimationDuration: Duration(milliseconds: 300),
                  stepLineStyle: StepLineStyle(
                    lineThickness: 6,
                    borderRadius: Radius.circular(16.0),
                    animationDuration: Duration(milliseconds: 300),
                  )),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              if (viewModel.currentStep == 1) {
                Navigator.pop(context);
              } else {
                viewModel.prevStep();
              }
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: _buildStepContent(viewModel),
        bottomNavigationBar: viewModel.currentStep > 1
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilledButton(
                  child: Text(viewModel.currentStep < viewModel.totalSteps - 1
                      ? 'NEXT'
                      : 'PLAY'),
                  onPressed: () {
                    if (viewModel.currentStep == viewModel.totalSteps - 1) {
                      viewModel.finishSetup();
                    } else {
                      viewModel.nextStep();
                    }
                  },
                ),
              )
            : null,
      ),
    );
  }

  Widget _currentStepName(GameSettingsViewModel viewModel) {
    String name;
    switch (viewModel.currentStep) {
      case 1:
        name = 'Словари';
      case 2:
        name = 'Выбрать команды';
      case 3:
        name = 'Настройки игры';
      default:
        name = 'ХЗ че это';
    }
    return Text(name);
  }

  Widget _buildStepContent(GameSettingsViewModel viewModel) {
    switch (viewModel.currentStep) {
      case 1:
        return _buildDictionarySelection(viewModel);
      case 2:
        return _buildTeamSelection(viewModel);
      case 3:
        return _buildGameConfig(viewModel);
      default:
        return Center(child: Text('Unknown Step'));
    }
  }

  Widget _buildDictionarySelection(GameSettingsViewModel viewModel) {
    var dictionaries = Dictionary.values;
    return ListView.builder(
      itemCount: dictionaries.length,
      itemBuilder: (context, index) {
        return DictionaryCardWidget(
          dictionary: dictionaries[index],
        );
      },
    );
  }

  Widget _buildTeamSelection(GameSettingsViewModel viewModel) {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: ListView.builder(
            itemCount: viewModel.teams.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: BoxBorder.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: ListTile(
                  title: Text(viewModel.teams[index].name.displayName),
                  trailing: IconButton(
                    onPressed: () {
                      viewModel.removeTeam(index);
                    },
                    icon: Icon(Icons.cancel_outlined),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: IconButton.outlined(
            onPressed: () {
              viewModel.addTeam();
            },
            icon: Icon(Icons.add),
          ),
        )
      ],
    );
  }

  Widget _buildGameConfig(GameSettingsViewModel viewModel) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: BoxBorder.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.timer_outlined),
                title: Text('Длина раунда'),
                subtitle: Text('за которое надо отгадать слова'),
                trailing: Text(
                  '${viewModel.roundTime}',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => viewModel.roundTime -= 30,
                    child: Text('-30 сек'),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () => viewModel.roundTime += 30,
                    child: Text('+30 сек'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: BoxBorder.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.numbers_outlined),
                title: Text('Количество слов'),
                subtitle: Text('для победы'),
                trailing: Text(
                  '${viewModel.winScore}',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => viewModel.winScore -= 10,
                    child: Text('-10 слов'),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () => viewModel.winScore += 10,
                    child: Text('+10 слов'),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListTile(
          title: Text("isTasksEnabled = ${viewModel.isTasksEnabled}"),
        ),
      ],
    );
  }
}

class GameSettingsScreenWrapper extends StatelessWidget {
  const GameSettingsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameSettingsViewModel>(
      create: (_) => GameSettingsViewModel(context.read<GameFlowViewModel>()),
      child: GameSetup(),
    );
  }
}
