import 'package:crud_operation/Routes/RoutesName.dart';
import 'package:crud_operation/view_/login_view.dart';
import 'package:crud_operation/view_/signup_view.dart';
import 'package:crud_operation/view_/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

      default:
      {
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('No Route Defined'),
                  ),
                ));
      }
    }
  }
}
