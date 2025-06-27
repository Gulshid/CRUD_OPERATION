import 'package:crud_operation/Routes/RoutesName.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  //function to set the loading state
  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  // function for splash screen set for time
  void Splash(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      final user = FirebaseAuth.instance.currentUser;
      if(user!=null){
        Navigator.pushReplacementNamed(context, Routesname.home);
      }
      else{
        Navigator.pushReplacementNamed(context, Routesname.login);
      }
    });
  }

  //function for set all the data
  void setAllData(BuildContext context) {
    setLoading(true);
    Splash(context);
    setLoading(false);
  }
}
