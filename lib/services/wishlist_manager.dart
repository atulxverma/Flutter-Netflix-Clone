import 'package:hive_flutter/hive_flutter.dart';
import '../models/movie.dart';

class WishlistManager {
  static final _box = Hive.box('wishlist');

  static void toggleFavorite(Movie movie) {
    if (_box.containsKey(movie.id)) {
      _box.delete(movie.id);
    } else {
      _box.put(movie.id, {
        'id': movie.id,
        'title': movie.title,
        'poster_path': movie.posterPath,
        'backdrop_path': movie.backdropPath,
        'overview': movie.overview,
        'vote_average': movie.voteAverage,
      });
    }
  }

  static bool isFavorite(Movie movie) {
    return _box.containsKey(movie.id);
  }

  static List<Movie> getAllMovies() {
    final data = _box.values.toList();
    return data.map((e) {
      // Hive se Map nikaal ke Movie Object banaya
      final map = Map<String, dynamic>.from(e);
      return Movie.fromJson(map);
    }).toList();
  }
}