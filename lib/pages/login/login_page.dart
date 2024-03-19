import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/colors.dart';
import '../../components/custom_elevated.dart';
import '../../components/custom_textfield.dart';
import '../../languages/strings.dart';
import '../bottom_menu_page.dart';
import 'database.dart';
import 'database_model.dart';
import 'sign_up_page.dart';
import "../../provider/provider.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class CurrentUser {
  static late final String currentuser;
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final Icon passwordIcon = const Icon(CupertinoIcons.lock);
  final Icon userNameIcon = const Icon(CupertinoIcons.person);
  bool isChecked = false;
  bool isLoginTrue = false;
  final db = DatabaseHelper();
  late String username = ' ';
  @override
  Widget build(BuildContext context) {
    const textButtonStyle =
        TextStyle(fontStyle: FontStyle.italic, color: ColorUtility.blackShade, decoration: TextDecoration.underline);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: ColorUtility.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.person_3_fill,
                size: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(LanguageItems.welcomeText, style: _textStyle()),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: userNameController,
                  hintText: LanguageItems.hintUserName,
                  customIcon: userNameIcon,
                  keyboard: TextInputType.name,
                  obscureText: false),
              CustomTextField(
                  controller: passwordController,
                  hintText: LanguageItems.hintPassword,
                  customIcon: passwordIcon,
                  keyboard: TextInputType.number,
                  obscureText: true),
              const SizedBox(height: 10),
              Center(child: Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
                return MyElevatedButton(
                  buttonText: LanguageItems.loginLuttonText,
                  onPressed: () async {
                    var res = await db
                        .authenticate(Users(userName: userNameController.text, userPassword: passwordController.text));
                    if (res == true) {
                      if (notifier.isChecked == true) {
                        notifier.setCurrentUsername(userNameController.text);
                        notifier.setRememberMe();
                      }
                      if (!mounted) return;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenuPage(),
                          ));
                    } else {
                      setState(() {
                        isLoginTrue = true;
                      });
                    }
                  },
                );
              })),
              Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
                return ListTile(
                  horizontalTitleGap: 2,
                  title: Text(LanguageItems.rememberCheck, style: _textStyleMini()),
                  leading: Checkbox(
                    activeColor: ColorUtility.darkBabyBlueButton,
                    value: notifier.isChecked,
                    onChanged: (value) => notifier.toggleCheck(),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(LanguageItems.signInText),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                      },
                      child: const Text(LanguageItems.signUpTextButton, style: textButtonStyle),
                    ),
                  ],
                ),
              ),
              isLoginTrue
                  ? Text(
                      LanguageItems.loginError,
                      style: TextStyle(color: Colors.red[900], fontSize: 30, fontStyle: FontStyle.italic),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(color: ColorUtility.grey, fontStyle: FontStyle.italic, letterSpacing: 5);
  }

  TextStyle _textStyleMini() {
    return const TextStyle(
      color: ColorUtility.grey,
      fontStyle: FontStyle.italic,
      fontSize: 20,
    );
  }
}
