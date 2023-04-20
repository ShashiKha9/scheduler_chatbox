import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler_chatbox/pages/chatscreen_page.dart';
import 'package:scheduler_chatbox/pages/messagescreen_page.dart';
import 'package:scheduler_chatbox/pages/settings_screen.dart';
import 'package:scheduler_chatbox/services/contact_list.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,

          title: Text("Spark"),
          actions: [
            IconButton(onPressed: (){},
                icon: Icon(Icons.search_outlined)),
            PopupMenuButton(itemBuilder: (context){
              return [
                PopupMenuItem(
                    child: Text("New Group"),
                value: "New Group",),
                PopupMenuItem(child: Text("Settings"),

                onTap: ()=>Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>  SettingsScreen())),
                value: "Settings",)
              ];
            }
            )
          ],
          bottom: TabBar(tabs: [
            Tab(text: "CHATS",),
            Tab(text: "STORY",),
            Tab(text: "CALL",)
          ]),
        ),
        body: TabBarView(
            children: [
              ChatScreenPgae(),
              Text("chats"),
              Text("chats"),


            ]),
        floatingActionButton: FloatingActionButton(onPressed: ()=> Navigator.push(context,
            MaterialPageRoute(builder: (context)=>ContactList()))
        ,child: Icon(Icons.message_sharp),),

      ),
    );
  }
}
