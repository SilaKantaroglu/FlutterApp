import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';

class PharmacyCard extends StatelessWidget {
  final String? name;
  final String? dist;
  final String? addres;
  final String? phone;
  final String? loc;

  const PharmacyCard({
    Key? key,
    this.name,
    this.dist,
    this.addres,
    this.phone,
    this.loc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: ColorUtility.black,
    );
    return SizedBox(
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: pharmacyCardColorDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'İsim: ',
                      style: _textStyle2(),
                    ),
                    Text(' ${name ?? ''}', style: textStyle),
                  ],
                ),
                const Divider(),
                Text(
                  'Mahalle: ${dist ?? ''}',
                  style: textStyle,
                ),
                Text(
                  'Adres: ${addres ?? ''}',
                  style: textStyle,
                ),
                Text(
                  'Telefon: ${phone ?? ''}',
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle2() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ColorUtility.darkBabyBlueButton,
    );
  }

  BoxDecoration pharmacyCardColorDecoration() {
    return BoxDecoration(
      color: ColorUtility.white,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: ColorUtility.blackShade.withOpacity(0.1),
        width: 1.0,
      ),
    );
  }
}
