// Importa widgets de Material Design
import 'package:flutter/material.dart';

// Punt d'entrada de l'aplicació
void main() => runApp(const MyApp());

// Widget principal de l'app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp amb títol i pantalla inicial
    return const MaterialApp(
      title: "Recuperar el valor d'un camp de text",
      home: MyCustomForm(),
    );
  }
}

// Widget amb estat per al formulari
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Estat del formulari
class _MyCustomFormState extends State<MyCustomForm> {
  // Controlador del TextField
  final myController = TextEditingController();

  @override
  void dispose() {
    // Allibera recursos del controlador
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Pantalla principal amb AppBar i contingut
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar el valor d\'un camp de text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Camp de text per introduir text
            TextField(
              controller: myController,
            ),
            const SizedBox(height: 50),

            // Fila amb quatre botons icònics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Primer botó: mostra un BottomSheet
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Mostra un modal a la part inferior
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      // Mostra el text actual
                                      Text(myController.text),
                                      ElevatedButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: const Text('Tancar BottomSheet'),
                                      )
                                    ],
                                  ),
                                ));
                          });
                    },
                    icon: const Icon(Icons.looks_one, color: Colors.white),
                  ),
                ),

                // Segon botó: mostra un SimpleDialog
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: const Text('Valor del camp de text'),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(myController.text),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Tancar'),
                                ),
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.looks_two, color: Colors.white),
                  ),
                ),

                // Tercer botó: mostra un AlertDialog
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Valor del camp de text'),
                              content: Text(myController.text),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Tancar'),
                                ),
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.looks_3, color: Colors.white),
                  ),
                ),

                // Quart botó: mostra un SnackBar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(myController.text),
                          action: SnackBarAction(
                            label: 'Tancar',
                            onPressed: () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.looks_4, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
