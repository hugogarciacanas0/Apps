import 'dart:convert';
import 'dart:io';
import 'dart:async';

// Classe per representar un Digimon (còctel)
class Digimon {
  final String name; // Nom del Digimon
  String? imageUrl; // URL de la imatge
  String? apiname; // Nom per l'API

  int rating = 10; // Puntuació per defecte

  Digimon(this.name); // Constructor

  // Mètode per obtenir la URL de la imatge des de l'API
  Future getImageUrl() async {
    if (imageUrl != null) {
      return; // Ja té imatge
    }

    HttpClient http = HttpClient();
    try {
      apiname = name.toLowerCase(); // Nom en minúscules per l'API
      var uri = Uri.https(
          'www.thecocktaildb.com', '/api/json/v1/1/search.php', {'s': apiname}); // URL de l'API

      var request = await http.getUrl(uri);
      var response = await request.close();
      
      var responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      List data = jsonResponse["drinks"];
      imageUrl = data[0]["strDrinkThumb"]; 
    } catch (exception) {
      //print(exception); // Gestiona errors
    }
  }
}
