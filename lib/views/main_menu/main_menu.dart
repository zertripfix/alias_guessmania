import 'package:alias/viewmodels/game_flow_viewmodel.dart';
import 'package:alias/views/game_flow_navigator.dart';
import 'package:bouncy_button/bouncy_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var hasSavedGame = context.select(
      (GameFlowViewModel vm) => vm.hasSavedGame,
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(177, 106, 208, 1),
              Color.fromRGBO(58, 188, 237, 1),
              Color.fromRGBO(80, 210, 172, 1),
              Color.fromRGBO(254, 219, 29, 1),
            ],
            stops: [0.09, 0.2, 0.3, 0.5],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 16.0,
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8,
                  children: [
                    if (hasSavedGame)
                      BouncyButton(
                        onPressed: () {
                          _onContinue(context);
                        },
                        style: BouncyButtonStyle(
                          height: 70,
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 49, 208, 80),
                              Color.fromARGB(255, 0, 173, 93),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            Text(
                              'ПРОДОЛЖИТЬ',
                              style: GoogleFonts.balsamiqSans(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    BouncyButton(
                      onPressed: () {
                        _onNewGame(context);
                      },
                      style: BouncyButtonStyle(
                        borderRadius: BorderRadius.circular(30),
                        height: 70,
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 137, 93, 214),
                            Color.fromARGB(255, 214, 140, 250),
                            Color.fromARGB(255, 114, 139, 232),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              Icons.star_rounded,
                              color: Colors.yellow,
                              size: 32,
                            ),
                          ),
                          Text(
                            'НОВАЯ ИГРА',
                            style: GoogleFonts.balsamiqSans(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BouncyButton(
                      onPressed: () {
                        _onNewGame(context);
                      },
                      style: BouncyButtonStyle(
                        borderRadius: BorderRadius.circular(30),
                        height: 70,
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 250, 145, 20),
                            Color.fromARGB(255, 255, 155, 88),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              Icons.menu_book_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          Text(
                            'ПРАВИЛА',
                            style: GoogleFonts.balsamiqSans(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: BouncyButton(
                            onPressed: () {
                              _onNewGame(context);
                            },
                            style: BouncyButtonStyle(
                              borderRadius: BorderRadius.circular(30),
                              height: 70,
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 249, 145, 20),
                                  Color.fromARGB(255, 255, 155, 88),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: const Icon(
                                    Icons.shop_rounded,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                Text(
                                  'МАГАЗИН',
                                  style: GoogleFonts.balsamiqSans(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        BouncyButton(
                          onPressed: () {
                            _onNewGame(context);
                          },
                          style: BouncyButtonStyle.circle.copyWith(
                            // borderRadius: BorderRadius.circular(30),
                            height: 70,
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 250, 145, 20),
                                Color.fromARGB(255, 255, 155, 88),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                Icons.settings_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                              // Text(
                              //   'НАСТРОЙКИ',
                              //   style: GoogleFonts.balsamiqSans(
                              //     color: Colors.white,
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.w900,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                  ],
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset('assets/images/logo.svg'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onContinue(BuildContext context) async {
    final navigator = Navigator.of(context);
    await context.read<GameFlowViewModel>().loadSavedGame();
    navigator.push(
      MaterialPageRoute(builder: (context) => GameFlowNavigator()),
    );
  }

  Future<void> _onNewGame(BuildContext context) async {
    final navigator = Navigator.of(context);
    final vm = context.read<GameFlowViewModel>();

    if (vm.hasSavedGame) {
      final shouldDelete = await showDeleteDialog(context);
      if (shouldDelete == true) {
        await vm.deleteSavedGame();
        navigator.push(
          MaterialPageRoute(builder: (context) => GameFlowNavigator()),
        );
      }
    } else {
      navigator.push(
        MaterialPageRoute(builder: (context) => GameFlowNavigator()),
      );
    }
  }

  Future<bool?> showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.delete_outline, size: 32),
          title: const Text('Delete item?'),
          content: const Text(
            'This action cannot be undone. Do you want to continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton.tonal(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red, // emphasize destructive
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
