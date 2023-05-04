import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_app/core/components/text/custom_text.dart';
import 'package:sudoku_app/core/constants/enums/shared_keys_enums.dart';
import 'package:sudoku_app/view/auth/login/login_view.dart';

import '../../constants/app/color_constants.dart';

class ExitAlertDialog extends StatelessWidget {
  const ExitAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: ColorConstants.secondaryBackgroundColor,
      title: CustomText(
        AppLocalizations.of(context)!.signOut,
        textStyle: TextStyle(color: ColorConstants.foregroundColor),
      ),
      content: CustomText(
        AppLocalizations.of(context)!.sureLogOut,
        textStyle: TextStyle(color: ColorConstants.foregroundColor),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  ColorConstants.primaryColor)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: CustomText(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(ColorConstants.primaryColor),
          ),
          onPressed: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.remove(SharedKeysEnums.name.key);
            await prefs.remove(SharedKeysEnums.isLogged.key).then(
                  (_) => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  )),
                );
          },
          child: CustomText(AppLocalizations.of(context)!.yes),
        ),
      ],
    );
  }
}
