import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';

class WeatherCard extends StatelessWidget {
  final String? date;
  final String? description;
  final String? degree;
  final String? min;
  final String? max;
  final String? humidity;

  const WeatherCard({
    super.key,
    this.date,
    this.description,
    this.degree,
    this.min,
    this.max,
    this.humidity,
  });

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
          decoration: weatherCardColorDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Tarih:',
                      style: _textStyle2(),
                    ),
                    Text(' ${date ?? ''}', style: textStyle),
                  ],
                ),
                const Divider(),
                Text(
                  textAlign: TextAlign.center,
                  ' ${description?.toUpperCase() ?? ''}',
                  style: textStyle,
                ),
                Text(
                  'Derece: ${degree ?? ''}',
                  style: textStyle,
                ),
                Text(
                  'En Yüksek: ${max ?? ''}',
                  style: textStyle,
                ),
                Text(
                  'En Düşük: ${min ?? ''}',
                  style: textStyle,
                ),
                Text(
                  'Nem Oranı: ${humidity ?? ''}',
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

  BoxDecoration weatherCardColorDecoration() {
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
