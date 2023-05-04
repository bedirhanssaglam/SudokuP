import 'package:flutter/material.dart';
import 'package:sudoku_app/core/components/text/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/app/color_constants.dart';

class NumberAlertDialog extends StatefulWidget {
  const NumberAlertDialog({Key? key}) : super(key: key);

  @override
  AlertNumbers createState() => AlertNumbers();

  static int? get number {
    return AlertNumbers.number;
  }

  static set number(int? number) {
    AlertNumbers.number = number;
  }
}

class AlertNumbers extends State<NumberAlertDialog> {
  static int? number;
  late int numberSelected;
  static final List<int> numberList1 = [1, 2, 3];
  static final List<int> numberList2 = [4, 5, 6];
  static final List<int> numberList3 = [7, 8, 9];

  List<Container> createButtons(List<int> numberList) {
    return <Container>[
      for (int numbers in numberList)
        Container(
          width: 38,
          height: 38,
          margin: const EdgeInsets.all(3),
          child: TextButton(
            onPressed: () => {
              setState(() {
                numberSelected = numbers;
                number = numberSelected;
                Navigator.pop(context);
              })
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  ColorConstants.secondaryBackgroundColor),
              foregroundColor:
                  MaterialStateProperty.all<Color>(ColorConstants.primaryColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
              side: MaterialStateProperty.all<BorderSide>(BorderSide(
                color: ColorConstants.foregroundColor,
                width: 1,
                style: BorderStyle.solid,
              )),
            ),
            child: CustomText(
              numbers.toString(),
              textAlign: TextAlign.center,
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        )
    ];
  }

  Row oneRow(List<int> numberList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: createButtons(numberList),
    );
  }

  List<Row> createRows() {
    List<List<int>> numberLists = [numberList1, numberList2, numberList3];
    List<Row> rowList = <Row>[];
    for (var i = 0; i <= 2; i++) {
      rowList.add(oneRow(numberLists[i]));
    }
    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: ColorConstants.secondaryBackgroundColor,
      title: Center(
          child: CustomText(
        AppLocalizations.of(context)!.chooseNumber,
        textStyle: TextStyle(color: ColorConstants.foregroundColor),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: createRows(),
      ),
    );
  }
}
