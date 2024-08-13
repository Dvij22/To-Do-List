import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  final firebase = FirebaseFirestore.instance;

  Future<void> addNote(String text) async {
    final timeStamp = FieldValue.serverTimestamp();
    await firebase
        .collection('notes')
        .add({'text': text, 'timestamp': timeStamp});
  }

  Future<void> updateNote(String id, String text) async {
    await firebase.collection('notes').doc(id).update({'text': text});
  }

  Future<void> deleteNote(String id) async {
    await firebase.collection('notes').doc(id).delete();
  }
}
