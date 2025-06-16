import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      // ignore: deprecated_member_use
      backgroundColor: Colors.lime,
      appBar: AppBar(
        title: Text('CRUD APP', style: GoogleFonts.abel(color: Colors.white, fontSize: 30.sp),),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r))),
          scrolledUnderElevation:2.0 ,

          toolbarHeight: 80.h,
      ),
        body:  StreamBuilder<QuerySnapshot>(
              stream: crud_provider.getnote(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List notelist = snapshot.data!.docs;
                  return ListView.builder(
              itemCount: notelist.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = notelist[index];
                String docId = document.id;
            
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
            
                String noteText = data['note'] ?? 'no notes';
            
                return Card(
                  // ignore: deprecated_member_use
                  color: Colors.teal.withOpacity(0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      title: Text(noteText, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              crud_provider.openDialoge(context, docid: docId, 
                              onupdated: (){
                                Flushbar(
                              message: "Data Updated Sucessfully",
                              icon: Icon(Icons.check_circle, color: Colors.white),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.blue,
                              margin: EdgeInsets.all(8),
                              borderRadius: BorderRadius.circular(8),
                              flushbarPosition: FlushbarPosition.TOP,
                            ).show(context);
                              }
                              
                              ); 
                            },
                            icon: Icon(Icons.edit, color: Colors.blue, size: 25.sp),
                          ),
                    
                          IconButton(
                            onPressed: () {
                              crud_provider.deleteNote(docId, context);
                              Flushbar(
                              message: "Data Deleted Successfully",
                              icon: Icon(Icons.check_circle, color: Colors.white),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.blue,
                              margin: EdgeInsets.all(8),
                              borderRadius: BorderRadius.circular(8),
                              flushbarPosition: FlushbarPosition.TOP,
                            ).show(context);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 25.sp,
                            ),
                          ),
                    
                        ],
                      ),
                    
                    
                    ),
                  ),
                );
                
              },
              );
            } else {
              return Center(child: Text('no notes data'));
            }
          },
        ),

        
        

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          crud_provider.openDialoge(context);
      Flushbar(
      message: "Dialoge is Open Successfully",
      icon: Icon(Icons.check_circle, color: Colors.white),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.blue,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
