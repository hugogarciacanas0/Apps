import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart';
import 'package:supabase_notes/app/data/models/coches_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  RxList allNotes = List<Notes>.empty().obs;
  RxList allCars = List<Coches>.empty().obs;
  SupabaseClient client = Supabase.instance.client;

  Future<void> getAllNotes() async {
    List<dynamic> res = await client
        .from("users")
        .select("id")
        .match({"uid": client.auth.currentUser!.id});
    Map<String, dynamic> user = (res).first as Map<String, dynamic>;
    int id = user["id"]; //get user id before get all notes data
    var notes = await client.from("notes").select().match(
      {"user_id": id}, //get all notes data with match user id
    );
    List<Notes> notesData = Notes.fromJsonList((notes as List));
    allNotes(notesData);
    allNotes.refresh();
  }

  Future<void> getAllCars() async {
    List<dynamic> res = await client
        .from("users")
        .select("id")
        .match({"uid": client.auth.currentUser!.id});
    Map<String, dynamic> user = (res).first as Map<String, dynamic>;
    int id = user["id"]; //get user id before get all cars data
    var cars = await client.from("coches").select().match(
      {"user_id": id}, //get all cars data with match user id
    );
    List<Coches> carsData = Coches.fromJsonList((cars as List));
    allCars(carsData);
    allCars.refresh();
  }

  Future<void> deleteNote(int id) async {
    await client.from("notes").delete().match({
      "id": id,
    });
    getAllNotes();
  }

  Future<void> deleteCar(int id) async {
    await client.from("coches").delete().match({
      "id": id,
    });
    getAllCars();
  }
}
