import 'package:flutter/material.dart';
import 'package:geeks_language_translator/language_translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Language Translator',
      debugShowCheckedModeBanner: false,
      home: LanguageTranslator(),
    );
  }
}
