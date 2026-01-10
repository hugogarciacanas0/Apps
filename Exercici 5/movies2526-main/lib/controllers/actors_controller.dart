import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

// Controlador para actores
class ActorController extends GetxController {
  var isLoading = false.obs;
  // Lista de actores mejor valorados
  var topRatedActors = <Actor>[].obs;
  // Lista de otros actores populares
  var otherActors = <Actor>[].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    // Obtiene actores mejor valorados
    topRatedActors.value = (await ApiService.getTop5PopularActors())!;
    // Obtiene otros actores populares
    otherActors.value = (await ApiService.getPopularActors())!;
    isLoading.value = false;
    super.onInit();
  }
}
