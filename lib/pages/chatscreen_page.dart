import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler_chatbox/pages/messagescreen_page.dart';

class ChatScreenPgae extends StatefulWidget {
  const ChatScreenPgae({Key? key}) : super(key: key);

  @override
  State<ChatScreenPgae> createState() => _ChatScreenPgaeState();
}

class _ChatScreenPgaeState extends State<ChatScreenPgae> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
    body:ListView.builder(
        itemCount: 5,
          itemBuilder: (context,index){
            return ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessageScreenPage()));
              },
              leading: CircleAvatar(backgroundColor: Colors.blue,),
              title: Text("Raj",style: TextStyle(fontSize: 18,color: Colors.white),),
              subtitle: Text("Typing...",style: TextStyle(color: Colors.white),),
            );

          }),
    );

  }
}
