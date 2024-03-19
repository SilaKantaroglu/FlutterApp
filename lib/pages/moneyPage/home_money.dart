import 'package:flutter/material.dart';
import 'package:staj_case/pages/moneyPage/bourse/bourse_page.dart';
import 'package:staj_case/pages/moneyPage/cripto/cripto_page.dart';
import 'package:staj_case/pages/moneyPage/money/money_page.dart';

class HomeMoneyPage extends StatefulWidget {
  const HomeMoneyPage({super.key});

  @override
  State<HomeMoneyPage> createState() => _HomeMoneyPageState();
}

class _HomeMoneyPageState extends State<HomeMoneyPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Döviz'),
          Tab(text: 'Borsa'),
          Tab(text: 'Kripto'),
        ],
      ),
      body: _myTabbarView(),
    );
  }

  TabBarView _myTabbarView() {
    return TabBarView(
      controller: _tabController,
      children: const [MoneyPage(), BoursePage(), CriptoPage()],
    );
  }
}
