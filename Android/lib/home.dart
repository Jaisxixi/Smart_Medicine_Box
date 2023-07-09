import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import './widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
       body: Column(
        children: [
          Text('A Smart Medicine Box which reminds you when to take which medicine precisely everyday',
            style: TextStyle(fontSize: 20.0,
                             fontWeight: FontWeight.bold,
                             letterSpacing: 2.0,
                             color: Colors.grey[600],
            ),
             
          ),
          
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context,'/select');
            },
            child: Text('Next'),
          ),

        ],
      ),
    
      ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}