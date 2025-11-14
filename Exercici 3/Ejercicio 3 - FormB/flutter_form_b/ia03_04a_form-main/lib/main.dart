import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'personal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M0489 - Apps - Form (B)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _navigateToPersonal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PersonalPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F3F),
      body: GestureDetector(
        onTap: _navigateToPersonal,
        child: FormBuilder(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('m08', style: TextStyle(fontSize: 32, color: Colors.white)),
                Text('B', style: TextStyle(fontSize: 80, color: Colors.white)),
                Text('Form', style: TextStyle(fontSize: 32, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}