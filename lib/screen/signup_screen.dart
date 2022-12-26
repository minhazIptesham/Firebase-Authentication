import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/screen/sign_in_screen.dart';
import 'package:firebase_authentication/widgets/customs_button.dart';
import 'package:firebase_authentication/widgets/customs_textfield.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _fromkey = GlobalKey<FormState>();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailCon.dispose();
    passwordCon.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Sign Up",style: TextStyle(fontSize: 25,color: Colors.deepOrange),),
          const SizedBox(height: 20,),
          Form(
              key: _fromkey,
              child: Column(
                children: [
                  CustomTextField(
                    labeltext: "Email",
                    controller: emailCon,
                    hinttext: "example@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                    icon: const Icon(Icons.alternate_email),
                    valedmsg: 'Enter your email',
                  ),
                  CustomTextField(
                    controller: passwordCon,
                    labeltext: "Password",
                    hinttext: "must be 6-character",
                    keyboardType: TextInputType.phone,
                    icon: const Icon(Icons.lock_outline),
                    valedmsg: 'Enter your password',
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(right: 22),
            child: Align(
              alignment: Alignment.centerRight,
              child: RichText(text:  TextSpan(
                  children: [
                    const TextSpan(text: "Already have an Account",style: TextStyle(color: Colors.black)),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
                          },
                          child: const Text("Sing In",style: TextStyle(color: Colors.deepOrange)),
                        )),
                  ]
              )),
            ),
          ),
          CustomButton(
              title: "Sign Up",
              onTap: () {
                if(_fromkey.currentState!.validate()){
                   _auth.createUserWithEmailAndPassword(
                       email: emailCon.text.toString(),
                       password: passwordCon.text.toString()).then((value){
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account create successful")));
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
                   }).onError((error, stackTrace){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString()))
                     );
                   });
                }
              })
        ],
      ),
    );
  }
}
