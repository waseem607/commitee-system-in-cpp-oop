import 'package:flutter/material.dart';
import 'learn_table_screen.dart';
import 'training_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Multiplication Table")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            menuButton("Puzzles"),
            menuButton("Learn table", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const LearnTableScreen()));
            }),
            menuButton("Training", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TrainingScreen()));
            }),
            menuButton("Start test"),
            menuButton("More exercises"),
          ],
        ),
      ),
    );
  }

  Widget menuButton(String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18))),
      ),
    );
  }
}
