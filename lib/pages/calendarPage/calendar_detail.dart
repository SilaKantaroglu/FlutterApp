// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:staj_case/components/colors.dart';
import 'package:staj_case/pages/calendarPage/calendar_database.dart';
import 'package:table_calendar/table_calendar.dart';

class Takvim extends StatefulWidget {
  const Takvim({Key? key}) : super(key: key);

  @override
  TakvimState createState() => TakvimState();
}

class TakvimState extends State<Takvim> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _selectedDate;
  late Map<DateTime, List<dynamic>> _events;
  late TextEditingController _eventController;
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _events = {};
    _eventController = TextEditingController();
    _databaseHelper = DatabaseHelper();
    _loadEvents();
    initializeDateFormatting('tr_TR', null);
  }

  Future<void> _loadEvents() async {
    final events = await _databaseHelper.getEvents();
    setState(() {
      _events = events;
    });
  }

  Future<void> _addEvent() async {
    if (_selectedDate.isBefore(DateTime.now())) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Hatalı Tarih Seçimi'),
          content: const Text('Bugünden önceki bir tarihe etkinlik ekleyemezsiniz.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Etkinlik Ekle'),
          content: TextField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
            cursorColor: ColorUtility.black,
            controller: _eventController,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_eventController.text.isNotEmpty) {
                  final event = _eventController.text;
                  final newEvent = Event(_selectedDate, event);
                  await _databaseHelper.addEvent(newEvent);
                  setState(() {
                    if (_events[_selectedDate] != null) {
                      _events[_selectedDate]!.add(event);
                    } else {
                      _events[_selectedDate] = [event];
                    }
                  });
                }
                _eventController.clear();
                Navigator.pop(context);
              },
              child: const Text('Ekle'),
            ),
            TextButton(
              onPressed: () {
                _eventController.clear();
                Navigator.pop(context);
              },
              child: const Text('İptal'),
            ),
          ],
        ),
      );
    }
  }

  List<dynamic> _getEventsForDay(DateTime date) {
    return _events[date] ?? [];
  }

  Future<void> _deleteEvent(String event) async {
    await _databaseHelper.deleteEvent(event);
    setState(() {
      _events[_selectedDate]!.remove(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Transform.scale(
              scale: 0.95,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtility.lightPurple,
                ),
                child: TableCalendar(
                  locale: 'tr_TR',
                  calendarFormat: _calendarFormat,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Ay',
                    CalendarFormat.week: 'Hafta',
                  },
                  headerStyle: const HeaderStyle(titleCentered: true),
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  selectedDayPredicate: (date) {
                    return isSameDay(date, _selectedDate);
                  },
                  firstDay: DateTime.utc(2021, 1, 1),
                  lastDay: DateTime.utc(2024, 12, 31),
                  focusedDay: _selectedDate,
                  eventLoader: _getEventsForDay,
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: ColorUtility.darkBabyBlue,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: ColorUtility.darkBabyBlueButton,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: ColorUtility.white,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedTextStyle: TextStyle(
                      color: ColorUtility.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onDaySelected: (date, events) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _addEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtility.darkBabyBlueButton,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Etkinlik Ekle',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    color: ColorUtility.white,
                  ),
                ),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Seçili Tarihteki Etkinlikler:',
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _events[_selectedDate]?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final event = _events[_selectedDate]![index];
                return ListTile(
                  title: Text(event),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      bool confirmed = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Emin misiniz?"),
                            content: const Text("Bu öğeyi silmek istediğinize emin misiniz?"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Hayır"),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text("Evet"),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          );
                        },
                      );
                      if (confirmed == true) {
                        await _deleteEvent(event);
                        Navigator.of(context).pop(true);
                      }
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
