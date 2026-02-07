import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Controlador per a la pantalla d'afegir un cotxe nou
class AddCarController extends GetxController {
  // Estat reactiu de càrrega
  RxBool isLoading = false.obs;
  // Estat reactiu per mostrar/amagar elements
  RxBool isHidden = true.obs;
  // Controladors de text per a cada camp del formulari
  TextEditingController marcaC = TextEditingController();
  TextEditingController modeloC = TextEditingController();
  TextEditingController anyoC = TextEditingController();
  TextEditingController colorC = TextEditingController();
  TextEditingController precioC = TextEditingController();
  // Client de Supabase per accedir a la base de dades
  SupabaseClient client = Supabase.instance.client;

  // Afegeix un cotxe nou a la taula "coches" de Supabase
  Future<bool> addCar() async {
    // Valida que marca i model no estiguin buits
    if (marcaC.text.isNotEmpty && modeloC.text.isNotEmpty) {
      isLoading.value = true;
      // Obté l'id intern de l'usuari autenticat des de la taula "users"
      List<dynamic> res = await client
          .from("users")
          .select("id")
          .match({"uid": client.auth.currentUser!.id});
      Map<String, dynamic> user = (res).first as Map<String, dynamic>;
      int id = user["id"];
      // Insereix el cotxe nou amb l'id de l'usuari com a clau forana
      await client.from("coches").insert({
        "user_id": id,
        "marca": marcaC.text,
        "modelo": modeloC.text,
        "anyo": int.tryParse(anyoC.text),
        "color": colorC.text,
        "precio": double.tryParse(precioC.text),
        "created_at": DateTime.now().toIso8601String(),
      });
      return true;
    } else {
      // Retorna fals si falten camps obligatoris
      return false;
    }
  }
}