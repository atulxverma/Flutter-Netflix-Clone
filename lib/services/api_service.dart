import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  final String apiKey = "40e0ee5fec8a8684205c5ef352472e07"; // Check API Key
  final String baseUrl = "https://api.themoviedb.org/3";

  Future<List<Movie>> _get(String endpoint) async {
    try {
      final url = Uri.parse("$baseUrl$endpoint");
      print("🌍 Requesting: $url"); // Console me dikhega

      final response = await http.get(url);
      
      print("📡 Status Code: ${response.statusCode}"); // 200 aana chahiye

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List results = data['results'];
        print("✅ Movies Found: ${results.length}"); // Kitni movies aayi
        return results.map((e) => Movie.fromJson(e)).toList();
      } else {
        print("❌ API Error: ${response.body}"); // Agar API ne mana kiya
        return [];
      }
    } catch (e) {
      print("🔥 CRITICAL ERROR in API: $e"); // Agar internet ya code futa
      return [];
    }
  }

  Future<List<Movie>> getTrendingMovies() async => _get("/trending/movie/day?api_key=$apiKey");
  Future<List<Movie>> getPopularMovies() async => _get("/movie/popular?api_key=$apiKey");
  Future<List<Movie>> getTopRatedMovies() async => _get("/movie/top_rated?api_key=$apiKey");
  Future<List<Movie>> searchMovies(String query) async => _get("/search/movie?api_key=$apiKey&query=$query");

  Future<String> getYoutubeId(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/movie/$id/videos?api_key=$apiKey"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];
        final trailer = results.firstWhere(
          (video) => video['site'] == "YouTube" && video['type'] == "Trailer",
          orElse: () => null,
        );
        return trailer?['key'] ?? "";
      }
    } catch (e) {
      print("Error fetching trailer: $e");
    }
    return "";
  }
}