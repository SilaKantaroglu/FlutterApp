import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';

class CriptoCard extends StatelessWidget {
  final String? name;
  final String? currency;
  final String? changeWeekstr;
  final String? changeDaystr;

  const CriptoCard({
    Key? key,
    this.name,
    this.currency,
    this.changeWeekstr,
    this.changeDaystr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: ColorUtility.white,
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.bitcoin,
              size: 30,
            ),
            Text(
              textAlign: TextAlign.center,
              '  $name',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              ' Döviz: $currency',
              style: _myTextStyle(),
            ),
            Text(
              " Değişimler: ",
              style: _myTextStyle(),
            ),
            Text(
              'Haftalık: $changeWeekstr',
              style: _myTextStyle(),
            ),
            Text(
              ' Günlük : $changeDaystr',
              style: _myTextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _myTextStyle() => const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500);
}
