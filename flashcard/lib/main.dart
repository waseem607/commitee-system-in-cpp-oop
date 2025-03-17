import 'package:flutter/material.dart';
import 'deck_screen.dart';
import 'create_flashcard_screen.dart';

void main() {
  runApp(FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of decks, each containing its own flashcards
  List<Map<String, dynamic>> decks = [
    {
      "title": "Flutter",
      "cards": [
        {"question": "What is Flutter?", "answer": "A UI toolkit by Google."},
        {"question": "What is a widget?", "answer": "A building block of Flutter apps."},
      ],
    },
    {
      "title": "Dart",
      "cards": [
        {"question": "What is Dart?", "answer": "A programming language used by Flutter."},
        {"question": "Is Dart strongly typed?", "answer": "Yes, Dart is strongly typed."},
      ],
    },
  ];

  void _addFlashcard(Map<String, String> flashcard, int deckIndex) {
    setState(() {
      decks[deckIndex]['cards'].add(flashcard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Decks'),
      ),
      body: ListView.builder(
        itemCount: decks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(decks[index]['title']),
            subtitle: Text('${decks[index]['cards'].length} cards'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeckScreen(
                    deckTitle: decks[index]['title'],
                    flashcards: decks[index]['cards'],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to a screen for creating new flashcards
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateFlashcardScreen(
                decks: decks,
                addFlashcard: _addFlashcard,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}