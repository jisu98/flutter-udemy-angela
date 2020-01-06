import 'package:eatday/question.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      home: Quizzler(),
    );
  }
}

class Quizzler extends StatefulWidget {
  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  int questionNumber = 0;
  int score = 0;
  List<Icon> scoreBoard = [];

  void submitAnswer(bool answer) {
    if (questionNumber == questions.length - 1) {
      finish();
      return;
    }

    setState(() {
      if (questions[questionNumber].questionAnswer == answer) {
        // 정답
        score += 1;
        scoreBoard.add(Icon(Icons.check, color: Colors.green));
      } else {
        // 오답
        scoreBoard.add(Icon(Icons.close, color: Colors.red));
      }

      if (questionNumber < questions.length - 1) {
        // 아직 풀 문제 남았음
        questionNumber += 1;
      } else {
        // 다 풀었음
        finish();
      }
    });
  }

  void finish() {
    Alert(
      context: context,
      title: 'Finished!',
      desc: 'You\'ve reached the end of the quiz.\n' +
          'Your score: ' +
          score.toString(),
      buttons: [
        DialogButton(
          child: Text(
            "RESTART",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              questionNumber = 0;
              score = 0;
              scoreBoard = [];
            });
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Center(
                child: Text(
                  questions[questionNumber].questionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                color: Colors.green,
                child: Center(
                  heightFactor: 4.5,
                  child: Text(
                    'True',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                onPressed: () => submitAnswer(true),
              ),
            ),
            SizedBox(height: 30.0),
            Expanded(
              child: FlatButton(
                color: Colors.red,
                child: Center(
                  heightFactor: 4.5,
                  child: Text(
                    'False',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                onPressed: () => submitAnswer(false),
              ),
            ),
            scoreBoard.isEmpty
                ? SizedBox(height: 20.0)
                : Container(
                    height: 20.0,
                    child: Row(
                      children: scoreBoard,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
