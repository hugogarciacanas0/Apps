import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/movie.dart';

/// Controlador para gestionar el estado de las películas
class MoviesController extends GetxController {
  var isLoading = false.obs;
  
  // Lista de películas mejor valoradas para mostrar en pantalla principal
  var mainTopRatedMovies = <Movie>[].obs;
  
  // Lista de películas guardadas para ver más tarde
  var watchListMovies = <Movie>[].obs;
  
  @override
  void onInit() async {
    isLoading.value = true;
    
    // Cargar películas mejor valoradas desde la API
    mainTopRatedMovies.value = (await ApiService.getTopRatedMovies())!;
    
    isLoading.value = false;
    super.onInit();
  }

  /// Verifica si una película está en la watchlist
  bool isInWatchList(Movie movie) {
    return watchListMovies.any((m) => m.id == movie.id);
  }

  /// Añade o elimina una película de la watchlist
  void addToWatchList(Movie movie) {
    // Si ya está en la lista, eliminarla
    if (watchListMovies.any((m) => m.id == movie.id)) {
      watchListMovies.remove(movie);
      Get.snackbar('Success', 'removed from watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    } else {
      // Si no está, añadirla
      watchListMovies.add(movie);
      Get.snackbar('Success', 'added to watch list',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    }
  }
}
