// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Greeting Phrases App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GreetingPhrasesScreen(),
    );
  }
}

class GreetingPhrase {
  final String english;
  final String telugu;
  final String transliteration;

  GreetingPhrase({
    required this.english,
    required this.telugu,
    required this.transliteration,
  });
}

final List<GreetingPhrase> greetingPhrases = [
  GreetingPhrase(
    english: "Good morning, Sir!",
    telugu: "నమస్కారం",
    transliteration: "Namaskāram!",
  ),
  GreetingPhrase(
    english: "Good morning Madam!",
    telugu: "నమస్కారం మేడం!",
    transliteration: "Namaskāram mēḍaṁ!",
  ),
  GreetingPhrase(
    english: "Good afternoon, my friend!",
    telugu: "నమస్తే సోదరుడా",
    transliteration: "Namastē sōdaruḍā!",
  ),
  GreetingPhrase(
    english: "Good afternoon, brother!",
    telugu: "నమస్తే సోదరా",
    transliteration: "Namastē sōdarā!",
  ),
  GreetingPhrase(
    english: "Good evening, boss!",
    telugu: "నమస్కారం బాస్",
    transliteration: "Namaskāram bās",
  ),
  GreetingPhrase(
    english: "Good evening, my comrade!",
    telugu: "నమస్కారం కామ్రేడ్",
    transliteration: "Namaskāram kāmrēḍ",
  ),
  GreetingPhrase(
    english: "Good night, sister!",
    telugu: "శుభరాత్రి సోదరి",
    transliteration: "Śubharātri sōdari",
  ),
  // Add other greeting phrases here
];

class GreetingPhrasesScreen extends StatefulWidget {
  const GreetingPhrasesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GreetingPhrasesScreenState createState() => _GreetingPhrasesScreenState();
}

class _GreetingPhrasesScreenState extends State<GreetingPhrasesScreen> {
  int _currentIndex = 0;
  final FlutterTts _flutterTts = FlutterTts();

  void _nextPhrase() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % greetingPhrases.length;
    });
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("te-IN"); // Telugu language code
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final currentPhrase = greetingPhrases[_currentIndex];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentPhrase.english,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  currentPhrase.telugu,
                  style: const TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  currentPhrase.transliteration,
                  style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _nextPhrase,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.deepPurple, backgroundColor: Colors.purple[100],
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Next Phrase'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _speak(currentPhrase.telugu),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Read Aloud'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
