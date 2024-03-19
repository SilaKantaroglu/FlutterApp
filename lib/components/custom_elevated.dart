import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .9,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorUtility.darkBabyBlueButton, shape: const StadiumBorder(), elevation: 0),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorUtility.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
