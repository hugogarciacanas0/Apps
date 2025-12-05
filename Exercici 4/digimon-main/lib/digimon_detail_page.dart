import 'package:flutter/material.dart';
import 'digimon_model.dart';
import 'dart:async';


class DigimonDetailPage extends StatefulWidget {
  final Digimon digimon;
  const DigimonDetailPage(this.digimon, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DigimonDetailPageState createState() => _DigimonDetailPageState();
}

class _DigimonDetailPageState extends State<DigimonDetailPage> {
  final double digimonAvarterSize = 150.0;
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.digimon.rating.toDouble();
  }

  // Widget per la secció de puntuació
  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: const Color(0xFF0B479E),
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating; // Actualitza el valor
                    });
                  },
                ),
              ),
              Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_sliderValue.toInt()}', // Mostra el valor
                    style: const TextStyle(color: Colors.black, fontSize: 25.0),
                  )),
            ],
          ),
        ),
        submitRatingButton, // Botó per enviar
      ],
    );
  }

  // Mètode per actualitzar la puntuació
  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog(); // Mostra diàleg d'error si és baixa
    } else {
      setState(() {
        widget.digimon.rating = _sliderValue.toInt(); // Actualitza la puntuació
      });
      Navigator.of(context).pop(); // Torna a la pàgina anterior
    }
  }

  // Diàleg d'error per puntuacions baixes
  Future<void> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error!'),
            content: const Text("Come on! They're good!"), // Missatge d'error
            actions: <Widget>[
              TextButton(
                child: const Text('Try Again'),
                onPressed: () => Navigator.of(context).pop(), // Tanca el diàleg
              )
            ],
          );
        });
  }

  // Widget per el botó d'enviar puntuació
  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(), // Crida a actualitzar
      child: const Text('Submit'),
    );
  }

  // Widget per la imatge del Digimon
  Widget get digimonImage {
    return Hero(
      tag: widget.digimon,
      child: Container(
        height: digimonAvarterSize,
        width: digimonAvarterSize,
        constraints: const BoxConstraints(),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(offset: Offset(1.0, 2.0), blurRadius: 2.0, spreadRadius: -1.0, color: Color(0x33000000)),
              BoxShadow(offset: Offset(2.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0, color: Color(0x24000000)),
              BoxShadow(offset: Offset(3.0, 1.0), blurRadius: 4.0, spreadRadius: 2.0, color: Color(0x1f000000))
            ],
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(widget.digimon.imageUrl ?? ""))), // Imatge de xarxa
      ),
    );
  }

  // Widget per mostrar la puntuació actual
  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.star,
          size: 40.0,
          color: Colors.black,
        ),
        Text('${widget.digimon.rating}/10', style: const TextStyle(color: Colors.black, fontSize: 30.0)) // Mostra la puntuació
      ],
    );
  }

  // Widget per el perfil del Digimon
  Widget get digimonProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 161, 219, 193), // Color de fons
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          digimonImage, // Imatge del Digimon
          Text(widget.digimon.name, style: const TextStyle(color: Colors.black, fontSize: 32.0)), // Nom
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: rating, // Puntuació
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Construeix la interfície de la pàgina de detalls
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
        title: Text(widget.digimon.name , style: const TextStyle(color:Color.fromARGB(255, 16, 88, 55)), textAlign: TextAlign.center),
      ),
      backgroundColor:  const Color.fromARGB(255, 161, 219, 193),
      body: ListView(
        children: <Widget>[digimonProfile, addYourRating], // Mostra perfil i puntuació
      ),

    );
  }
}
