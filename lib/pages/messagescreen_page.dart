import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageScreenPage extends StatefulWidget {
  const MessageScreenPage({Key? key}) : super(key: key);

  @override
  State<MessageScreenPage> createState() => _MessageScreenPageState();
}

class _MessageScreenPageState extends State<MessageScreenPage> {
  final _messageController = TextEditingController();
  @override
  void initState(){
    super.initState();
    _messageController.addListener(() {
      setState((){
      });

    });
  }
  @override
  void dispose(){
    _messageController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
                itemBuilder: (context,index){
                return Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      decoration: BoxDecoration(color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text("Hey Shashi"),
                    )

                  ],
                );


                }),
          ),
          chatInput()
        ],
      ),
    );
  }

  Container chatInput() {
    return Container(
          decoration: BoxDecoration(

          ),
          child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                       height: 50,
                       decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Row(
                        children: [
                          Icon(Icons.sentiment_satisfied_alt_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: "Message",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 20
                                )
                              ),
                            ),
                          ),
                          Icon(Icons.attach_file_outlined),
                          Icon(Icons.camera_alt)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  _messageController.text.isNotEmpty ?
                  CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.send,color: Colors.lightBlueAccent,),
                  ):
                  CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.mic,color: Colors.lightBlueAccent,),
                  ),

                ],
              )),
        );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.lightBlueAccent,
      title: Row(
        children: [
          Icon(Icons.arrow_back_outlined),
          CircleAvatar(
            backgroundColor: Colors.blue,
          ),
          SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Shashi Kha",style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.w500,fontSize: 16),),
            Text("Active 3m ago",style: TextStyle(color: Colors.white,
                fontSize: 12),)
          ],
        )
        ],
      ),
    );
  }
}
