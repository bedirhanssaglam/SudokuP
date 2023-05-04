import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_app/core/constants/enums/shared_keys_enums.dart';
import 'package:sudoku_app/core/extensions/context_extensions.dart';
import 'package:sudoku_app/core/extensions/num_extensions.dart';
import 'package:sudoku_app/core/init/provider/intro_provider.dart';

import '../../../core/components/text/custom_text.dart';
import '../../../core/constants/app/string_constants.dart';
import '../login/login_view.dart';
import '../widgets/intro_header.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final PageController pageController = PageController(initialPage: 0);

  setIsFirstStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedKeysEnums.isFirst.key, false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.dynamicWidth(.05)),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Consumer<IntroProvider>(
                    builder: (context, value, child) {
                      return PageView.builder(
                        controller: pageController,
                        onPageChanged: (value) {
                          context.read<IntroProvider>().setCurrentPage(value);
                        },
                        itemCount: AppConstants.splashData.length,
                        itemBuilder: (context, index) => IntroHeader(
                          image: AppConstants.splashData[index]["image"]!,
                          text: AppConstants.splashData[index]['text']!,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      context.dynamicWidth(0.38).pw,
                      Consumer<IntroProvider>(
                        builder: (context, value, child) {
                          return Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  AppConstants.splashData.length,
                                  (index) {
                                    return buildPageDots(context, index);
                                  },
                                ),
                              ),
                              context.dynamicWidth(0.2).pw,
                              InkWell(
                                onTap: () async {
                                  await setIsFirstStatus();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginView(),
                                      ));
                                },
                                child: Row(
                                  children: [
                                    CustomText(
                                      "Skip",
                                      textStyle: context.textTheme.titleMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.amber,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildPageDots(BuildContext context, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 6),
      height: 8,
      width: context.watch<IntroProvider>().currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: context.watch<IntroProvider>().currentPage == index
            ? Colors.amber
            : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
