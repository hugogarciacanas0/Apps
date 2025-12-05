// Importacions necessàries per l'aplicació Flutter
import 'package:flutter/material.dart';
import 'dart:async';
import 'digimon_model.dart';
import 'digimon_list.dart';
import 'new_digimon_form.dart';

// Funció principal que inicia l'aplicació
void main() => runApp(const MyApp());

// Classe principal de l'aplicació, sense estat
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Construeix l'aplicació amb tema fosc i pàgina d'inici
    return MaterialApp(
      title: 'My fav Cocktails',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(
        title: 'My fav Cocktails',
      ),
    );
  }
}

// Classe de la pàgina d'inici, amb estat
class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Digimon> initialDigimons = [Digimon('Daiquiri'), Digimon('Margarita'), Digimon('Whiskey Sour'), Digimon('Long Island Tea')];

  Future _showNewDigimonForm() async {
    Digimon newDigimon = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddDigimonFormPage();
    }));
    //print(newDigimon);
    initialDigimons.add(newDigimon);
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Construeix la interfície de la pàgina
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color:Color.fromARGB(255, 16, 88, 55))),
        centerTitle: true,
        backgroundColor: const Color(0xFFF8F8F8),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showNewDigimonForm,
          ),
        ],
      ),
      body: Container(
          color: const Color.fromARGB(255, 16, 88, 55),
          child: Center(
            child: DigimonList(initialDigimons, onDigimonUpdated: () => setState(() {})),
          )),
    );
  }
}
