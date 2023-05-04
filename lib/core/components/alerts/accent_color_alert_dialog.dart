import 'package:flutter/material.dart';
import 'package:sudoku_app/core/components/text/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/app/color_constants.dart';

class AccentColorAlertDialog extends StatefulWidget {
  final String currentAccentColor;

  const AccentColorAlertDialog(this.currentAccentColor, {Key? key})
      : super(key: key);

  static String? get accentColor {
    return AlertAccentColors.accentColor;
  }

  static set accentColor(String? color) {
    AlertAccentColors.accentColor = color;
  }

  @override
  AlertAccentColors createState() => AlertAccentColors(currentAccentColor);
}

class AlertAccentColors extends State<AccentColorAlertDialog> {
  static String? accentColor;
  static final List<String> accentColors = [
    ...ColorConstants.accentColors.keys
  ];
  String currentAccentColor;

  AlertAccentColors(this.currentAccentColor);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: CustomText(
        AppLocalizations.of(context)!.selectAccentColor,
        textStyle: TextStyle(color: ColorConstants.foregroundColor),
      )),
      backgroundColor: ColorConstants.secondaryBackgroundColor,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: <Widget>[
        for (String color in accentColors)
          SimpleDialogOption(
            onPressed: () {
              if (color != currentAccentColor) {
                setState(() {
                  accentColor = color;
                });
              }
              Navigator.pop(context);
            },
            child: CustomText(
              color,
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                  fontSize: 15,
                  color: color == currentAccentColor
                      ? ColorConstants.primaryColor
                      : ColorConstants.foregroundColor),
            ),
          ),
      ],
    );
  }
}
