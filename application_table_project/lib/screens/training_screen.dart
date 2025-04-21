import 'package:flutter/material.dart';
import 'true_false_game.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  int min = 5;
  int max = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select difficulty")),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text("Difficulty (Max number = 1000)", style: TextStyle(fontSize: 16)),
          Slider(
            value: max.toDouble(),
            min: 5,
            max: 100,
            divisions: 19,
            label: max.toString(),
            onChanged: (val) {
              setState(() => max = val.toInt());
            },
          ),
          const SizedBox(height: 20),
          const Text("Type of game"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Chip(label: Text("Test")),
              Chip(label: Text("True / False")),
              Chip(label: Text("Input")),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TrueFalseGamePage()));
            },
            child: const Text("START"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
