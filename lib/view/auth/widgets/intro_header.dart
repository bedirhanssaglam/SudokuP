import 'package:flutter/material.dart';
import 'package:sudoku_app/core/extensions/context_extensions.dart';
import 'package:sudoku_app/core/extensions/image_extensions.dart';
import 'package:sudoku_app/core/extensions/num_extensions.dart';

import '../../../core/components/text/custom_text.dart';
import '../../../core/constants/app/app_constants.dart';

class IntroHeader extends StatelessWidget {
  const IntroHeader({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image.toPng,
          height: context.dynamicHeight(.5),
          width: double.infinity,
        ),
        20.ph,
        CustomText(
          AppConstants.appName,
          textStyle: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        40.ph,
        CustomText(
          text,
          textStyle: context.textTheme.titleLarge?.copyWith(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
