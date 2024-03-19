import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';

class CustomTextField extends StatelessWidget {
  final bool obscureText;
  final TextInputType keyboard;
  final Icon customIcon;
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.obscureText,
    required this.keyboard,
    required this.customIcon,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .9,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Card(
          elevation: 5,
          shadowColor: ColorUtility.darkBabyBlueButton,
          color: ColorUtility.white,
          borderOnForeground: true,
          child: TextField(
            style: const TextStyle(
              color: ColorUtility.grey,
              fontSize: 20,
            ),
            textAlign: TextAlign.left,
            textInputAction: TextInputAction.next,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboard,
            cursorColor: ColorUtility.blackShade,
            decoration: _inputdecorator(),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputdecorator() {
    return InputDecoration(
      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
      prefixIcon: customIcon,
      hintText: hintText,
    );
  }
}
