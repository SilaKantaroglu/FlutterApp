import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';
import 'package:staj_case/components/custom_elevated.dart';
import 'package:staj_case/components/custom_textfield.dart';
import 'package:staj_case/languages/strings.dart';
import 'package:staj_case/pages/login/database.dart';
import 'package:staj_case/pages/login/database_model.dart';
import 'package:staj_case/pages/login/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final userNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final Icon passwordIcon = const Icon(Icons.lock);
  final Icon password2Icon = const Icon(Icons.lock_open);
  final Icon userNameIcon = const Icon(Icons.supervised_user_circle_outlined);
  final Icon emailIcon = const Icon(Icons.mail);

  final db = DatabaseHelper();
  dynamic signUp() async {
    var res = await db.createUser(Users(
        fullName: fullNameController.text,
        email: emailController.text,
        userName: userNameController.text,
        userPassword: passwordController.text));

    if (res > 0) {
      if (!mounted) return;
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const textButtonStyle = TextStyle(
      fontStyle: FontStyle.italic,
      color: ColorUtility.blackShade,
      decoration: TextDecoration.underline,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: ColorUtility.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.settings_rounded,
                size: 150,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(LanguageItems.welcomeText,
                    style: TextStyle(color: ColorUtility.blackShade, fontStyle: FontStyle.italic, letterSpacing: 5)),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: fullNameController,
                  hintText: LanguageItems.hintFullName,
                  customIcon: userNameIcon,
                  keyboard: TextInputType.name,
                  obscureText: false),
              CustomTextField(
                  controller: emailController,
                  hintText: LanguageItems.hintEmail,
                  customIcon: emailIcon,
                  keyboard: TextInputType.emailAddress,
                  obscureText: false),
              CustomTextField(
                  controller: userNameController,
                  hintText: LanguageItems.hintUserName,
                  customIcon: userNameIcon,
                  keyboard: TextInputType.name,
                  obscureText: false),
              CustomTextField(
                  controller: passwordController,
                  hintText: LanguageItems.hintPassword,
                  customIcon: password2Icon,
                  keyboard: TextInputType.number,
                  obscureText: true),
              CustomTextField(
                  controller: password2Controller,
                  hintText: LanguageItems.hintPassword2,
                  customIcon: passwordIcon,
                  keyboard: TextInputType.number,
                  obscureText: true),
              const SizedBox(height: 10),
              Center(
                child: MyElevatedButton(
                  buttonText: LanguageItems.signUpButtonText,
                  onPressed: () {
                    signUp();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(LanguageItems.signInText),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                      },
                      child: const Text(LanguageItems.loginTextButton, style: textButtonStyle),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
