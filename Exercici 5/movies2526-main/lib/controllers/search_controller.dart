import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/movie.dart';

/// Controlador para gestionar la búsqueda de películas
class SearchController1 extends GetxController {
  // Controlador del campo de texto de búsqueda
  TextEditingController searchController = TextEditingController();
  
  // Texto actual de búsqueda
  var searchText = ''.obs;
  
  // Lista de películas encontradas en la búsqueda
  var foundedMovies = <Movie>[].obs;
  
  var isLoading = false.obs;
  
  /// Actualiza el texto de búsqueda
  void setSearchText(text) => searchText.value = text;
  
  /// Realiza la búsqueda de películas por query
  void search(String query) async {
    // Activar indicador de carga
    isLoading.value = true;
    
    // Buscar películas y actualizar lista (vacía si no hay resultados)
    foundedMovies.value = (await ApiService.getSearchedMovies(query)) ?? [];
    
    // Desactivar indicador de carga
    isLoading.value = false;
  }
}