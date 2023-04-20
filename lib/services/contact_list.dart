import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:scheduler_chatbox/pages/messagescreen_page.dart';
class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState(){
    super.initState();
    getContacts();

  }

  Future<void> getContacts() async {
    try{
      if( await FlutterContacts.requestPermission(readonly: true)){
        List<Contact> contacts = await FlutterContacts.getContacts();
        setState(() {
          _contacts= contacts;
        });
      }
    } catch(e){
      print(e.toString());

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      _body(),
    );
  }

  Widget _body() {
    if (_permissionDenied) return Center(child: Text('Permission denied'));
    if (_contacts == null) return const Center(child: CircularProgressIndicator());
    return ListView.builder(
      itemCount: _contacts!.length,
        itemBuilder:(context,index){
        return ListTile(
          title: Text(_contacts![index].displayName),
          onTap: ()=>  Navigator.push(context,
              MaterialPageRoute(builder: (context)=>MessageScreenPage())),
        );

    });
  }
}