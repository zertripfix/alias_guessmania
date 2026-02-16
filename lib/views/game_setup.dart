import 'package:alias/models/enums/dictionary.dart';

import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:alias/viewmodels/game_settings_viewmodel.dart';
import 'package:alias/widgets/dictionary_card_widget.dart';
import 'package:alias/widgets/game_config_widget.dart';
import 'package:alias/widgets/team_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress/step_progress.dart';

class GameSetup extends StatelessWidget {
  const GameSetup({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<GameSettingsViewModel>();
    return PopScope(
      canPop: viewModel.currentStep == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && viewModel.currentStep > 0) {
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
                ),
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              if (viewModel.currentStep == 0) {
                Navigator.pop(context);
              } else {
                viewModel.prevStep();
              }
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: _buildStepContent(viewModel),
        bottomNavigationBar: viewModel.currentStep > 0
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilledButton(
                  child: Text(
                    viewModel.currentStep < viewModel.totalSteps - 1
                        ? 'NEXT'
                        : 'PLAY',
                  ),
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
      case 0:
        name = 'Dictionaries';
      case 1:
        name = 'Teams';
      case 2:
        name = 'Game Settings';
      default:
        name = 'Unknown Step';
    }
    return Text(name);
  }

  Widget _buildStepContent(GameSettingsViewModel viewModel) {
    switch (viewModel.currentStep) {
      case 0:
        return _buildDictionarySelection(viewModel);
      case 1:
        return const TeamSelectionWidget();
      case 2:
        return const GameConfigWidget();
      default:
        return Center(child: Text('Unknown Step'));
    }
  }

  Widget _buildDictionarySelection(GameSettingsViewModel viewModel) {
    var dictionaries = Dictionary.values;
    return ListView.builder(
      itemCount: dictionaries.length,
      itemBuilder: (context, index) {
        return DictionaryCardWidget(dictionary: dictionaries[index]);
      },
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
