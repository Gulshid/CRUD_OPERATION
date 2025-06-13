import 'package:crud_operation/View_Model/crud_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
      body: StreamBuilder<DatabaseEvent>(
        stream: crud_provider.readItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            final items = Map<String, dynamic>.from(
              snapshot.data!.snapshot.value as Map,
            );
            return ListView(
              children: items.entries.map((entry) {
                return ListTile(
                  title: Text(entry.value['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          crud_provider.updateItem(entry.key,{'name': 'updated name'} );
                          // Call updateItem here
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          crud_provider.deleteItem(entry.key);
                               // Call updateItem here
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          crud_provider.deleteItem(entry.key);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }
          return Center(child: Text('No data'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newId = FirebaseDatabase.instance.ref('items').push().key;
          if (newId != null) {
            crud_provider.createItem(newId, {'name': 'New Item'});
          }
        },
        child: Icon(Icons.add),
      ),
      
    );
  }
}