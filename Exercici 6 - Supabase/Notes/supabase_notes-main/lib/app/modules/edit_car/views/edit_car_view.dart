// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/coches_model.dart';
import 'package:supabase_notes/app/modules/home/controllers/home_controller.dart';

import '../controllers/edit_car_controller.dart';

class EditCarView extends GetView<EditCarController> {
  // Recibe el coche a editar desde los argumentos de navegacion
  Coches coche = Get.arguments;
  // Obtiene el HomeController para refrescar la lista tras editar
  HomeController homeC = Get.find();

  EditCarView({super.key});
  @override
  Widget build(BuildContext context) {
    // Carga los valores actuales del coche en los campos del formulario
    controller.marcaC.text = coche.marca!;
    controller.modeloC.text = coche.modelo!;
    controller.anyoC.text = coche.anyo?.toString() ?? '';
    controller.colorC.text = coche.color ?? '';
    controller.precioC.text = coche.precio?.toString() ?? '';
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Coche'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Campo de texto para la marca
            TextField(
              controller: controller.marcaC,
              decoration: const InputDecoration(
                labelText: "Marca",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Campo de texto para el modelo
            TextField(
              controller: controller.modeloC,
              decoration: const InputDecoration(
                labelText: "Modelo",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Campo numerico para el año
            TextField(
              controller: controller.anyoC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Año",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Campo de texto para el color
            TextField(
              controller: controller.colorC,
              decoration: const InputDecoration(
                labelText: "Color",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Campo numerico con decimales para el precio
            TextField(
              controller: controller.precioC,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Precio",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Boton reactivo: edita el coche y vuelve atras si tiene exito
            Obx(() => ElevatedButton(
                onPressed: () async {
                  // Evita doble pulsacion mientras carga
                  if (controller.isLoading.isFalse) {
                    bool res = await controller.editCar(coche.id!);
                    if (res == true) {
                      // Refresca la lista de coches en home y vuelve atras
                      await homeC.getAllCars();
                      Get.back();
                    }
                    controller.isLoading.value = false;
                  }
                },
                // Cambia el texto del boton segun el estado de carga
                child: Text(
                    controller.isLoading.isFalse ? "Editar coche" : "Cargando...")))
          ],
        ));
  }
}
