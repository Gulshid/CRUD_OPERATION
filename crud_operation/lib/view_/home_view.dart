import 'package:crud_operation/View_Model/crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
      final crud_provider = Provider.of<CrudProvider>(context);
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Crud Operation',
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
                            'Welcome to New Users',
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
          child:Container(
            height: 520.h,
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
              children: [
                SizedBox(height: 50.h,),
                Text(
              'CRUD Operation',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: crud_provider.firstNameController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'FirstName',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter  first name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.sp),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: crud_provider.lastNameController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'LastName',
                  hintText: 'Enter last Name',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),
            GestureDetector(
              onTap: () async {
                await crud_provider.createData(context);
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12.r),
                ),

                child:
                    crud_provider.isloading
                        ? Center(child: CircularProgressIndicator())
                        : Center(
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
              ),
            ),

            Divider(),
            Expanded(
              child: StreamBuilder(
                stream: crud_provider.readData(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                    child: Text(
                    'data error',
                    style: TextStyle(color: Colors.red),
                    ),
                    );
                  } else if (snapshot.hasData) {
                    final datas = snapshot.data!.docs;
                    if (datas.isEmpty) {
                    return Center(
                    child: Text(
                    'no data found',
                    style: TextStyle(color: Colors.red),
                    ),
                    );
                    }
                    return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return Card(
                    child: ListTile(
                    title: Text(
                    data['firstName'].toString(),
                    style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                    data['lastName'].toString(),
                    style: TextStyle(color: Colors.black),
                    ),
                    trailing: Row(
                    children: [
                    GestureDetector(
                    onTap: () {
                    crud_provider.updateDialoge(
                    context,
                    data.id,
                    );
                    },
                    child: Icon(Icons.edit, color: Colors.blue),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                    onTap: () {
                    crud_provider.deleteData(data.id, context);
                    },
                    child: Icon(Icons.delete, color: Colors.red),
                    ),
                    ],
                    ),
                    ),
                    );
                    }
                    );

                  }
 return Container(); // Add a default return statement
                },
              ),
            ),
                
              ],
            ),
          ) ,)      
        ],
      )
      
    );
  }
}