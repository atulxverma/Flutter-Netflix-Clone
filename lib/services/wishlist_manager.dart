import '../models/movie.dart';

class WishlistManager {
  // Static list taaki puri app me same list rahe
  static final List<Movie> _wishlist = [];

  static List<Movie> get wishlist => _wishlist;

  static void toggleFavorite(Movie movie) {
    if (_wishlist.any((m) => m.id == movie.id)) {
      _wishlist.removeWhere((m) => m.id == movie.id);
    } else {
      _wishlist.add(movie);
    }
  }

  static bool isFavorite(Movie movie) {
    return _wishlist.any((m) => m.id == movie.id);
  }
}