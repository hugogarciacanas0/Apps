import 'package:get/get.dart';

import '../controllers/add_car_controller.dart';

// Binding que registra les dependències per a la pantalla d'afegir cotxe
class AddCarBinding extends Bindings {
  @override
  void dependencies() {
    // Registra el controlador amb lazyPut (es crea només quan es necessita)
    Get.lazyPut<AddCarController>(
      () => AddCarController(),
    );
  }
}