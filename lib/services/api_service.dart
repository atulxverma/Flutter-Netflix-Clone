import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  final String apiKey = "40e0ee5fec8a8684205c5ef352472e07"; // Use env variables in production
  final String baseUrl = "https://api.themoviedb.org/3";

  Future<List<Movie>> _get(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List results = jsonDecode(response.body)['results'];
        return results.map((e) => Movie.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  Future<List<Movie>> getTrendingMovies() async => _get("/trending/movie/day?api_key=$apiKey");
  Future<List<Movie>> getPopularMovies() async => _get("/movie/popular?api_key=$apiKey");
  Future<List<Movie>> getTopRatedMovies() async => _get("/movie/top_rated?api_key=$apiKey");
  Future<List<Movie>> getUpcomingMovies() async => _get("/movie/upcoming?api_key=$apiKey");

  Future<List<Movie>> searchMovies(String query) async {
    return _get("/search/movie?api_key=$apiKey&query=$query");
  }
}