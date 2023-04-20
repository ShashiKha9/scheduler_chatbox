
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scheduler_chatbox/homescreen_page.dart';
import 'package:scheduler_chatbox/pages/chatscreen_page.dart';
import 'package:scheduler_chatbox/services/database_service.dart';
enum MobileVerificationState{
  Show_Mobile_Form_State,
  Show_Otp_Form_State,
  Show_Profile_Form_State
}
class AuthScreenPage extends StatefulWidget {


  const AuthScreenPage({Key? key, }) : super(key: key);


  @override
  State<AuthScreenPage> createState() => _AuthScreenPageState();
}

class _AuthScreenPageState extends State<AuthScreenPage> {

  int ?_forceResendingToken;
  MobileVerificationState currentState = MobileVerificationState.Show_Mobile_Form_State;
  late String _verificationId;
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  final _nameController = TextEditingController();
  bool isLoading = false;


  final FirebaseAuth auth = FirebaseAuth.instance;

 Future<void> verify() async {
   await auth.verifyPhoneNumber(
     phoneNumber: "+91${_phoneNumberController.text}",
       forceResendingToken: _forceResendingToken,
       verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
       },
       verificationFailed: (FirebaseAuthException e){
         if (e.code == 'invalid-phone-number') {
           print('The provided phone number is not valid.');
         }
       },
       codeSent: (verificationId,forceresendingToken)async{
       setState((){
         currentState=MobileVerificationState.Show_Otp_Form_State;
         this._verificationId = verificationId;
         this._forceResendingToken=forceresendingToken;
       });

       },
       codeAutoRetrievalTimeout: (String verificationId){
         this._verificationId = verificationId;

       },
     timeout: Duration(milliseconds: 1000),

   );

 }
 //

 Future SignInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    try{
      final authCredential = await auth.signInWithCredential(phoneAuthCredential);
      if(authCredential != null){
        // setState((){
        //   currentState= MobileVerificationState.Show_Profile_Form_State;
        // });
         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreenPage()));
        DatabaseService(uid: authCredential.user?.uid).updateUserData(_phoneNumberController.text,_nameController.text);
        return true;
      }
    } on FirebaseAuthException catch(e){
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!),
        backgroundColor: Colors.lightBlueAccent,));
    }
 }

  File? image;

  void _onImageButtonPressed(ImageSource src) async {
    switch (src) {
      case ImageSource.camera:
        final image = await ImagePicker().pickImage(source: ImageSource.camera);

        if (image == null) return;

        File imageTemp = File(image.path);
        setState(() {
          this.image = imageTemp;
        });
        break;
      case ImageSource.gallery:
        final image = await ImagePicker().pickImage(
            source: ImageSource.gallery);

        if (image == null) return;

        File imageTemp = File(image.path);
        setState(() {
          this.image = imageTemp;
        });
    }
  }
  //
