import 'package:flutter/material.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  // int _counter = 0;

  // void _incrementCounter() {
    // setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
    // });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the SelectPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text('4 slots'),
          // Text(appState.current.asLowerCase),

          // ↓ Add this.
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addData/1');
                },
                child: Text('1st'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addData/2');
                },
                child: Text('2nd'),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addData/3');
                },
                child: Text('3rd'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addData/4');
                },
                child: Text('4th'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
