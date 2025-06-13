import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CrudProvider with ChangeNotifier{
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final updatefirstName = TextEditingController();
  final updatelastName = TextEditingController();

  bool isloading = false;

  //create data fuunction
  Future<void> createData(BuildContext context) async {
    isloading = true;
    notifyListeners();
    try {
      await FirebaseFirestore.instance.collection('CRUD OPERATION').add({
        'firstName':firstNameController.text,
        'lastName':lastNameController.text,
      });
      print('Data created successfully');

      Flushbar(
        message: "Data Created Successfully ",
        icon: Icon(Icons.check_circle, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP, // or BOTTOM
      ).show(context);
      isloading = false;
      notifyListeners();
    } catch (e) {
      print('Error creating data: $e');
      Flushbar(
        message: "Data Created failed to create",
        icon: Icon(Icons.check_circle, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP, // or BOTTOM
      ).show(context);
      isloading = false;
      notifyListeners();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  //read data function
  Stream<QuerySnapshot> readData(BuildContext context) {
    return FirebaseFirestore.instance.collection('CRUD OPERATION').snapshots();
  }

  //update data dialoge box
  Future<void> updateDialoge(BuildContext context, String id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Data', style: TextStyle(color: Colors.blue)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: updatefirstName,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Update first Name',
                    hintText: 'Enter update first Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: updatelastName,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Update last Name',
                    hintText: 'Enter update last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                  ),
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),

            ElevatedButton(
              onPressed: () {
                updateData(id, context);
                updatefirstName.clear();
                updatelastName.clear();
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // update data function

  Future<void> updateData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('CRUD OPERATION')
          .doc(id)
          .update({
            'firstName': updatefirstName.text,
            'lastName': updatelastName.text,
          });
      print('Data Updated Successfully');
      Flushbar(
        message: "Data Updated Successfully ",
        icon: Icon(Icons.check_circle, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP, // or BOTTOM
      ).show(context);
    } catch (e) {
      // ignore: avoid_print
      print('Error updating data: $e');
      Flushbar(
        message: "Data Updated issue  ",
        icon: Icon(Icons.check_circle, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP, // or BOTTOM
      ).show(context);
    }
  }

  //delete data function
  Future<void> deleteData(String id, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('CRUD OPERATION')
          .doc(id)
          .delete();
      print('Data deleted successfully');
      Flushbar(
        message: "Data Deleted Successfully ",
        icon: Icon(Icons.check_circle, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP, // or BOTTOM
      ).show(context);
    } catch (e) {
      print('Error deleting data: $e');
      Flushbar(
        message: "Data Deleted issue  ",
        icon: Icon(Icons.check_circle, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP, // or BOTTOM
      ).show(context);
    }
  }
}