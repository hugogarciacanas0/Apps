import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/utils/utils.dart';

/// Widget que muestra información resumida de una película (título, rating, género, fecha)
class Infos extends StatelessWidget {
  const Infos({super.key, required this.movie});
  
  final Movie movie;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Título de la película
          SizedBox(
            width: 200,
            child: Text(
              movie.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Información adicional: rating, género y fecha
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating con estrella
              Row(
                children: [
                  SvgPicture.asset('assets/Star.svg'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    movie.voteAverage == 0.0
                        ? 'N/A'
                        : movie.voteAverage.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Color(0xFFFF8700),
                    ),
                  ),
                ],
              ),
              // Género con icono de ticket
              Row(
                children: [
                  SvgPicture.asset('assets/Ticket.svg'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    Utils.getGenres(movie),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
              // Fecha de estreno con icono de calendario
              Row(
                children: [
                  SvgPicture.asset('assets/calender.svg'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    movie.releaseDate.split('-')[0],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}