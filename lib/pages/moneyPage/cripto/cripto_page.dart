import 'package:flutter/material.dart';
import 'package:staj_case/pages/moneyPage/cripto/cripto_card.dart';
import 'package:staj_case/pages/moneyPage/cripto/cripto_service.dart';
import 'package:staj_case/pages/profile/profile.dart';

import 'cripto_model.dart';

class CriptoPage extends StatefulWidget {
  const CriptoPage({super.key});

  @override
  State<CriptoPage> createState() => _CriptoPageState();
}

class _CriptoPageState extends State<CriptoPage> {
  List<Result> _criptoList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCripto();
  }

  Future<void> _fetchCripto() async {
    CriptoModel? criptoModel = await CriptoService.fetchCripto();
    if (criptoModel != null && mounted) {
      setState(() {
        _criptoList = criptoModel.result ?? [];
      });
    }
  }

  Future<void> _refreshCripto() async {
    await _fetchCripto();
  }

  void _searchMoney(String name) {
    if (mounted) {
      setState(() {
        _criptoList = _criptoList.where((element) => element.name!.toLowerCase().contains(name.toLowerCase())).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: ProfilePage(),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCripto,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
                hintText: 'Görmek istediğiniz kripto birimini giriniz.',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchMoney(_searchController.text);
                  },
                ),
              ),
            ),
            Expanded(
              child: _criptoList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: _criptoList.length,
                      itemBuilder: (context, index) {
                        Result moneyItem = _criptoList[index];
                        return CriptoCard(
                          name: moneyItem.name,
                          changeDaystr: moneyItem.changeDaystr,
                          changeWeekstr: moneyItem.changeWeekstr,
                          currency: moneyItem.currency,
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
