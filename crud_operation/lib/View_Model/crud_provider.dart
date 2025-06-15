// import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          content: TextField(
            controller: textController,
            style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20.sp),
            decoration: InputDecoration(
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
                  createNote(textController.text);
                } else {
                  updateNote(docid, textController.text);
                }

                textController.clear();
                Navigator.pop(context);
              },
              child: Center(
                child: Text('Add', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        );
      },
    );
  }

  //MAKING A FUNCTION FOR CREATE
  Future<void> createNote(String note) {
    return crud.add({'note': note, 'timestamp': Timestamp.now()});
  }

  //MAKING A FUNCTION FOR READ
  Stream<QuerySnapshot> getnote() {
    final notesStream = crud.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  //MAKING A FUNCTION FOR UPDDATE
  Future<void> updateNote(String id, String newnote) {
    return crud.doc(id).update({'note': newnote, 'timestamp': Timestamp.now()});
  }

  //MAKING A FUNCTION FOR DELETE
  Future<void> deleteNote(String docid) {
    return crud.doc(docid).delete();
  }
}
