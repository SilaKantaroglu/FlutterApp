import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staj_case/components/colors.dart';
import 'package:staj_case/pages/bottom_menu_page.dart';
import 'package:staj_case/pages/login/login_page.dart';
import 'package:staj_case/provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UiProvider()..initStorage(),
      child: Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
        return MaterialApp(
          title: 'Staj Project',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.jostTextTheme(),
            cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            iconTheme: const IconThemeData(
              color: ColorUtility.darkBabyBlueButton,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(color: ColorUtility.blackShade),
              prefixIconColor: ColorUtility.darkBabyBlue,
              border: InputBorder.none,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              //backgroundColor: Color.fromARGB(161, 210, 231, 248),
              iconSize: 40,
            ),
            bottomAppBarTheme: const BottomAppBarTheme(
                //shape: CircularNotchedRectangle(),
                ),
            appBarTheme: AppBarTheme(
                toolbarHeight: 40,
                centerTitle: true,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                titleTextStyle: TextStyle(
                  color: ColorUtility.purple,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: AutofillHints.birthday,
                  letterSpacing: 3,
                ),
                titleSpacing: 0.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                shadowColor: Colors.black38),
          ),
          home: notifier.rememberMe ? const MenuPage() : const LoginPage(),
        );
      }),
    );
  }
}
