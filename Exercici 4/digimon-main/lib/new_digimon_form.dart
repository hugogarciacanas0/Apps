import 'package:digimon/digimon_model.dart';
import 'package:flutter/material.dart';


class AddDigimonFormPage extends StatefulWidget {
  const AddDigimonFormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddDigimonFormPageState createState() => _AddDigimonFormPageState();
}

class _AddDigimonFormPageState extends State<AddDigimonFormPage> {
  TextEditingController nameController = TextEditingController();

  void submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the cocktail name'),
      ));
    } else {
      var newDigimon = Digimon(nameController.text);
      Navigator.of(context).pop(newDigimon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new cocktail', style: const TextStyle(color:Color.fromARGB(255, 16, 88, 55)), textAlign: TextAlign.center),
        backgroundColor: const Color(0xFFF8F8F8),
      ),
      body: Container(
        color: const Color.fromARGB(255, 161, 219, 193),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: nameController,
                style: const TextStyle(decoration: TextDecoration.none),
                onChanged: (v) => nameController.text = v,
                decoration: const InputDecoration(
                  labelText: 'Cocktail Name',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => submitPup(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 16, 88, 55),
                    ),
                    child: const Text('Submit Cocktail'),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
