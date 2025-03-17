import 'package:flutter/material.dart';

class DeckScreen extends StatefulWidget {
  final String deckTitle;
  final List<Map<String, String>> flashcards;

  DeckScreen({required this.deckTitle, required this.flashcards});

  @override
  _DeckScreenState createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> with SingleTickerProviderStateMixin {
  int _score = 0;
  int _currentIndex = 0;
  bool _isFront = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _flipCard() {
    setState(() {
      _isFront = !_isFront;
      if (_controller.isCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }

  void _updateScore(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        _score += 10;
      } else {
        _score -= 5;
      }
    });
  }

  void _nextCard() {
    setState(() {
      if (_currentIndex < widget.flashcards.length - 1) {
        _currentIndex++;
        _isFront = true;
      }
    });
  }

  void _previousCard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _isFront = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckTitle),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text('Score: $_score')),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _flipCard,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: _isFront
                    ? Flashcard(text: widget.flashcards[_currentIndex]['question']!)
                    : Flashcard(text: widget.flashcards[_currentIndex]['answer']!),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _previousCard,
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateScore(true);
                    _nextCard();
                  },
                  child: Text('Correct'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateScore(false);
                    _nextCard();
                  },
                  child: Text('Incorrect'),
                ),
                ElevatedButton(
                  onPressed: _nextCard,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Flashcard extends StatelessWidget {
  final String text;

  Flashcard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}