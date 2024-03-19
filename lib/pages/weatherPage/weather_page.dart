import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';
import 'package:staj_case/pages/weatherPage/weather_card.dart';
import 'package:staj_case/pages/weatherPage/weather_model.dart';
import 'package:staj_case/pages/weatherPage/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _selectedCity = 'Ankara';
  List<Result> _weatherList = [];
  Future<void> _fetchWeather(String selectedCity) async {
    WeatherModel? weatherModel = await WeatherService.fetchWeather(city: selectedCity);
    if (mounted) {
      setState(() {
        _weatherList = weatherModel.result ?? [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather(_selectedCity);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
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
                      _myTextSeletedCityTitle('Hava Durumu '),
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
            child: _weatherList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _weatherList.length,
                    itemBuilder: (context, index) {
                      Result weatherItem = _weatherList[index];
                      return WeatherCard(
                        date: weatherItem.date,
                        degree: weatherItem.degree,
                        description: weatherItem.description,
                        humidity: weatherItem.humidity,
                        max: weatherItem.max,
                        min: weatherItem.min,
                      );
                    },
                  ),
          ),
        ],
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
                  _fetchWeather(value);
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
