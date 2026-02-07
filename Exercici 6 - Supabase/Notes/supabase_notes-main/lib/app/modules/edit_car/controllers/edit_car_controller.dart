// Imports de Flutter, GetX y Supabase
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Controlador para la pantalla de editar coche
class EditCarController extends GetxController {
  // Estado reactivo de carga
  RxBool isLoading = false.obs;
  // Estado reactivo para mostrar/ocultar campos
  RxBool isHidden = true.obs;
  // Controladores de texto para cada campo del formulario
  TextEditingController marcaC = TextEditingController();
  TextEditingController modeloC = TextEditingController();
  TextEditingController anyoC = TextEditingController();
  TextEditingController colorC = TextEditingController();
  TextEditingController precioC = TextEditingController();
  // Cliente de Supabase para acceder a la base de datos
  SupabaseClient client = Supabase.instance.client;

  // Actualiza un coche en la tabla "coches" por su id
  Future<bool> editCar(int id) async {
    // Valida que marca y modelo no esten vacios
    if (marcaC.text.isNotEmpty && modeloC.text.isNotEmpty) {
      isLoading.value = true;
      // Actualiza el registro en Supabase que coincida con el id
      await client.from("coches").update({
        "marca": marcaC.text,
        "modelo": modeloC.text,
        "anyo": int.tryParse(anyoC.text),
        "color": colorC.text,
        "precio": double.tryParse(precioC.text),
      }).match({
        "id": id,
      });
      return true;
    } else {
      // Retorna false si faltan campos obligatorios
      return false;
    }
  }
}
