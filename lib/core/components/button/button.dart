import 'package:flutter/material.dart';
import 'package:sudoku_app/core/extensions/context_extensions.dart';

import '../../constants/app/color_constants.dart';
import '../text/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.dynamicHeight(.05),
        horizontal: context.dynamicWidth(.05),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.primaryColor,
            fixedSize: Size(
              context.dynamicWidth(1),
              context.dynamicHeight(0.06),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: CustomText(
          buttonText,
          textStyle: context.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
