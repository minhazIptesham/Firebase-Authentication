import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CustomButton({Key? key,required this.title,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black54,width: 2,)
          ),
          child: Center(child: Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
        ),
      ),
    );
  }
}
