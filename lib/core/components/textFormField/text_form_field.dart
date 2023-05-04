import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudoku_app/core/extensions/context_extensions.dart';
import 'package:sudoku_app/core/extensions/num_extensions.dart';

import '../../constants/app/color_constants.dart';
import '../../utils/typedefs.dart';
import '../text/custom_text.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.title,
    this.onSaved,
  });

  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final SavedFunction onSaved;
  final ValidatorFunction validator;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidth(.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.ph,
          CustomText(
            widget.title ?? "",
            textStyle: context.textTheme.titleMedium,
          ),
          10.ph,
          TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            onSaved: widget.onSaved,
            cursorColor: ColorConstants.grey,
            style: GoogleFonts.montserrat(),
            decoration: InputDecoration(
              hintText: widget.hintText,
              errorStyle: GoogleFonts.montserrat(),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: ColorConstants.primaryColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: ColorConstants.primaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: ColorConstants.primaryColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: ColorConstants.lightRed)),
            ),
          ),
        ],
      ),
    );
  }
}
