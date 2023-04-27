import 'package:flutter/material.dart';
import 'package:medicine/home.dart';
import 'package:medicine/select.dart';
import 'package:medicine/pages/add_data1.dart';
import 'package:medicine/pages/add_data2.dart';
import 'package:medicine/pages/add_data3.dart';
import 'package:medicine/pages/add_data4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'Medicine Alert',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:{
        '/':(context)=>const HomePage(title:'Home'),
        '/select':(context)=>const SelectPage(title:'Enter Medicine Details'),
        '/addData/1':(context)=>const AddData1(title: 'Medicine 1'),
        '/addData/2':(context)=>const AddData2(title: 'Medicine 2'),
        '/addData/3':(context)=>const AddData3(title: 'Medicine 3'),
        '/addData/4':(context)=>const AddData4(title: 'Medicine 4')
      } 
    );
  }
}