String? imageUrl;
  Future uploadImage() async {
    final  user = auth.currentUser;
    Reference ref = FirebaseStorage.instance.ref().child(user!.uid).child("imageUrl");
   await  ref.putFile(image!);
   imageUrl=await ref.getDownloadURL();
   print(imageUrl);

   await DatabaseService().userCollection.doc(user.uid).update({"imageUrl": imageUrl});

  }
  //

 getMobileFormWidget(context){
  return  Column(
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       Text("Enter your phone number",style: TextStyle(fontSize: 18,
           fontWeight: FontWeight.bold,
           color: Colors.white),),
       SizedBox(
         height: 30,),
       Text("Spark will send an SMS message to verify \n                 your phone number.",style: TextStyle(fontSize: 14,
           fontWeight: FontWeight.w400,
           color: Colors.grey[400]),
       ),
       SizedBox(
         height: 12,
       ),
       Row(
         children: [
           CountryListPick(
             theme: CountryTheme(
               isShowFlag: true,
               isShowTitle: false,
             ),
             initialSelection: "+91",
             onChanged: (dialCode){
               print(dialCode?.dialCode);
             },
           ),
           Expanded(
             child: TextField(
               controller: _phoneNumberController,
               style: TextStyle(color: Colors.white),
               keyboardType: TextInputType.number,
               decoration: InputDecoration(
                   hintText: "Phone no",
                   hintStyle: TextStyle(color: Colors.grey),
                   enabledBorder: UnderlineInputBorder(
                       borderSide: BorderSide(color: Colors.lightBlueAccent,
                       )
                   )
               ),


             ),
           )
         ],
       ),
       SizedBox(
         height: 50,
       ),
       isLoading? CircularProgressIndicator():
       ElevatedButton(
           style: ElevatedButton.styleFrom(
               primary: Colors.lightBlueAccent
           ),
           onPressed: (){
             verify();
             print(_phoneNumberController.text);
             // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreenPage()));
           },
           child: Text("Send Otp",))

     ],
   );

 }
 getOtpFormWidget(context){
   return Column(
     children: [
       Text("Verify +91${_phoneNumberController.text}",style: TextStyle(fontSize: 18,
           fontWeight: FontWeight.bold,
           color: Colors.white),),
       SizedBox(
         height: 30,),
       Padding(
         padding: EdgeInsets.all(20),
         child: TextField(
           controller: _otpController,
           keyboardType: TextInputType.number,
           style: TextStyle(color: Colors.white),
           decoration: InputDecoration(
             hintText: "Enter the OTP",
             hintStyle: TextStyle(color: Colors.white),
             border: OutlineInputBorder(
               borderSide: BorderSide(width: 5,color: Colors.lightBlueAccent)
             )
           ),

         ),
         
       ),
       Wrap(
         children: [
           Text("Send OTP again in ",style: TextStyle(
               color: Colors.white54,
               fontSize: 14),),
           Text("0.0 ",style: TextStyle(
               color: Colors.red,
               fontSize: 14),),
           Text("sec ",style: TextStyle(
               color: Colors.white54,
               fontSize: 14),)
         ],
       ),
       SizedBox(
         height: 5,
       ),
       RichText(text: TextSpan(
         children: [
           TextSpan(
             text: "Did not get OTP,",
             style: TextStyle(color: Colors.white54,fontSize: 14)
           ),
           TextSpan(
               text: " resend?",
               style: TextStyle(color: Colors.red,fontSize: 14)
           )
         ]
       )),
       SizedBox(
         height: 20,
       ),
       ElevatedButton(
         style: ElevatedButton.styleFrom(
           primary: Colors.lightBlueAccent,
         ),
           onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=> getProfileFormWidget()));

           },
           child: Text("Submit"))
     ],
   );
 }

  getProfileFormWidget(){
  return Scaffold(
     backgroundColor: Theme.of(context).primaryColor,
     appBar: AppBar(
       title: Text("Profile"),
     ),
     body: Column(
       children: [
         SizedBox(
           height: 50,
         ),
         Stack(

           children: [
             GestureDetector(
               onTap: (){
                 _onImageButtonPressed(ImageSource.gallery);
               },
               child: Center(
                 child: ClipOval(
                     child:Container(
                       height: 150,
                       width: 150,
                       color: Colors.blue,
                       child:  image != null ? Image.file(image!):const Center(child: Text("No image"),),
                     )
                 ),
               ),
             ),
             Positioned(
               top: 120,
               right: 100,
               child: ClipOval(
                   child:Container(
                     height: 45,
                     width: 45,
                     color: Colors.grey,
                     child: Icon(Icons.camera_alt_rounded),
                   )),
             ),
           ],
         ),
         Padding(
           padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
           child: TextField(
             controller: _nameController,
             decoration: InputDecoration(
               hoverColor: Colors.white,
                 hintText: "Name",
                 hintStyle: TextStyle(color: Colors.white54)
             ),
           ),
         ),
         ElevatedButton(onPressed: (){
           PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
               verificationId: _verificationId, smsCode: _otpController.text);
           SignInWithPhoneAuthCredential(phoneAuthCredential);
           uploadImage();
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreenPage()));
         },
             child: Text("Next")),





       ],
     ),

   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child:
            currentState== MobileVerificationState.Show_Mobile_Form_State
                ? getMobileFormWidget(context)
                : currentState== MobileVerificationState.Show_Otp_Form_State
                ? getOtpFormWidget(context)
                :getProfileFormWidget()
          )),
    );
  }
}
