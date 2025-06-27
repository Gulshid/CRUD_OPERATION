// ignore_for_file: dead_code

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
  void openDialoge(
    BuildContext context, {
    String? docid,
    VoidCallback? onupdated,
  }) async {
    if (docid != null) {
    final doc = await crud.doc(docid).get();
    textController.text = doc['note'] ?? '';
  } else {
    textController.clear();
  }
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
              onPressed: () async {
                if (docid == null) {
                  createNote(textController.text, context);
                textController.clear();
                Navigator.pop(context);
                } else {
                  await updateNote(docid, textController.text, context);
                textController.clear();
                Navigator.pop(context);
                  if (onupdated != null) onupdated();
                }

            
              },
              child: Center(
                child: Text(docid==null?
                  'Add':'Update',
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
  }

  //MAKING A FUNCTION FOR READ
  Stream<QuerySnapshot> getnote(BuildContext context) {
    final notesStream = crud.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  //MAKING A FUNCTION FOR UPDDATE
  Future<void> updateNote(String id, String newnote, BuildContext context) {
    return crud.doc(id).update({'note': newnote, 'timestamp': Timestamp.now()});
  }

  //MAKING A FUNCTION FOR DELETE
  Future<void> deleteNote(String docid, BuildContext context) {
    return crud.doc(docid).delete();
  }
}
