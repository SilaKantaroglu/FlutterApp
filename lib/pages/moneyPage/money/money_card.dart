import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';

class MoneyCard extends StatelessWidget {
  final String? name;
  final String? buying;
  final String? selling;

  const MoneyCard({
    Key? key,
    this.name,
    this.buying,
    this.selling,
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
              Icons.money,
              size: 30,
            ),
            Text(
              textAlign: TextAlign.center,
              name ?? ' ',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Alış : $buying',
              style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
            ),
            Text(
              'Satış : $selling',
              style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
