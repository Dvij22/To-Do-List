import 'package:flutter/material.dart';
import 'package:crud_app/services/firebase.dart';

final firebase = FireStore();

// ignore: must_be_immutable
class NotesWidget extends StatefulWidget {
  String notesText;
  String notesID;
  NotesWidget({super.key, required this.notesText, required this.notesID});

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  late String editedText;
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.notesText);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.notesText,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Edit Note"),
                              content: SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 100),
                                  child: TextField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                        hintText: "Enter a new note"),
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    onChanged: (value) {
                                      editedText = value;
                                    },
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      // fireStore
                                      //     .collection('notes')
                                      //     .doc(widget.notesID)
                                      //     .update({'text': editedText});
                                      firebase.updateNote(
                                          widget.notesID, editedText);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent),
                                    ))
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      // fireStore.collection('notes').doc(widget.notesID).delete();
                      firebase.deleteNote(widget.notesID);
                    },
                    icon: const Icon(Icons.delete))
              ],
            )
          ],
        ),
      ),
    );
  }
}
