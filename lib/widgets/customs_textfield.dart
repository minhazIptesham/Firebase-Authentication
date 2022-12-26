import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labeltext;
  final String hinttext;
  final controller;
  final icon;
  final keyboardType;
  final String valedmsg;
    const CustomTextField({Key? key,
     required this.labeltext,
     required this.hinttext,
     required this.icon,
      this.controller,
      this.keyboardType,
      required this.valedmsg,

   }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
          child: TextFormField(
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            decoration:  InputDecoration(
              labelText: widget.labeltext,
              labelStyle: const TextStyle(color: Colors.black,fontSize: 15),
              hintText: widget.hinttext,
              hintStyle: const TextStyle(color: Colors.black45),
              icon: widget.icon,
              iconColor: Colors.black,
            ),
            validator: (value) {
              if(value!.isEmpty){
                return widget.valedmsg;
              }
              return null;
            },
          ),
        );
  }
}
