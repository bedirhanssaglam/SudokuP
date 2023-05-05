import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sudoku_app/core/constants/app/color_constants.dart';

class AnimatedFloatingButton extends StatefulWidget {
  final VoidCallback onRefresh;
  final VoidCallback onNewGame;
  final VoidCallback onShowSolution;
  final VoidCallback onDifficult;
  final VoidCallback onChangeColor;

  const AnimatedFloatingButton({
    Key? key,
    required this.onRefresh,
    required this.onNewGame,
    required this.onShowSolution,
    required this.onDifficult,
    required this.onChangeColor,
  }) : super(key: key);

  @override
  _AnimatedFloatingButtonState createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  final Curve _curve = Curves.easeOut;
  final double _fabHeight = 56.0;

  @override
  initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: ColorConstants.primaryColor[900],
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.75,
          curve: _curve,
        ),
      ),
    );
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget refresh() {
    return isOpened
        ? FloatingActionButton(
            onPressed: () {
              widget.onRefresh();
              animate();
            },
            tooltip: AppLocalizations.of(context)!.restartGame,
            child: const Icon(Icons.refresh),
          )
        : const SizedBox.shrink();
  }

  Widget newGame() {
    return isOpened
        ? FloatingActionButton(
            onPressed: () {
              widget.onNewGame();
              animate();
            },
            tooltip: AppLocalizations.of(context)!.newGame,
            child: const Icon(
              Icons.add_rounded,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget showSolution() {
    return isOpened
        ? FloatingActionButton(
            onPressed: () {
              widget.onShowSolution();
              animate();
            },
            tooltip: AppLocalizations.of(context)!.showSolution,
            child: const Icon(
              Icons.lightbulb_outline_rounded,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget setDifficulty() {
    return isOpened
        ? FloatingActionButton(
            onPressed: () {
              widget.onDifficult();
              animate();
            },
            tooltip: AppLocalizations.of(context)!.setDifficulty,
            child: const Icon(
              Icons.build_outlined,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget accentColor() {
    return isOpened
        ? FloatingActionButton(
            onPressed: () {
              widget.onChangeColor();
              animate();
            },
            tooltip: AppLocalizations.of(context)!.changeAccentColor,
            child: const Icon(
              Icons.color_lens_outlined,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _buttonColor.value,
      onPressed: animate,
      tooltip: AppLocalizations.of(context)!.options,
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 5.0,
            0.0,
          ),
          child: refresh(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 4.0,
            0.0,
          ),
          child: newGame(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: showSolution(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: setDifficulty(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: accentColor(),
        ),
        toggle(),
      ],
    );
  }
}
