import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicee',
      home: DicePage(),
    );
  }
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  void changeDiceFace() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        elevation: 0.0, // remove drop shadow
        title: Text(
          'Dicee',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              child: Image(
                width: 150.0,
                height: 150.0,
                image: AssetImage('assets/images/dice$leftDiceNumber.png'),
              ),
              onTap: () => changeDiceFace(),
            ),
            GestureDetector(
              child: Image(
                width: 150.0,
                height: 150.0,
                image: AssetImage('assets/images/dice$rightDiceNumber.png'),
              ),
              onTap: () => changeDiceFace(),
            ),
          ],
        ),
      ),
    );
  }
}
