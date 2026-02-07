// Imports de Flutter, GetX, modelos y rutas
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart';
import 'package:supabase_notes/app/data/models/coches_model.dart';
import 'package:supabase_notes/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

// Vista principal que usa GetView para inyectar el HomeController
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Barra superior con titulo y boton de perfil
        appBar: AppBar(
          title: const Text('HOME'),
          centerTitle: true,
          actions: [
            // Boton que navega a la pantalla de perfil
            IconButton(
              onPressed: () async {
                Get.toNamed(Routes.PROFILE);
              },
              icon: const Icon(Icons.person),
            )
          ],
        ),
        // FutureBuilder que espera a cargar notas y coches en paralelo
        body: FutureBuilder(
            future: Future.wait([
              controller.getAllNotes(),
              controller.getAllCars(),
            ]),
            builder: (context, snapshot) {
              // Muestra spinner mientras se cargan los datos
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // --- SECCION NOTAS ---
                  const Text(
                    "Notas",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Obx: se reconstruye cuando cambia la lista reactiva allNotes
                  Obx(() => controller.allNotes.isEmpty
                      ? const Center(child: Text("No hay notas"))
                      : ListView.builder(
                          shrinkWrap: true, // Ajusta altura al contenido
                          physics: const NeverScrollableScrollPhysics(), // Desactiva scroll propio
                          itemCount: controller.allNotes.length,
                          itemBuilder: (context, index) {
                            Notes note = controller.allNotes[index];
                            return ListTile(
                              // Al pulsar, navega a editar la nota
                              onTap: () => Get.toNamed(
                                Routes.EDIT_NOTE,
                                arguments: note,
                              ),
                              leading: CircleAvatar(
                                child: Text("t${note.id}"),
                              ),
                              title: Text("title: ${note.title}"),
                              subtitle: Text("description: ${note.description}"),
                              // Boton para eliminar la nota
                              trailing: IconButton(
                                onPressed: () async =>
                                    await controller.deleteNote(note.id!),
                                icon: const Icon(Icons.delete),
                              ),
                            );
                          },
                        )),
                  const SizedBox(height: 10),
                  // Boton para añadir una nueva nota
                  ElevatedButton.icon(
                    onPressed: () => Get.toNamed(Routes.ADD_NOTE),
                    icon: const Icon(Icons.add),
                    label: const Text("Añadir nota"),
                  ),
                  const SizedBox(height: 30),
                  // --- SECCION COCHES ---
                  const Text(
                    "Coches",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Obx: se reconstruye cuando cambia la lista reactiva allCars
                  Obx(() => controller.allCars.isEmpty
                      ? const Center(child: Text("No hay coches"))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.allCars.length,
                          itemBuilder: (context, index) {
                            Coches coche = controller.allCars[index];
                            return ListTile(
                              // Al pulsar, navega a editar el coche
                              onTap: () => Get.toNamed(
                                Routes.EDIT_CAR,
                                arguments: coche,
                              ),
                              leading: CircleAvatar(
                                child: Text("c${coche.id}"),
                              ),
                              title: Text("${coche.marca} ${coche.modelo}"),
                              subtitle: Text("Año: ${coche.anyo} · Color: ${coche.color} · Precio: ${coche.precio}€"),
                              // Boton para eliminar el coche
                              trailing: IconButton(
                                onPressed: () async =>
                                    await controller.deleteCar(coche.id!),
                                icon: const Icon(Icons.delete),
                              ),
                            );
                          },
                        )),
                  const SizedBox(height: 10),
                  // Boton para añadir un nuevo coche
                  ElevatedButton.icon(
                    onPressed: () => Get.toNamed(Routes.ADD_CAR),
                    icon: const Icon(Icons.add),
                    label: const Text("Añadir coche"),
                  ),
                ],
              );
            }),
    );
  }
}
