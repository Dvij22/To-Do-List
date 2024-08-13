import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/services/firebase.dart';
import 'package:crud_app/components/notes_builder.dart';

final fireStore = FirebaseFirestore.instance;
final firebase = FireStore();

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Homepage> {
  late String note;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 152, 215, 241),
        title: const Center(
            child: Text(
          "To-Do List",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 152, 215, 241),
        child: const Icon(
          Icons.add,
          size: 30,
          weight: 30,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Notes"),
                content: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: TextField(
                      controller: controller,
                      decoration:
                          const InputDecoration(hintText: "Enter your note"),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        // final timeStamp = FieldValue.serverTimestamp();
                        note = controller.text;
                        if (note.isNotEmpty) {
                          // fireStore
                          //     .collection('notes')
                          //     .add({'text': note, 'timestamp': timeStamp});
                          firebase.addNote(note);
                          Navigator.pop(context);
                          controller.clear();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.lightBlueAccent),
                      ))
                ],
              );
            },
          );
        },
      ),
      body: const SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: NotesBuilder(),
        ),
      )),
    );
  }
}
