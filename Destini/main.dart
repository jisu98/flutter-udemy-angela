import 'package:flutter/material.dart';
import 'package:eatday/story_brain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Destini',
      theme: ThemeData.dark(),
      home: Destini(),
    );
  }
}

StoryBrain storyBrain = StoryBrain();

class Destini extends StatefulWidget {
  @override
  _DestiniState createState() => _DestiniState();
}

class _DestiniState extends State<Destini> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: Center(
                    child: Text(
                      storyBrain.getStory(),
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        storyBrain.nextStory(1);
                      });
                    },
                    child: Text(
                      storyBrain.getChoice1(),
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                storyBrain.isEnding()
                    ? SizedBox.shrink()
                    : Expanded(
                        child: FlatButton(
                          color: Colors.blue,
                          onPressed: () {
                            setState(() {
                              storyBrain.nextStory(2);
                            });
                          },
                          child: Text(
                            storyBrain.getChoice2(),
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
