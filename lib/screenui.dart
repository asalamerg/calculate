

import 'package:flutter/material.dart';


class Ui extends StatelessWidget{
  String text;
  void Function(String) on;
  Ui({super.key, required this.text,required this.on});
  @override
  Widget build(BuildContext context) {
    return Expanded(child:
      Container(
        height: double.infinity,
      width: double.infinity,
      margin: const EdgeInsets.all(3),
      decoration: const BoxDecoration(

        color: Colors.green,
      ),
      child: ElevatedButton(onPressed:(){
        on(text);
      } ,style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(),backgroundColor: Colors.green),
        child: Text(text,style: const TextStyle(fontSize: 25,color: Colors.white), ),)
    )
    );
  }
}

