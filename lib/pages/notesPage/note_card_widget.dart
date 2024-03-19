import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staj_case/components/colors.dart';
import 'note_model.dart';

final _lightColors = [
  const Color.fromARGB(255, 66, 99, 163), // Mavi tonu
  const Color.fromARGB(255, 76, 204, 161), // Yeşil tonu
  const Color.fromARGB(255, 246, 176, 107), // Turuncu tonu
  const Color.fromARGB(255, 204, 153, 204), // Mor tonu
  const Color.fromARGB(255, 255, 223, 125), // Sarı tonu
  const Color(0xFF66CCCC), // Turkuaz tonu
];

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd('tr_TR').format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Card(
        color: color,
        child: Container(
          constraints: BoxConstraints(minHeight: minHeight),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  color: ColorUtility.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                note.title,
                style: const TextStyle(
                  color: ColorUtility.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 50;
      case 2:
        return 100;
      case 3:
        return 150;
      default:
        return 100;
    }
  }
}
