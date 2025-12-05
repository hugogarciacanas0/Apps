import 'package:digimon/digimon_card.dart';
import 'package:flutter/material.dart';
import 'digimon_model.dart';

class DigimonList extends StatelessWidget {
  final List<Digimon> digimons;
  final VoidCallback? onDigimonUpdated;
  const DigimonList(this.digimons, {super.key, this.onDigimonUpdated});

  @override
  Widget build(BuildContext context) {
    return _buildList(context); // Construeix la llista
  }

  // Mètode privat per construir la ListView
  ListView _buildList(context) {
    return ListView.builder(
      itemCount: digimons.length, // Nombre d'elements
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        return DigimonCard(digimons[int],
            onDigimonUpdated: onDigimonUpdated); // Crea cada targeta
      },
    );
  }
}
