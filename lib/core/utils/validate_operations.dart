import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@immutable
class ValidateOperations {
  const ValidateOperations._();

  static normalValidation(
    dynamic value,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.requiredField;
    }
    return null;
  }
}
