import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class TrueFalseGamePage extends StatefulWidget {
  const TrueFalseGamePage({super.key});

  @override
  State<TrueFalseGamePage> createState() => _TrueFalseGamePageState();
}

class _TrueFalseGamePageState extends State<TrueFalseGamePage> {
  int correct = 0;
  int wrong = 0;
  int totalTime = 10;
  Timer? timer;

  int a = 0;
  int b = 0;
  int displayedAnswer = 0;
  bool isAnswerCorrect = true;

  final Random random = Random();

  @override
  void initState() {
    super.initState();
    generateQuestion();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        totalTime--;
      });
      if (totalTime <= 0) {
        timer?.cancel();
        showResultDialog();
      }
    });
  }

  void generateQuestion() {
    a = random.nextInt(10) + 1;
    b = random.nextInt(10) + 1;
    int correctAns = a * b;

    // 50% chance to be incorrect
    bool showCorrect = random.nextBool();
    isAnswerCorrect = showCorrect;

    if (showCorrect) {
      displayedAnswer = correctAns;
    } else {
      int fake = correctAns + random.nextInt(10) - 5;
      displayedAnswer = (fake == correctAns || fake < 0) ? correctAns + 3 : fake;
    }

    setState(() {});
  }

  void handleAnswer(bool userSaysTrue) {
    if (userSaysTrue == isAnswerCorrect) {
      correct++;
    } else {
      wrong++;
    }
    generateQuestion();
  }

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Correct: $correct\nWrong: $wrong"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "$totalTime s",
              style: TextStyle(color: Colors.white60),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("✔️ $correct",
                    style: TextStyle(color: Colors.green, fontSize: 20)),
                Text("❌ $wrong",
                    style: TextStyle(color: Colors.red, fontSize: 20)),
              ],
            ),
            Spacer(),
            Text(
              "$a × $b = $displayedAnswer",
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.all(24),
                  ),
                  onPressed: () => handleAnswer(false),
                  child: Icon(Icons.close, color: Colors.white, size: 32),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(24),
                  ),
                  onPressed: () => handleAnswer(true),
                  child: Icon(Icons.check, color: Colors.white, size: 32),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
