import 'package:get/get.dart';

import '../controllers/edit_car_controller.dart';

// Binding que registra las dependencias de la pantalla de editar coche
class EditCarBinding extends Bindings {
  @override
  void dependencies() {
    // Registra el controlador con lazyPut (se crea solo cuando se necesita)
    Get.lazyPut<EditCarController>(
      () => EditCarController(),
    );
  }
}
