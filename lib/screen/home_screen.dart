import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/screen/sign_in_screen.dart';
import 'package:firebase_authentication/screen/verify_code.dart';
import 'package:firebase_authentication/widgets/customs_button.dart';
import 'package:firebase_authentication/widgets/customs_textfield.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController phoneCon = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                auth.signOut().then((value){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
                }).onError((error, stackTrace){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                });
              },
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black87,width: 2),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Log Out"),
                    Icon(Icons.login_outlined),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
            controller: phoneCon,
            valedmsg: "Enter phone number",
            labeltext: "Phone",
            hinttext: "+880123456789",
            icon: const Icon(Icons.phone),
            keyboardType: TextInputType.phone,
          ),
          CustomButton(
              title: "Send Code",
              onTap: (){
                auth.verifyPhoneNumber(
                  phoneNumber: phoneCon.text.toString(),
                    verificationCompleted: (_){},
                    verificationFailed: (error) {
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:Text(error.toString())));
                    },
                    codeSent: (String verificationId,int? token){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyCode(verificationId: verificationId,)));
                    },
                    codeAutoRetrievalTimeout: (verificationId) {
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(verificationId.toString())));
                    },);
              }
          ),
        ],
      ),
    );
  }
}
