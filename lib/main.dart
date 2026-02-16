import 'package:alias/services/database_service.dart';
import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:alias/views/main_menu.dart';
import 'package:bouncy_button/bouncy_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final databaseService = DatabaseService();

  runApp(
    MultiProvider(
      providers: [
        Provider<DatabaseService>.value(value: databaseService),
        ChangeNotifierProvider(
          create: (_) => GameFlowViewModel(databaseService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Alias',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6D83F2)),
        useMaterial3: true,
        extensions: [BouncyButtonTheme()],
      ),
      home: const MainMenu(),
    );
  }
}
