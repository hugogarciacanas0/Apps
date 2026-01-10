import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/actor_detail_screen.dart';

/// Widget que muestra un item de actor en la sección "Other Popular People"
class OtherPopularPeopleItem extends StatelessWidget {
  const OtherPopularPeopleItem({
    super.key,
    required this.actor,
    required this.index,
  });

  final Actor actor;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        ActorDetailsScreen(actor: actor),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 12),
        width: 180,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Imagen del actor
            ClipRRect(
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
            const SizedBox(height: 8),
            // Nombre del actor
            Text(
              actor.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}