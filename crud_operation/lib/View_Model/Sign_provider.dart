import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignProvider with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isloading = false;

  // Future function for  Sign up
  Future<void> Signup(BuildContext context) async {
    isloading = true;
    notifyListeners();

    try {
      UserCredential userid=await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Flushbar(
        message: "Data Created Successfully ",
        icon: Icon(Icons.check_circle, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP, 
      ).show(context);

      print("User ID : ${userid.user?.uid}");
    } catch (e) {
      print('Error During Sign Up: $e');
      Flushbar(
        message: "Error During Sign up ",
        icon: Icon(Icons.error, color: Colors.white),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP, 
      ).show(context);
    } finally {
      isloading = false;
      notifyListeners();
    }


  
  // function for dispose all the parameters  
    @override
    // ignore: unused_element
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }
  }
}
