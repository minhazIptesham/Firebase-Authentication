import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/screen/home_screen.dart';
import 'package:firebase_authentication/widgets/customs_button.dart';
import 'package:firebase_authentication/widgets/customs_textfield.dart';
import 'package:flutter/material.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  TextEditingController codeCon = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          CustomTextField(
            controller: codeCon,
            valedmsg: "Enter code number",
            labeltext: "Phone",
            hinttext: "12345",
            icon: const Icon(Icons.numbers),
            keyboardType: TextInputType.phone,
          ),
          CustomButton(
              title: "Verify Number",
              onTap: ()async{
                final credential = PhoneAuthProvider.credential(
                    smsCode: codeCon.text.toString(),
                    verificationId: widget.verificationId);
                try{
                  await auth.signInWithCredential(credential);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                }catch(error){
                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(error.toString())));
                }
              }
          ),
        ],
      ),
    );
  }
}
