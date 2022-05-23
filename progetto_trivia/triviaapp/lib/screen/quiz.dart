import 'package:flutter/material.dart';
import 'package:triviaapp/models/domande.dart';
import 'package:triviaapp/models/questions.dart';
import 'package:triviaapp/models/question_model.dart';
import 'package:triviaapp/screen/point.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = new QuizBrain();
  List<Widget> scoreKeeper = [];
  int correctScore = 0;
  int totalQuestions = 0;

  late Domande domande;
  late Future f;
  @override
  void initState() {
    setState(() {
      take_question();
    });
    super.initState();
  }

  void take_question() async {
    f = question();
    Domande d = await f;
    setState(() {
      domande = d;
    });
  }

  void check(String risposta) async {
    if (domande.results![totalQuestions].correctAnswer == risposta) {
      if (totalQuestions < 10) {
        correctScore++;
      }
    }
    totalQuestions++;
    if (totalQuestions == 10) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PointScreen(point_user: correctScore)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        title: Text('quiz'),
      ),
      backgroundColor: Colors.white,
      body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: FutureBuilder(
                future: f,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Text(
                "${domande.results![totalQuestions].question}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0, decoration: TextDecoration.none
                ),
              );
                  }else{
                    return CircularProgressIndicator();
                  }

                }
                
                ) 
              
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(0),
                ),
              ),
              child: Container(
                height: double.infinity,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'True',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  check('True');
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(0),
                ),
              ),
              child: Container(
                height: double.infinity,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  setState(() {
                    check('False');
                  });
                });
              },
            ),
          ),
        ),
        Row(children: scoreKeeper)
      ],
    ),
      )
    );
  }
}
