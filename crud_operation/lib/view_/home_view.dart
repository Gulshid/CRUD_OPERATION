import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operation/View_Model/crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: StreamBuilder<QuerySnapshot>(
        stream: crud_provider.getnote(),
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

                String noteText = data['note'];

                return ListTile(
                  title: Text(noteText, style: TextStyle(color: Colors.black)),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          crud_provider.openDialoge(context, docid: docId); 
                        },
                        icon: Icon(Icons.edit, color: Colors.blue, size: 20.sp),
                      ),

                      IconButton(
                        onPressed: () {
                          crud_provider.deleteNote(docId);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20.sp,
                        ),
                      ),
                    ],
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
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
