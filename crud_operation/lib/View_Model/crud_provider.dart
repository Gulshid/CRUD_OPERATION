import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CrudProvider with ChangeNotifier{
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('items');

  // CREATE
  Future<void> createItem(String id, Map<String, dynamic> data) async {
    await _dbRef.child(id).set(data);
    notifyListeners();
  }

  // READ (Stream for real-time updates)
  Stream<DatabaseEvent> readItems() {
    return _dbRef.onValue;
  }

  // UPDATE
  Future<void> updateItem(String id, Map<String, dynamic> data) async {
    await _dbRef.child(id).update(data);
    notifyListeners();
  }

  // DELETE
  Future<void> deleteItem(String id) async {
    await _dbRef.child(id).remove();
    notifyListeners();
  }
}