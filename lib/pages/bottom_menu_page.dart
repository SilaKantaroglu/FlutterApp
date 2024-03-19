import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:staj_case/components/colors.dart';
import 'package:staj_case/pages/homePage/home_page.dart';
import 'package:staj_case/pages/moneyPage/home_money.dart';
import 'package:staj_case/pages/newsPage/news_page.dart';
import 'package:staj_case/pages/notesPage/notes_page.dart';
import 'package:staj_case/pages/pharmacy/pharmacy_page.dart';
import 'package:staj_case/pages/profile/profile.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const NewsPage(),
    const HomeMoneyPage(),
    const PharmacyPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(),
                      ));
                },
                icon: _penIcon()),
          )
        ],
      ),
      drawer: const Drawer(child: ProfilePage()),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: ColorUtility.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            padding: const EdgeInsets.all(16),
            tabActiveBorder: Border.all(color: ColorUtility.purple, width: 1),
            gap: 8,
            textStyle: _textStyle(),
            curve: Curves.easeInCirc,
            textSize: 30,
            duration: const Duration(milliseconds: 900),
            selectedIndex: _currentIndex,
            onTabChange: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: Ionicons.home_outline,
                text: 'Anasayfa',
              ),
              GButton(
                icon: Ionicons.newspaper_outline,
                text: 'Haberler',
              ),
              GButton(
                icon: Ionicons.wallet_outline,
                text: 'Kur',
              ),
              GButton(
                icon: Ionicons.bandage_outline,
                text: 'Eczane',
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle() => TextStyle(fontWeight: FontWeight.w700, color: ColorUtility.purple);

  Icon _penIcon() => Icon(CupertinoIcons.pencil_ellipsis_rectangle, size: 30, color: ColorUtility.purple);
}
