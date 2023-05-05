import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_app/core/components/button/button.dart';
import 'package:sudoku_app/core/components/text/custom_text.dart';
import 'package:sudoku_app/core/components/textFormField/text_form_field.dart';
import 'package:sudoku_app/core/constants/app/app_constants.dart';
import 'package:sudoku_app/core/extensions/context_extensions.dart';
import 'package:sudoku_app/core/extensions/image_extensions.dart';
import 'package:sudoku_app/core/extensions/num_extensions.dart';
import 'package:sudoku_app/core/utils/validate_operations.dart';
import 'package:sudoku_app/view/home/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/constants/enums/icon_enums.dart';
import '../../../core/constants/enums/shared_keys_enums.dart';
import '../widgets/animated_loading.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  setName() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedKeysEnums.name.key, nameController.text.trim());
  }

  setLogged() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedKeysEnums.isLogged.key, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                context.dynamicHeight(.12).ph,
                Image.asset(
                  IconEnums.appLogo.iconName.toPng,
                  height: context.dynamicHeight(0.3),
                  width: context.dynamicWidth(0.6),
                ),
                20.ph,
                CustomText(
                  AppConstants.appName,
                  textStyle: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                context.dynamicHeight(.03).ph,
                TextFormFieldWidget(
                  controller: nameController,
                  title: AppLocalizations.of(context)!.name,
                  hintText: AppLocalizations.of(context)!.name,
                  onSaved: (value) {
                    nameController.text = value!;
                  },
                  validator: (value) =>
                      ValidateOperations.normalValidation(value, context),
                ),
                context.dynamicHeight(.1).ph,
                isLoading
                    ? const AnimatedLoading(
                        leftDotColor: Colors.amber,
                        rightDotColor: Colors.lightBlue,
                        size: 35,
                      )
                    : CustomButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            await setName();
                            await setLogged();
                            Future.delayed(const Duration(seconds: 2))
                                .then((_) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeView(),
                              ));
                            });
                          }
                        },
                        buttonText: AppLocalizations.of(context)!.login,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
