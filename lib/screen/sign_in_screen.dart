import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/screen/home_screen.dart';
import 'package:firebase_authentication/screen/signup_screen.dart';
import 'package:firebase_authentication/widgets/customs_button.dart';
import 'package:firebase_authentication/widgets/customs_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Log In",style: TextStyle(fontSize: 25,color: Colors.deepOrange),),
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
                    const TextSpan(text: "Don't have an Account",style: TextStyle(color: Colors.black)),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                          },
                          child: const Text("Sing Up",style: TextStyle(color: Colors.deepOrange)),
                        ))
                  ]
                )),
              ),
            ),
            CustomButton(
                title: "Sign In",
                onTap: () {
                  _auth.signInWithEmailAndPassword(
                      email: emailCon.text.toString(),
                      password: passwordCon.text.toString()).then((value){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("LogIn in Successful")));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                  }).onError((error, stackTrace){
                    debugPrint(error.toString());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                  });
                })
          ],
        ),
      ),
    );
  }
}
