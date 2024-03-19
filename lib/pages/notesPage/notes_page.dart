import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';
import 'edit_note_page.dart';
import 'note_model.dart';
import 'note_card_widget.dart';
import 'note_detail_page.dart';
import 'notes_database.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  NotesPageState createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: ColorUtility.darkBabyBlueButton),
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? Text(
                      'Henüz not eklenmedi.',
                      style: TextStyle(color: ColorUtility.grey.withOpacity(0.3), fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40, right: 10),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: ColorUtility.darkBabyBlueButton,
            child: const Icon(
              CupertinoIcons.add,
              color: ColorUtility.white,
            ),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddEditNotePage()),
              );

              refreshNotes();
            },
          ),
        ),
      );

  Widget buildNotes() => ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
