import 'package:flutter/material.dart';
import 'package:staj_case/pages/moneyPage/money/money_model.dart';
import 'package:staj_case/pages/moneyPage/money/money_service.dart';

import 'package:staj_case/pages/profile/profile.dart';

import 'money_card.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  List<Result> _moneyList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchMoney();
  }

  Future<void> _fetchMoney() async {
    MoneyModel? moneyModel = await MoneyService.fetchMoney();
    setState(() {
      _moneyList = moneyModel!.result!;
    });
  }

  Future<void> _refreshMoney() async {
    await _fetchMoney();
  }

  void _searchMoney(String name) {
    setState(() {
      _moneyList = _moneyList.where((element) => element.name!.toLowerCase().contains(name.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: ProfilePage(),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshMoney,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Görmek istediğiniz para birimini giriniz.',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchMoney(_searchController.text);
                  },
                ),
              ),
            ),
            Expanded(
              child: _moneyList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: _moneyList.length,
                      itemBuilder: (context, index) {
                        Result moneyItem = _moneyList[index];
                        return MoneyCard(
                          name: moneyItem.name,
                          selling: moneyItem.selling.toString(),
                          buying: moneyItem.buying.toString(),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
