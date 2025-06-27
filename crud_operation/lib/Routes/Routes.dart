import 'package:crud_operation/Routes/RoutesName.dart';
import 'package:crud_operation/view_/home_view.dart';
import 'package:crud_operation/view_/login_view.dart';
import 'package:crud_operation/view_/signup_view.dart';
import 'package:crud_operation/view_/splash_view.dart';
import 'package:crud_operation/view_/upload_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings firebase) {
    switch (firebase.name) {
      case Routesname.splash:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) => SplashView(),
          );
        }

      case Routesname.login:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) => LoginView(),
          );
        }

      case Routesname.signup:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) => SignupView(),
          );
        }

      case Routesname.home:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) => HomeView(),
          );
        }

      case Routesname.upload:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) => UploadScreen(),
          );
        }

      default:
        {
          return MaterialPageRoute(
            builder:
                (_) => const Scaffold(
                  body: Center(child: Text('No Route Defined')),
                ),
          );
        }
    }
  }
}
