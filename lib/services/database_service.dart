
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService{
  final String? uid;
  final String? name;
  final String? imageUrl;
  DatabaseService({ this.uid, this.name,this.imageUrl});

  static DatabaseService fromJson(Map<String,dynamic> json)=>DatabaseService(
      uid: json['uid'],
      name: json['name']

  );

  final CollectionReference userCollection=
  FirebaseFirestore.instance.collection("users");
  Future updateUserData(String phoneNo,String name) async {
    // Reference ref = FirebaseStorage.instance.ref().child("imageUrl");
    return  await userCollection.doc(uid).set({
      "phoneNo":phoneNo,
      "name":name,
      "uid":uid,
      // "imageUrl":imageUrl

    });


  }




  // Future<List<DatabaseService>> fetchUserData() async{

    // QuerySnapshot snap=await  userCollection.get();
    // final allData=snap.docs.map((doc) => doc.data()).toList();
    // print(allData);
    // final snapshot =await userCollection.snapshots()
    // snapshots().map((snapshot) => snapshot.docs.map((doc) => DatabaseService.fromJson(doc.get(field))));
    // final userData= snapshot.docs.map((e)=> e.data()).toList();
    // return userData;

  // }



}
