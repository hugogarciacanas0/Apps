import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/actor_detail_screen.dart';
import 'package:movies/widgets/index_number.dart';

/// Widget que muestra un actor con número de ranking (Top Rated)
class TopRatedActorItem extends StatelessWidget {
  const TopRatedActorItem({
    super.key,
    required this.actor,
    required this.index,
  });

  final Actor actor;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagen del actor
        GestureDetector(
          onTap: () => Get.to(
            ActorDetailsScreen(actor: actor),
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                Api.imageBaseUrl + actor.profilePath,
                fit: BoxFit.cover,
                height: 250,
                width: 180,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.person_off,
                  size: 180,
                ),
                loadingBuilder: (_, __, ___) {
                  // ignore: no_wildcard_variable_uses
                  if (___ == null) return __;
                  return const FadeShimmer(
                    width: 180,
                    height: 250,
                    highlightColor: Color(0xff22272f),
                    baseColor: Color(0xff20252d),
                  );
                },
              ),
            ),
          ),
        ),
        // Número de ranking en la esquina inferior izquierda
        Align(
          alignment: Alignment.bottomLeft,
          child: IndexNumber(number: index),
        ),
        // Nombre del actor en la parte inferior
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(
              left: 12,
              bottom: 8,
              right: 12,
            ),
            child: Text(
              actor.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}