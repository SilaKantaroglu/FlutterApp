import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';

class BourseCard extends StatelessWidget {
  final String? name;
  final String? currency;
  final String? pricestr;

  final String? time;

  const BourseCard({
    Key? key,
    this.name,
    this.currency,
    this.pricestr,
    this.time,
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
              CupertinoIcons.barcode_viewfinder,
              size: 30,
            ),
            Text(
              textAlign: TextAlign.center,
              '  $name',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
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
              'Fiyat: $pricestr',
              style: _myTextStyle(),
            ),
            Text(
              ' Zaman : $time',
              style: _myTextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _myTextStyle() => const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500);
}
