import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler_chatbox/services/database_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final  user = auth.currentUser;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Hero(tag: "profile",
                child:  StreamBuilder<QuerySnapshot>(
                stream: DatabaseService().userCollection.doc(user!.uid).collection("images").snapshots(),
                    builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.active){
                      QuerySnapshot querySnapshot = snapshot.data!;
                      List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                          querySnapshot.docs;
                      return
                        ListView.builder(
                          itemCount: listQueryDocumentSnapshot.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                            itemBuilder: (context,index){
                          QueryDocumentSnapshot document = listQueryDocumentSnapshot[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 150,
                              child: Image.network(document["imageUrl"],fit: BoxFit.cover,),
                            ),
                              title: Text(document["name"],style: TextStyle(color: Colors.white70),),
                          );

                        });

                    }
                    return CircularProgressIndicator();
                    })
            ),
            ListTile(
                leading: Padding(padding: EdgeInsets.only(left: 12),
                    child: Icon(Icons.language_outlined,color:Theme.of(context).highlightColor,)),
                title: Text("App Language",style: Theme.of(context).textTheme.bodyMedium,)),
            ListTile(
              leading: Padding(padding: EdgeInsets.only(left: 12),
              child: Icon(Icons.help_outline_outlined,color:Theme.of(context).highlightColor,)),
              title: Text("Help",style: Theme.of(context).textTheme.bodyMedium,)),

            ListTile(
                leading: Padding(padding: EdgeInsets.only(left: 12),
                    child: Icon(Icons.info_outline_rounded,color:Theme.of(context).highlightColor,)),
                title: Text("About",style: Theme.of(context).textTheme.bodyMedium,)),


            ListTile(
                leading: Padding(padding: EdgeInsets.only(left: 12),
                    child: Icon(Icons.logout_outlined,color:Theme.of(context).highlightColor,)),
                title: Text("Logout",style: Theme.of(context).textTheme.bodyMedium,)),
          ],
        ),


    );

  }
}
