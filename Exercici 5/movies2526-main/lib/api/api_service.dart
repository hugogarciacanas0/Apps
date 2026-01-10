import 'dart:convert';
import 'package:movies/api/api.dart';
import 'package:movies/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/review.dart';
import 'package:movies/models/actor.dart';

/// Servicio para realizar llamadas a la API de TMDb
class ApiService {
  /// Obtiene las películas mejor valoradas (top rated) saltando las primeras 6
  static Future<List<Movie>?> getTopRatedMovies() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/top_rated?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      // Saltar las primeras 6 y tomar las siguientes 5
      res['results'].skip(6).take(5).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  /// Obtiene películas personalizadas según la URL proporcionada
  static Future<List<Movie>?> getCustomMovies(String url) async {
    List<Movie> movies = [];
    try {
      http.Response response =
          await http.get(Uri.parse('${Api.baseUrl}movie/$url'));
      var res = jsonDecode(response.body);
      // Tomar las primeras 6 películas
      res['results'].take(6).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  /// Busca películas por query de búsqueda
  static Future<List<Movie>?> getSearchedMovies(String query) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=YourApiKey&language=en-US&query=$query&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  /// Obtiene las reviews/reseñas de una película específica
  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }

  /// Obtiene todos los actores populares
  static Future<List<Actor>?> getPopularActors() async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(
        Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1',
        ),
      );

      var res = jsonDecode(response.body);
      res['results'].forEach(
        (a) => actors.add(
          Actor.fromMap(a),
        ),
      );
      return actors;
    } catch (e) {
      return null;
    }
  }

  /// Obtiene los detalles completos de un actor específico (biografía, fecha de nacimiento, etc.)
  static Future<Actor?> getActorDetail(int actorId) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          '${Api.baseUrl}person/$actorId?api_key=${Api.apiKey}&language=en-US',
        ),
      );

      var res = jsonDecode(response.body);
      return Actor.fromMap(res);
    } catch (e) {
      return null;
    }
  }

  /// Obtiene los 5 actores más populares
  static Future<List<Actor>?> getTop5PopularActors() async {
    List<Actor> actors = [];
    try {
      final response = await http.get(
        Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1',
        ),
      );

      final res = jsonDecode(response.body);
      // Tomar solo los primeros 5 actores
      res['results'].take(5).forEach((a) => actors.add(Actor.fromMap(a)));

      return actors;
    } catch (e) {
      return null;
    }
  }

  /// Obtiene las películas donde ha participado un actor (créditos)
  static Future<List<Movie>?> getActorMovieCredits(int actorId) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(
        Uri.parse(
          '${Api.baseUrl}person/$actorId/movie_credits?api_key=${Api.apiKey}&language=en-US',
        ),
      );

      var res = jsonDecode(response.body);
      // Obtener solo el "cast" (películas donde actuó)
      res['cast'].forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );

      // Ordenar por rating de mayor a menor
      movies.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));

      return movies;
    } catch (e) {
      return null;
    }
  }
}
