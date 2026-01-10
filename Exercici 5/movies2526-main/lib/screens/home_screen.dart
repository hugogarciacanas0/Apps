import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/controllers/search_controller.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/widgets/other_popular_perople.dart';
import 'package:movies/widgets/top_rated_actoritem.dart';

/// Pantalla principal que muestra actores populares
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final MoviesController controller = Get.put(MoviesController());
  final ActorController actorController = Get.put(ActorController());
  final SearchController1 searchController = Get.put(SearchController1());
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 42,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24), 
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Top Popular Actors',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 50,
                ),
              ),
            ),
            // Lista horizontal de actores mejor valorados
            Obx(
              (() => actorController.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 300,
                      child: ListView.separated(
                        itemCount: actorController.topRatedActors.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 24),
                        itemBuilder: (_, index) => TopRatedActorItem(
                            actor: actorController.topRatedActors[index],
                            index: index + 1),
                      ),
                    )),
            ),
            const SizedBox(height: 24), 
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Other Popular People',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Lista horizontal de otros actores populares
            Obx( 
              () => actorController.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 300,
                      child: ListView.separated(
                        itemCount: actorController.otherActors.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 24),
                        itemBuilder: (_, index) => OtherPopularPeopleItem(
                            actor: actorController.otherActors[index],
                            index: index + 1),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}