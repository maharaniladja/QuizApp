import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quizapp/quiz_controller.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  QuizController quizController = QuizController();
  int correctScore = 0;

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizController.getCorrectAnswer();

    setState(() {
      if (quizController.isFinished()) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'Anda menjawab $correctScore pertanyaan dengan benar',
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "OK",
              ),
            )
          ],
        ).show();

        quizController.reset();
        scoreKeeper = [];
        correctScore = 0;
      } else {
        if (userAnswer == correctAnswer) {
          correctScore++;
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizController.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizController.getQuestionText(),
                style: TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
              child: const Text('True'),
              onPressed: () => checkAnswer(true),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                // fixedSize: Size.fromHeight(60),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
              child: const Text('False'),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }/
}
