import 'package:crud_operation/View_Model/Splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashProvider>(context, listen: false).setAllData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 36, 172),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Crud App',
              style: GoogleFonts.aBeeZee(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(17.r),
                topRight: Radius.circular(17.r),
                bottomLeft: Radius.circular(17.r),
                bottomRight: Radius.circular(17.r),
              ),
            ),
            backgroundColor: Colors.white,
            floating: true,
            pinned: true,

            expandedHeight: 150.h,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17.r),
                    topRight: Radius.circular(17.r),
                    bottomLeft: Radius.circular(17.r),
                    bottomRight: Radius.circular(17.r),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.indigo, Colors.purple, Colors.cyan],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: FlexibleSpaceBar(
                      background: Column(
                        children: [
                          SizedBox(height: 100.h),
                          Text(
                            'Welcome to Crud App',
                            style: GoogleFonts.abel(
                              color: Colors.orange,
                              fontSize: 30.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.purple, Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17.r),
                  topRight: Radius.circular(17.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),
                    Text(
                    'CRUD Operation App',
                    style: GoogleFonts.abel(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    SizedBox(height: 100.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(17.r),
                    child: Image.asset(
                      'assets/CRUD.webp',
                      fit: BoxFit.fill,
                      width: 130.w,
                      height: 100.h,
                    ),
                  ),

                  SizedBox(height: 100.h),
                  SpinKitFadingGrid(
                    color: Colors.amber,
                    size: 50.sp,
                  ), 
                  SizedBox(height: 100.h),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
