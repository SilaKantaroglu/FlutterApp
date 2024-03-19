import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';
import 'package:staj_case/pages/calendarPage/calendar_detail.dart';
import 'package:staj_case/pages/calendarPage/calendar_page.dart';
import 'package:staj_case/pages/weatherPage/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 300,
              width: screenWidth / 1.1,
              child: Card(
                elevation: 3,
                shadowColor: ColorUtility.grey.withOpacity(0.5),
                color: ColorUtility.white,
                child: Stack(
                  children: [
                    const Center(child: CalendarPage()),
                    TextButton(
                      style: const ButtonStyle(),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Takvim(),
                            ));
                      },
                      child: Text('Etkinlikler', style: _textStyle()),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(height: 400, width: 400, child: WeatherPage()),
          ),
        ],
      ),
    ));
  }

  TextStyle _textStyle() => const TextStyle(fontSize: 14, color: ColorUtility.grey);
}
