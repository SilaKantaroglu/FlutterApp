import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staj_case/components/colors.dart';
import 'package:staj_case/components/custom_elevated.dart';
import 'package:staj_case/languages/strings.dart';
import 'package:staj_case/pages/login/database.dart';
import 'package:staj_case/provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final db = DatabaseHelper();
  String fullname = '';
  String email = '';
  String username = '';

  _loadUserData() async {
    UiProvider uiProvider = Provider.of<UiProvider>(context, listen: false);

    String currentUsername = uiProvider.currentUsername;

    Map<String, dynamic>? user = await db.getUserDetail(currentUsername);

    if (user != null) {
      setState(() {
        fullname = user["fullName"];
        email = user["email"];
        username = user["userName"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              const Icon(
                CupertinoIcons.person_2_fill,
                size: 200,
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 300,
                child: Card(
                  color: ColorUtility.white,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(fullname,
                            style: const TextStyle(
                                color: ColorUtility.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                letterSpacing: 3)),
                        Text(" Kullanıcı Adı: $username",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 20)),
                        Text(" E-mail: $email",
                            style: const TextStyle(
                                color: Colors.black45,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
                return MyElevatedButton(
                  buttonText: LanguageItems.signoutButtonText,
                  onPressed: () {
                    notifier.logout(context);
                  },
                );
              }),
            ],
          ),
        ),
      )),
    );
  }
}
