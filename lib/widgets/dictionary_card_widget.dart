import 'package:alias/viewmodels/game_settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/enums/dictionary.dart';

class DictionaryCardWidget extends StatelessWidget {
  final Dictionary dictionary;
  final List<Color> gradientColors;

  const DictionaryCardWidget({
    super.key,
    required this.dictionary,
    this.gradientColors = const [Color(0xFF9EADF2), Color(0xFF6D83F2)],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 24,
        ),
        title: Text(
          dictionary.displayName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => _showBottomSheet(context),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    var viewModel = context.read<GameSettingsViewModel>();
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Text(
                  dictionary.displayName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Divider(),
                Text("description".toUpperCase()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton(
                child: Text('Choose'.toUpperCase()),
                onPressed: () {
                  viewModel.dictionary = dictionary;
                  viewModel.nextStep();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
