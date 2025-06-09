
import 'package:crud_operation/Routes/Routes.dart';
import 'package:crud_operation/Routes/RoutesName.dart';
import 'package:crud_operation/View_Model/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LoginProvider()),
            ChangeNotifierProvider(create: (_) => LoginProvider())
          
          ],

          child: Builder(
            builder: (BuildContext context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Crud Operation',
                theme: ThemeData(
                  applyElevationOverlayColor: true,
                  brightness: Brightness.light,
                  appBarTheme: AppBarTheme(color: Colors.teal),
                  primarySwatch: Colors.blue,
                  textTheme: Typography.englishLike2018.apply(
                    fontSizeFactor: 1.sp,
                  ),
                ),

                initialRoute: Routesname.splash,
                onGenerateRoute: Routes.generateRoute,
              );
            },
          ),
        );
      },
    );
  }
}