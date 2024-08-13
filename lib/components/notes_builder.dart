import 'package:flutter/material.dart';
import 'package:crud_app/services/firebase.dart';
import 'package:crud_app/components/notes_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebase = FireStore();
final fireStore = FirebaseFirestore.instance;

class NotesBuilder extends StatelessWidget {
  const NotesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fireStore.collection('notes').orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          List<NotesWidget> notesWidgets = [];
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }

          final notes = snapshot.data!.docs.reversed;
          for (var note in notes) {
            final notesText = note['text'];

            final noteWidget = NotesWidget(
              notesText: notesText,
              notesID: note.id,
            );
            notesWidgets.add(noteWidget);
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: notesWidgets,
            ),
          );
        });
  }
}
