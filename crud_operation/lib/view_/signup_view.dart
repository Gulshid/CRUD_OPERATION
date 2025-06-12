import 'package:crud_operation/Routes/RoutesName.dart';
import 'package:crud_operation/View_Model/Sign_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    final sign_Provider = Provider.of<SignProvider>(context);
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Sign Up',
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
                            'Welcome to Sign Up',
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    Text(
                      'Sign Up Now',
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    TextFormField(
                      controller: sign_Provider.emailController,
                      style: GoogleFonts.aBeeZee(
                        color: Colors.black,
                        fontSize: 20.sp,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: GoogleFonts.aBeeZee(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        prefixIcon: Icon(Icons.email, color: Colors.indigo),
                        hintText: 'Enter your email',
                        hintStyle: GoogleFonts.aBeeZee(
                          color: Colors.grey,
                          fontSize: 20.sp,
                        ),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 3.w,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 3.w,
                          ),
                        ),

                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 3.w,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: sign_Provider.passwordController,
                      style: GoogleFonts.aBeeZee(
                        color: Colors.black,
                        fontSize: 20.sp,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: GoogleFonts.aBeeZee(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.indigo,
                        ),
                        hintText: 'Enter your password',
                        hintStyle: GoogleFonts.aBeeZee(
                          color: Colors.grey,
                          fontSize: 20.sp,
                        ),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 3.w,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 3.w,
                          ),
                        ),

                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 3.w,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      onPressed: () async{
                        await sign_Provider.Signup(context);
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Text.rich(
                      TextSpan(
                        text: 'Already have an account?',
                        style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 17.sp,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login Now',
                            style: GoogleFonts.aBeeZee(
                              color: Colors.lightGreen,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                      context,
                                      Routesname.login,
                                    );
                                  },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 150.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
