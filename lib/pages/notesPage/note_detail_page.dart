import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'edit_note_page.dart';
import 'note_model.dart';
import 'notes_database.dart';
import 'package:staj_case/components/colors.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;
  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  NoteDetailPageState createState() => NoteDetailPageState();
}

class NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future<void> refreshNote() async {
    setState(() => isLoading = true);
    note = await NotesDatabase.instance.readNote(widget.noteId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: ColorUtility.darkBabyBlueButton),
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                        color: ColorUtility.black,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd('tr_TR').format(note.createdTime),
                      style: const TextStyle(color: ColorUtility.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      note.description,
                      style: const TextStyle(color: ColorUtility.black, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
        color: ColorUtility.darkBabyBlueButton,
        iconSize: 30,
        icon: const Icon(CupertinoIcons.pencil_outline),
        onPressed: () async {
          if (isLoading) return;
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEditNotePage(note: note),
          ));
          await refreshNote();
        },
      );

  Widget deleteButton() => IconButton(
        color: ColorUtility.darkBabyBlueButton,
        focusColor: Colors.black,
        iconSize: 30,
        icon: const Icon(CupertinoIcons.delete),
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
                      NotesDatabase.instance.delete(widget.noteId);
                    },
                  ),
                ],
              );
            },
          );
          if (confirmed == true) {
            await NotesDatabase.instance.delete(widget.noteId);
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop(true);
          }
        },
      );
}
