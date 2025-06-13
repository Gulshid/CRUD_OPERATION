import 'package:another_flushbar/flushbar.dart';
import 'package:crud_operation/Routes/RoutesName.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isloading = false;

  //Future function login
  Future<void> login(BuildContext context) async {
    isloading = true;
    notifyListeners();

    try {
      UserCredential userid = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      if (userid.user!.uid.isNotEmpty) {
        Flushbar(
          message: "logged in Successfully",
          icon: Icon(Icons.check_circle, color: Colors.white),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.blue,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);

        Navigator.pushReplacementNamed(context, Routesname.home);
        print("user id: ${userid.user!.uid}");
        isloading = false;
        notifyListeners();
      } else {
        Flushbar(
          message: "User Does not Exist",
          icon: Icon(Icons.error, color: Colors.white),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);

        isloading = false;
        notifyListeners();
      }
    } catch (e) {
      isloading = false;
      notifyListeners();
      print('Error during login: $e');
      Flushbar(
        message: "Something Went Wrong",
        icon: Icon(Icons.error, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    } finally {
      isloading = true;
      notifyListeners();
    }
  }
}
