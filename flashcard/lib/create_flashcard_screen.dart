import 'package:flutter/material.dart';

class CreateFlashcardScreen extends StatefulWidget {
  final List<Map<String, dynamic>> decks;
  final Function(Map<String, String>, int) addFlashcard;

  CreateFlashcardScreen({required this.decks, required this.addFlashcard});

  @override
  _CreateFlashcardScreenState createState() => _CreateFlashcardScreenState();
}

class _CreateFlashcardScreenState extends State<CreateFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  String _question = '';
  String _answer = '';
  int _selectedDeckIndex = 0;

  void _submitFlashcard() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.addFlashcard({"question": _question, "answer": _answer}, _selectedDeckIndex);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Flashcard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                value: _selectedDeckIndex,
                items: widget.decks.map((deck) {
                  return DropdownMenuItem<int>(
                    value: widget.decks.indexOf(deck),
                    child: Text(deck['title']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDeckIndex = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Select Deck'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Question'),
                validator: (value) => value!.isEmpty ? 'Enter a question' : null,
                onSaved: (value) => _question = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Answer'),
                validator: (value) => value!.isEmpty ? 'Enter an answer' : null,
                onSaved: (value) => _answer = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitFlashcard,
                child: Text('Save Flashcard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}