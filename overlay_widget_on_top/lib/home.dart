import 'package:flutter/material.dart';
import 'package:overlay_widget_on_top/text_field_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Container(
            height: 120,
            color: Colors.blue,
          ),
          Container(
            height: 120,
            color: Colors.orange,
          ),
          Container(
            height: 120,
            color: Colors.red,
          ),
          Container(
            height: 120,
            color: Colors.green,
          ),
          Container(
            height: 120,
            color: Colors.pink,
          ),
          const SizedBox(
            height: 20,
          ),
          const TextFieldWidget(),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 120,
            color: Colors.indigo,
          ),
          Container(
            height: 120,
            color: Colors.teal,
          ),
          Container(
            height: 120,
            color: Colors.purple,
          ),
          Container(
            height: 120,
            color: Colors.cyan,
          ),
          Container(
            height: 120,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
