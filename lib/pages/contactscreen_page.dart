import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Select Contact"),
        actions: [
          Icon(Icons.search_outlined),
        ],
      ),
      body:Column(),

    );
  }
}
