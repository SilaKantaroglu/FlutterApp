import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';
import 'package:staj_case/pages/pharmacy/pharmacy_card.dart';
import 'package:staj_case/pages/pharmacy/pharmacy_model.dart';
import 'package:staj_case/pages/pharmacy/pharmacy_service.dart';
import 'package:staj_case/pages/profile/profile.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({Key? key}) : super(key: key);

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  String _selectedCity = 'Ankara';
  List<Result> _pharmacyList = [];

  @override
  void initState() {
    super.initState();
    _fetchPharmacy(_selectedCity);
  }

  Future<void> _fetchPharmacy(String selectedCity) async {
    PharmacyModel? pharmacyModel = await PharmacyService.fetchPharmacy(il: selectedCity);
    if (mounted) {
      setState(() {
        _pharmacyList = pharmacyModel?.result ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        drawer: const Drawer(
          child: ProfilePage(),
        ),
        body: Column(
          children: [
            const Divider(),
            Container(
              height: 110,
              decoration: _myBoxDecoration(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _myTextSeletedCityTitle('Nöbetçi Eczaneler '),
                        _myTextSelectedCity(),
                      ],
                    ),
                  ),
                  _myTextField(searchController),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: _pharmacyList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _pharmacyList.length,
                      itemBuilder: (context, index) {
                        Result pharmacyItem = _pharmacyList[index];
                        return PharmacyCard(
                          name: pharmacyItem.name,
                          addres: pharmacyItem.address,
                          phone: pharmacyItem.phone,
                          dist: pharmacyItem.dist,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Text _myTextSelectedCity() {
    return Text(
      _selectedCity,
      style: _myTextStyle(),
    );
  }

  Text _myTextSeletedCityTitle(String? title) {
    return Text(
      title!,
      style: _myTextStyle(),
    );
  }

  TextStyle _myTextStyle() {
    return const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: ColorUtility.white,
    );
  }

  SizedBox _myTextField(TextEditingController searchController) {
    return SizedBox(
      height: 65,
      child: Card(
        color: ColorUtility.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
              controller: searchController,
              decoration: _myInputDecoration('Şehir Giriniz:'),
              onSubmitted: (value) {
                if (value != ' ') {
                  setState(() {
                    _selectedCity = value;
                  });
                  _fetchPharmacy(value);
                } else {
                  value = 'ankara';
                }
              }),
        ),
      ),
    );
  }

  InputDecoration _myInputDecoration(String? labelText) {
    return InputDecoration(
      labelStyle: const TextStyle(
        fontSize: 15,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        color: ColorUtility.blackShade,
      ),
      labelText: labelText,
      suffixIcon: Icon(
        Icons.search,
        color: ColorUtility.blackShade.withOpacity(0.6),
      ),
    );
  }

  BoxDecoration _myBoxDecoration() {
    return BoxDecoration(
      color: ColorUtility.darkBabyBlueButton,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: ColorUtility.blackShade.withOpacity(0.1),
        width: 1.0,
      ),
    );
  }
}
