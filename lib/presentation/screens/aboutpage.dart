


import 'dart:io';

import 'package:bloc_student_manager/database/hive.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AboutPage extends StatelessWidget {
  final box = Hive.box<StudentDetail>('studentDetails');
  
    final int index;
   AboutPage({ Key? key,required this.index }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var student_list= Hive.box<StudentDetail>('studentDetails').values.toList();

     
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Center(
            child: Neumorphic(
  style: NeumorphicStyle(
    shape: NeumorphicShape.concave,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)), 
    depth: 8,
    lightSource: LightSource.topLeft,
    color: Colors.grey
  ),
  child: SizedBox(height: 400,width: 250,child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    
       CircleAvatar(backgroundColor: Colors.black,radius: 90, backgroundImage: FileImage(File(student_list[index].imagePath),),),

      Text(student_list[index].name,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
      Text(student_list[index].age.toString(),style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
      Text(student_list[index].place,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
      Text(student_list[index].domain,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

      
     
      
         // Text(student_list[index].age),
      // Text(stu),
      



    

    ],
  ),)
),
          )
        ],
      )),
    );
    
  }
}