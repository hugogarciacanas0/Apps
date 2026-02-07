// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_notes/app/modules/home/controllers/home_controller.dart';

import '../controllers/add_car_controller.dart';

// Vista per afegir un cotxe nou
class AddCarView extends GetView<AddCarController> {
  // Obté el HomeController per refrescar la llista després d'afegir
  HomeController homeC = Get.find();

  AddCarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Barra superior amb el títol
        appBar: AppBar(
          title: const Text('Añadir Coche'),
          centerTitle: true,
        ),
        // Llista amb els camps del formulari
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Camp de text per a la marca
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
            // Camp de text per al model
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
            // Camp numèric per a l'any
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
            // Camp de text per al color
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
            // Camp numèric amb decimals per al preu
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
            // Botó reactiu per afegir el cotxe
            Obx(() => ElevatedButton(
                onPressed: () async {
                  // Només executa si no està carregant
                  if (controller.isLoading.isFalse) {
                    bool res = await controller.addCar();
                    if (res == true) {
                      // Refresca la llista i torna enrere
                      await homeC.getAllCars();
                      Get.back();
                    }
                    controller.isLoading.value = false;
                  }
                },
                // Mostra "Cargando..." mentre s'està processant
                child: Text(
                    controller.isLoading.isFalse ? "Añadir coche" : "Cargando...")))
          ],
        ));
  }
}