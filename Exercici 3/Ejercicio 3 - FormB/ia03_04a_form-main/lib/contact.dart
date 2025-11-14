import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'upload.dart';
import 'personal.dart';

// Pàgina de Contact
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna la pàgina sense MaterialApp anidada
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Clau del formulari
  final _formKey = GlobalKey<FormBuilderState>();

  // Anar a Upload
  void _onContinue() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UploadPage()),
    );
  }

  // Anar enrere a Personal
  void _onCancel() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PersonalPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[200],
        title: const Text(
          'Salesians Sarrià 25/26',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Column(
        children: [
          // Menú de pasos amb sombra
          Container(
            // Decoració amb sombra
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue[700],
                            child: const Icon(Icons.info, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          const Text('Pers.'),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue[700],
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          const Text('Contact'),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[400],
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('Upload'),
                        ],
                      ),
                    ),
              ],
            ),
          ),
          // Contingut principal
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(40),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    // Títol
                    const Text('Contact', style: TextStyle(fontSize: 48)),
                    const SizedBox(height: 10),
                    // Descripció
                    const Text(
                      'Pulsa "Upload" o pulsa el botón de "Continue".',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 40),
                    // Botons Continue i Cancel
                    Row(
                      children: [
                        // Botó Continue
                        ElevatedButton(
                          onPressed: _onContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text('CONTINUE'),
                        ),
                        const SizedBox(width: 20),
                        // Botó Cancel
                        TextButton(
                          onPressed: _onCancel,
                          child: const Text('CANCEL'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}