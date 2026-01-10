import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/widgets/tab_builder_credits.dart';

/// Pantalla de detalle de un actor con biografía y créditos
class ActorDetailsScreen extends StatelessWidget {
  const ActorDetailsScreen({
    super.key,
    required this.actor,
  });

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Cargar datos completos del actor desde la API
        body: FutureBuilder<Actor?>(
          future: ApiService.getActorDetail(actor.id),
          builder: (context, snapshot) {
            // Usar datos detallados o fallback al actor básico
            final detailedActor = snapshot.data ?? actor;

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header con botón de retroceso y título
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          tooltip: 'Back to home',
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Detail',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Stack con imagen de fondo, foto de perfil, nombre y popularidad
                  SizedBox(
                    height: 330,
                    child: Stack(
                      children: [
                        // Imagen de fondo grande
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          child: Image.network(
                            Api.imageBaseUrl + detailedActor.profilePath,
                            width: Get.width,
                            height: 250,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, __, ___) {
                              // ignore: no_wildcard_variable_uses
                              if (___ == null) return __;
                              return FadeShimmer(
                                width: Get.width,
                                height: 250,
                                highlightColor: const Color(0xff22272f),
                                baseColor: const Color(0xff20252d),
                              );
                            },
                            errorBuilder: (_, __, ___) => const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.person_off,
                                size: 250,
                              ),
                            ),
                          ),
                        ),
                        // Imagen de perfil pequeña
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500/${detailedActor.profilePath}',
                                width: 110,
                                height: 140,
                                fit: BoxFit.cover,
                                loadingBuilder: (_, __, ___) {
                                  // ignore: no_wildcard_variable_uses
                                  if (___ == null) return __;
                                  return const FadeShimmer(
                                    width: 110,
                                    height: 140,
                                    highlightColor: Color(0xff22272f),
                                    baseColor: Color(0xff20252d),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        // Nombre del actor
                        Positioned(
                          top: 255,
                          left: 155,
                          child: SizedBox(
                            width: 230,
                            child: Text(
                              detailedActor.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        // Badge de popularidad
                        Positioned(
                          top: 200,
                          right: 30,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color.fromRGBO(37, 40, 54, 0.52),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/Star.svg'),
                                const SizedBox(width: 5),
                                Text(
                                  detailedActor.popularity.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFFF8700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Información de fecha y lugar de nacimiento
                  Opacity(
                    opacity: .6,
                    child: SizedBox(
                      width: Get.width / 1.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (detailedActor.birthday.isNotEmpty) ...[
                            Row(
                              children: [
                                const SizedBox(width: 5),
                                Text(
                                  detailedActor.birthday,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const Text('|'),
                          ],
                          if (detailedActor.placeOfBirth.isNotEmpty)
                            Flexible(
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      detailedActor.placeOfBirth,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  // Tabs de Biography y Credits
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TabBar(
                            indicatorWeight: 4,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Color(0xFF3A3F47),
                            tabs: [
                              Tab(text: 'Biography'),
                              Tab(text: 'Credits'),
                            ],
                          ),
                          SizedBox(
                            height: 400,
                            child: TabBarView(
                              children: [
                                // Tab 1: Biografía del actor
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      detailedActor.biography.isEmpty
                                          ? 'No biography available'
                                          : detailedActor.biography,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                // Tab 2: Créditos (películas del actor)
                                ActorCreditsBuilder(
                                  future: ApiService.getActorMovieCredits(detailedActor.id),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}