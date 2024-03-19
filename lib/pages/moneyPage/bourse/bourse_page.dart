import 'package:flutter/material.dart';
import 'package:staj_case/pages/moneyPage/bourse/bourse_card.dart';
import 'package:staj_case/pages/moneyPage/bourse/bourse_model.dart';
import 'package:staj_case/pages/moneyPage/bourse/bourse_service.dart';
import 'package:staj_case/pages/profile/profile.dart';

class BoursePage extends StatefulWidget {
  const BoursePage({super.key});

  @override
  State<BoursePage> createState() => _BoursePageState();
}

class _BoursePageState extends State<BoursePage> {
  List<Result> _bourseList = [];

  @override
  void initState() {
    super.initState();
    _fetchBourse();
  }

  Future<void> _fetchBourse() async {
    BourseModel? bourseModel = await BourseService.fetchBourse();
    if (bourseModel != null && mounted) {
      setState(() {
        _bourseList = bourseModel.result ?? [];
      });
    }
  }

  Future<void> _refreshBourse() async {
    await _fetchBourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: ProfilePage(),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshBourse,
        child: Column(
          children: [
            Expanded(
              child: _bourseList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: _bourseList.length,
                      itemBuilder: (context, index) {
                        Result bourseItem = _bourseList[index];
                        return BourseCard(
                          name: bourseItem.name,
                          pricestr: bourseItem.pricestr,
                          time: bourseItem.time,
                          currency: bourseItem.currency,
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
