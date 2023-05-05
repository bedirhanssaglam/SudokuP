import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_app/core/constants/enums/shared_keys_enums.dart';
import 'package:sudoku_app/core/extensions/context_extensions.dart';
import 'package:sudoku_app/core/extensions/image_extensions.dart';
import 'package:sudoku_app/view/home/home_view.dart';

import '../../../core/constants/enums/icon_enums.dart';
import '../intro/intro_view.dart';
import '../login/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  checkLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    if (prefs.getBool(SharedKeysEnums.isFirst.key) != false) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const IntroView(),
          ));
    } else {
      if (prefs.getBool(SharedKeysEnums.isLogged.key) == true) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ));
      } else if (prefs.getBool(SharedKeysEnums.isLogged.key) == false) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
    checkLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation.drive(
            Tween<double>(
              begin: 1,
              end: 0,
            ).chain(
              CurveTween(curve: Curves.easeInOut),
            ),
          ),
          child: Image.asset(
            IconEnums.appLogo.iconName.toPng,
            height: context.dynamicHeight(0.2),
            width: context.dynamicWidth(0.9),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
