import 'package:digimon/digimon_model.dart';
import 'digimon_detail_page.dart';
import 'package:flutter/material.dart';

class DigimonCard extends StatefulWidget {
  final Digimon digimon; // L'objecte Digimon que es mostrarà
  final VoidCallback? onDigimonUpdated; 

  const DigimonCard(this.digimon, {super.key, this.onDigimonUpdated});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _DigimonCardState createState() => _DigimonCardState(digimon, onDigimonUpdated);
}

class _DigimonCardState extends State<DigimonCard> {
  Digimon digimon; // Referència al Digimon actual
  String? renderUrl; // URL de la imatge del Digimon (pot ser null)
  final VoidCallback? onDigimonUpdated; // Callback per notificar actualitzacions

  _DigimonCardState(this.digimon, this.onDigimonUpdated);

  @override
  void initState() {
    super.initState();
    renderDigimonPic(); // Carrega la imatge del Digimon quan s'inicialitza el widget
  }

  // Widget que retorna la imatge del Digimon amb animació
  Widget get digimonImage {
    // Hero widget per a animacions de transició entre pantalles
    var digimonAvatar = Hero(
      tag: digimon, // Tag únic per identificar el Hero en les transicions
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration:
            BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10) ,image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(renderUrl ?? ''))),
      ),
    );

    // Placeholder que es mostra mentre es carrega la imatge
    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.black54, Colors.black, Color.fromARGB(255, 84, 110, 122)])),
      alignment: Alignment.center,
      child: const Text(
        'Cocktail',
        textAlign: TextAlign.center,
      ),
    );

    // Animació que fa el placeholder i la imatge real
    var crossFade = AnimatedCrossFade(
      firstChild: placeholder, // Primer widget (placeholder)
      secondChild: digimonAvatar, // Segon widget (imatge del Digimon)
      // ignore: unnecessary_null_comparison
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond, // Decideix quin widget mostrar
      duration: const Duration(milliseconds: 1000), // Durada de l'animació
    );

    return crossFade;
  }

  // Funció asíncrona que obté i renderitza la URL de la imatge del Digimon
  void renderDigimonPic() async {
    await digimon.getImageUrl(); // Crida asíncrona per obtenir la URL de la imatge
    if (mounted) { // Comprova que el widget encara està muntat abans d'actualitzar l'estat
      setState(() {
        renderUrl = digimon.imageUrl; // Actualitza la URL i força un rebuild
      });
    }
  }

  // Widget que retorna  la targeta principal amb la informació del Digimon
  Widget get digimonCard {
    return Positioned(
      right: 0.0, // Posiciona la targeta a la dreta
      child: SizedBox(
        width: 290,
        height: 115,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)), // Vores arrodonides
          color: const Color(0xFFF8F8F8), // Color de fons de la targeta
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 34), // Padding per deixar espai per a la imatge
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Nom del Digimon
                Text(
                  widget.digimon.name,
                  style: const TextStyle(color: Color.fromARGB(255, 16, 88, 55), fontSize: 27.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
                // Puntuació del Digimon amb icona d'estrella
                Row(
                  children: <Widget>[
                    const Icon(Icons.star, color: Color.fromARGB(255, 16, 88, 55)),
                    Text(': ${widget.digimon.rating}/10', style: const TextStyle(color: Color.fromARGB(255, 16, 88, 55), fontSize: 18.0, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Funció asíncrona que navega a la pàgina de detall del Digimon
  showDigimonDetailPage() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DigimonDetailPage(digimon); // Crea i mostra la pàgina de detall
    }));
    onDigimonUpdated?.call(); // Crida el callback si existeix després de tornar
  }

  @override
  Widget build(BuildContext context) {
    // InkWell fa que tota la targeta sigui clicable amb efecte d'ona
    return InkWell(
      onTap: () => showDigimonDetailPage(), // Acció quan es toca la targeta
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 115.0,
          child: Stack( // Stack per superposar la imatge sobre la targeta
            children: <Widget>[
              digimonCard, // Targeta de fons amb la informació
              Positioned(top: 7.5, child: digimonImage), // Imatge posicionada a l'esquerra
            ],
          ),
        ),
      ),
    );
  }
}
