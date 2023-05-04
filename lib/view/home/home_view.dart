import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_app/core/components/switch/custom_switch.dart';
import 'package:sudoku_app/core/constants/app/string_constants.dart';
import 'package:sudoku_app/core/constants/enums/shared_keys_enums.dart';
import 'package:sudoku_app/core/constants/enums/theme_enums.dart';
import 'package:sudoku_app/core/extensions/context_extensions.dart';
import 'package:sudoku_app/core/extensions/image_extensions.dart';
import 'package:sudoku_app/core/extensions/num_extensions.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/components/alerts/accent_color_alert_dialog.dart';
import '../../core/components/alerts/difficulty_alert_dialog.dart';
import '../../core/components/alerts/exit_alert_dialog.dart';
import '../../core/components/alerts/game_over_alert_dialog.dart';
import '../../core/components/alerts/number_alert_dialog.dart';
import '../../core/components/floatingActionButton/floating_action_button.dart';
import '../../core/components/text/custom_text.dart';
import '../../core/constants/app/color_constants.dart';
import '../../core/constants/enums/language_enums.dart';
import '../../core/init/provider/locale_provider.dart';
import '../../core/utils/board_style.dart';
import '../../core/utils/l10n.dart';
import '../../core/utils/new_game.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key, this.currentLanguage}) : super(key: key);

  Locale? currentLanguage;

  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  bool firstRun = true;
  bool gameOver = false;
  int timesCalled = 0;
  bool isButtonDisabled = false;
  bool isFABDisabled = false;
  late List<List<List<int>>> gameList;
  late List<List<int>> game;
  late List<List<int>> gameCopy;
  late List<List<int>> gameSolved;
  static String? currentDifficultyLevel;
  static String? currentTheme;
  static String? currentAccentColor;
  final ValueNotifier<bool> _controller = ValueNotifier<bool>(
    currentTheme == ThemeEnums.light.theme ? false : true,
  );

  String? name;
  String? dropdownValue;

  checkName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString(SharedKeysEnums.name.key) ?? "";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkName();
    fetchLocale();
    getPrefs().whenComplete(() {
      if (currentDifficultyLevel == null) {
        currentDifficultyLevel = AppConstants.easy;
        setPrefs(SharedKeysEnums.currentDifficultyLevel.key);
      }
      if (currentTheme == null) {
        if (MediaQuery.maybeOf(context)?.platformBrightness != null) {
          currentTheme =
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? ThemeEnums.light.theme
                  : ThemeEnums.dark.theme;
        } else {
          currentTheme = ThemeEnums.dark.theme;
        }
        setPrefs(SharedKeysEnums.currentTheme.key);
      }
      if (currentAccentColor == null) {
        currentAccentColor = 'Blue';
        setPrefs(SharedKeysEnums.currentAccentColor.key);
      }
      _controller.addListener(() {
        changeTheme();
        setState(() {});
      });
      newGame(currentDifficultyLevel!);
      changeAccentColor(currentAccentColor!, true);
    });
  }

  fetchLocale() async {
    setState(() {
      if (widget.currentLanguage == Locale(LanguageEnums.en.language)) {
        dropdownValue = LanguageEnums.english.language;
      }
      if (widget.currentLanguage == Locale(LanguageEnums.de.language)) {
        dropdownValue = LanguageEnums.german.language;
      }
      if (widget.currentLanguage == Locale(LanguageEnums.tr.language)) {
        dropdownValue = LanguageEnums.turkish.language;
      }
      if (widget.currentLanguage == Locale(LanguageEnums.ja.language)) {
        dropdownValue = LanguageEnums.japanese.language;
      }
      if (widget.currentLanguage == Locale(LanguageEnums.ar.language)) {
        dropdownValue = LanguageEnums.arabic.language;
      }
    });
  }

  Future<void> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentDifficultyLevel =
        prefs.getString(SharedKeysEnums.currentDifficultyLevel.key);
    currentTheme = prefs.getString(SharedKeysEnums.currentTheme.key);
    currentAccentColor =
        prefs.getString(SharedKeysEnums.currentAccentColor.key);
    setState(() {});
  }

  setPrefs(String property) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (property == SharedKeysEnums.currentDifficultyLevel.key) {
      prefs.setString(
          SharedKeysEnums.currentDifficultyLevel.key, currentDifficultyLevel!);
    } else if (property == SharedKeysEnums.currentTheme.key) {
      prefs.setString(SharedKeysEnums.currentTheme.key, currentTheme!);
    } else if (property == SharedKeysEnums.currentAccentColor.key) {
      prefs.setString(
          SharedKeysEnums.currentAccentColor.key, currentAccentColor!);
    }
  }

  changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (currentTheme == ThemeEnums.light.theme) {
        ColorConstants.primaryBackgroundColor = ColorConstants.darkGrey;
        ColorConstants.secondaryBackgroundColor = ColorConstants.grey;
        ColorConstants.foregroundColor = ColorConstants.white;
        currentTheme = ThemeEnums.dark.theme;
      } else if (currentTheme == ThemeEnums.dark.theme) {
        ColorConstants.primaryBackgroundColor = ColorConstants.white;
        ColorConstants.secondaryBackgroundColor = ColorConstants.white;
        ColorConstants.foregroundColor = ColorConstants.darkGrey;
        currentTheme = ThemeEnums.light.theme;
      }
      prefs.setString(SharedKeysEnums.currentTheme.key, currentTheme!);
    });
  }

  void changeAccentColor(String color, [bool firstRun = false]) {
    setState(() {
      if (ColorConstants.accentColors.keys.contains(color)) {
        ColorConstants.primaryColor = ColorConstants.accentColors[color]!;
      } else {
        currentAccentColor = 'Blue';
        ColorConstants.primaryColor = ColorConstants.accentColors[color]!;
      }
      if (color == 'Red') {
        ColorConstants.secondaryColor = ColorConstants.orange;
      } else {
        ColorConstants.secondaryColor = ColorConstants.lightRed;
      }
      if (!firstRun) {
        setPrefs(SharedKeysEnums.currentAccentColor.key);
      }
    });
  }

  void checkResult() {
    try {
      if (SudokuUtilities.isSolved(game)) {
        isButtonDisabled = !isButtonDisabled;
        gameOver = true;
        Timer(const Duration(milliseconds: 500), () {
          showAnimatedDialog<void>(
              animationType: DialogTransitionType.fadeScale,
              barrierDismissible: true,
              duration: const Duration(milliseconds: 350),
              context: context,
              builder: (_) => const GameOverAlertDialog()).whenComplete(() {
            if (GameOverAlertDialog.newGame) {
              newGame();
              GameOverAlertDialog.newGame = false;
            } else if (GameOverAlertDialog.restartGame) {
              restartGame();
              GameOverAlertDialog.restartGame = false;
            }
          });
        });
      }
    } on InvalidSudokuConfigurationException {
      return;
    }
  }

  void setGame(int mode, [String difficulty = AppConstants.easy]) async {
    if (mode == 1) {
      game = List.filled(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      gameCopy = List.filled(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      gameSolved = List.filled(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
    } else {
      gameList = await NewGame.getNewGame(difficulty);
      game = gameList[0];
      gameCopy = copyGrid(game);
      gameSolved = gameList[1];
    }
  }

  static List<List<int>> copyGrid(List<List<int>> grid) {
    return grid.map((row) => [...row]).toList();
  }

  void showSolution() {
    setState(() {
      game = copyGrid(gameSolved);
      isButtonDisabled =
          !isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = true;
    });
  }

  void newGame([String difficulty = AppConstants.easy]) {
    setState(() {
      isFABDisabled = !isFABDisabled;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        setGame(2, difficulty);
        isButtonDisabled =
            isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
        gameOver = false;
        isFABDisabled = !isFABDisabled;
      });
    });
  }

  void restartGame() {
    setState(() {
      game = copyGrid(gameCopy);
      isButtonDisabled =
          isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = false;
    });
  }

  List<SizedBox> createButtons() {
    if (firstRun) {
      setGame(1);
      firstRun = false;
    }

    List<SizedBox> buttonList =
        List<SizedBox>.filled(9, const SizedBox.shrink());
    for (var i = 0; i <= 8; i++) {
      var k = timesCalled;
      buttonList[i] = SizedBox(
        key: Key('grid-button-$k-$i'),
        width: MediaQuery.of(context).size.width * .1,
        height: MediaQuery.of(context).size.width * .1,
        child: TextButton(
          onPressed: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () {
                  showAnimatedDialog<void>(
                          animationType: DialogTransitionType.fade,
                          barrierDismissible: true,
                          duration: const Duration(milliseconds: 300),
                          context: context,
                          builder: (_) => const NumberAlertDialog())
                      .whenComplete(() {
                    callback([k, i], NumberAlertDialog.number);
                    NumberAlertDialog.number = null;
                  });
                },
          onLongPress: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () => callback([k, i], 0),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(BoardStyle.buttonColor(k, i)),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return gameCopy[k][i] == 0
                    ? BoardStyle.emptyColor(gameOver)
                    : ColorConstants.foregroundColor;
              }
              return game[k][i] == 0
                  ? BoardStyle.buttonColor(k, i)
                  : ColorConstants.secondaryColor;
            }),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
              borderRadius: BoardStyle.buttonEdgeRadius(k, i),
            )),
            side: MaterialStateProperty.all<BorderSide>(BorderSide(
              color: ColorConstants.foregroundColor,
              width: 1,
              style: BorderStyle.solid,
            )),
          ),
          child: CustomText(
            game[k][i] != 0 ? game[k][i].toString() : ' ',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    timesCalled++;
    if (timesCalled == 9) {
      timesCalled = 0;
    }
    return buttonList;
  }

  Row oneRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: createButtons(),
    );
  }

  List<Row> createRows() {
    List<Row> rowList = List<Row>.generate(9, (i) => oneRow());
    return rowList;
  }

  void callback(List<int> index, int? number) {
    setState(() {
      if (number == null) {
        return;
      } else if (number == 0) {
        game[index[0]][index[1]] = number;
      } else {
        game[index[0]][index[1]] = number;
        checkResult();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showAnimatedDialog<void>(
          animationType: DialogTransitionType.fadeScale,
          barrierDismissible: true,
          duration: const Duration(milliseconds: 350),
          context: context,
          builder: (_) => const ExitAlertDialog(),
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorConstants.primaryBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: AppBar(
            leading: IconButton(
              onPressed: () {
                showAnimatedDialog<void>(
                  animationType: DialogTransitionType.fadeScale,
                  barrierDismissible: true,
                  duration: const Duration(milliseconds: 350),
                  context: context,
                  builder: (_) => const ExitAlertDialog(),
                );
              },
              icon: Icon(
                Icons.logout,
                color: ColorConstants.foregroundColor,
              ),
            ),
            centerTitle: true,
            elevation: 5,
            shadowColor: ColorConstants.primaryColor,
            title: CustomText(
              AppConstants.appName,
              textStyle: context.textTheme.titleLarge
                  ?.copyWith(color: ColorConstants.foregroundColor),
            ),
            backgroundColor: ColorConstants.primaryBackgroundColor,
            actions: [
              Container(
                height: 30,
                width: 55,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  color: ColorConstants.lightWhite,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    dropdownColor: ColorConstants.primaryBackgroundColor,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                      context.read<LocaleProvider>().changeLanguage(
                            Locale(L10n.setLanguage(dropdownValue!)),
                          );
                    },
                    items: AppConstants.languageList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: SvgPicture.asset(
                            L10n.checkLanguageIcon(value).toSvg,
                            height: 23,
                            width: 45,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomSwitch(
                  controller: _controller,
                  width: context.dynamicWidth(0.15),
                  height: context.dynamicHeight(0.035),
                  thumb: ValueListenableBuilder(
                    valueListenable: _controller,
                    builder: (_, value, __) {
                      return Icon(
                        value ? Icons.dark_mode : Icons.sunny,
                        size: 23,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Builder(
          builder: (builder) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  context.dynamicHeight(.06).ph,
                  CustomText(
                    "${AppLocalizations.of(context)!.welcome} $name!",
                    textStyle: context.textTheme.headlineSmall?.copyWith(
                      color: ColorConstants.foregroundColor,
                    ),
                  ),
                  context.dynamicHeight(.1).ph,
                  ...createRows(),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FancyFab(
          onRefresh: () {
            Timer(const Duration(milliseconds: 200), () => restartGame());
          },
          onNewGame: () {
            Timer(const Duration(milliseconds: 200),
                () => newGame(currentDifficultyLevel!));
          },
          onShowSolution: () {
            Timer(
              const Duration(milliseconds: 200),
              () => showSolution(),
            );
          },
          onDifficult: () {
            Timer(
                const Duration(milliseconds: 300),
                () => showAnimatedDialog<void>(
                            animationType: DialogTransitionType.fadeScale,
                            barrierDismissible: true,
                            duration: const Duration(milliseconds: 350),
                            context: context,
                            builder: (_) =>
                                DifficultyAlertDialog(currentDifficultyLevel!))
                        .whenComplete(() {
                      if (DifficultyAlertDialog.difficulty != null) {
                        Timer(const Duration(milliseconds: 300), () {
                          newGame(DifficultyAlertDialog.difficulty ?? 'test');
                          currentDifficultyLevel =
                              DifficultyAlertDialog.difficulty;
                          DifficultyAlertDialog.difficulty = null;
                          setPrefs(SharedKeysEnums.currentDifficultyLevel.key);
                        });
                      }
                    }));
          },
          onChangeColor: () {
            Timer(
              const Duration(milliseconds: 200),
              () => showAnimatedDialog<void>(
                      animationType: DialogTransitionType.fadeScale,
                      barrierDismissible: true,
                      duration: const Duration(milliseconds: 350),
                      context: context,
                      builder: (_) =>
                          AccentColorAlertDialog(currentAccentColor!))
                  .whenComplete(() {
                if (AccentColorAlertDialog.accentColor != null) {
                  Timer(const Duration(milliseconds: 300), () {
                    currentAccentColor = AccentColorAlertDialog.accentColor;
                    changeAccentColor(currentAccentColor.toString());
                    AccentColorAlertDialog.accentColor = null;
                    setPrefs(SharedKeysEnums.currentAccentColor.key);
                  });
                }
              }),
            );
          },
        ),
      ),
    );
  }
}
