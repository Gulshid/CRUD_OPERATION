// ignore_for_file: dead_code

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CrudProvider with ChangeNotifier {
  final CollectionReference crud = FirebaseFirestore.instance.collection(
    'CRUD OPERATION',
  );

  final TextEditingController textController = TextEditingController();

  //dialoge box for open a field
  void openDialoge(BuildContext context, {String? docid}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Add Notes',
              style: GoogleFonts.aBeeZee(color: Colors.black),
            ),
          ),
          content: TextField(
            controller: textController,
            style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20.sp),
            decoration: InputDecoration(
              label: Text(
                'Notes',
                style: GoogleFonts.aBeeZee(color: Colors.black),
              ),
              hintText: 'Add Notes',
              hintStyle: GoogleFonts.aBeeZee(
                color: Colors.grey,
                fontSize: 20.sp,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),

          actions: [
            ElevatedButton(
              onPressed: () {
                if (docid == null) {
                  createNote(textController.text, context);
                } else {
                  updateNote(docid, textController.text, context);
                }

                textController.clear();
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  'Add',
                  style: GoogleFonts.aBeeZee(
                    color: Colors.blue,
                    fontSize: 22.sp,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //MAKING A FUNCTION FOR CREATE
  Future<void> createNote(String note, BuildContext context) {
    return crud.add({'note': note, 'timestamp': Timestamp.now()});
    Flushbar(
      message: "Data Created Successfully",
      icon: Icon(Icons.check_circle, color: Colors.white),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.blue,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
    notifyListeners();
  }

  //MAKING A FUNCTION FOR READ
  Stream<QuerySnapshot> getnote(BuildContext context) {
    final notesStream = crud.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
    Flushbar(
      message: "Data is Read Successfully",
      icon: Icon(Icons.check_circle, color: Colors.white),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.blue,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
    notifyListeners();

  }

  //MAKING A FUNCTION FOR UPDDATE
  Future<void> updateNote(String id, String newnote, BuildContext context) {
    return crud.doc(id).update({'note': newnote, 'timestamp': Timestamp.now()});
    Flushbar(
      message: "Data is update Successfully",
      icon: Icon(Icons.check_circle, color: Colors.white),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.blue,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
    notifyListeners();

  }

  //MAKING A FUNCTION FOR DELETE
  Future<void> deleteNote(String docid, BuildContext context) {
    return crud.doc(docid).delete();
    Flushbar(
      message: "Data is Delete Successfully",
      icon: Icon(Icons.check_circle, color: Colors.white),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.blue,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
    notifyListeners();

  }
}
