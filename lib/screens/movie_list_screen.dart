import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/movie_row.dart';

class MovieListScreen extends StatefulWidget {
  static const String routeName = '/movies';

  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final ApiService api = ApiService();

  List trending = [];
  List popular = [];
  List topRated = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    trending = await api.getTrendingMovies();
    popular = await api.getPopularMovies();
    topRated = await api.getTopRatedMovies();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Image.asset(
          'assets/images/netflix_logo.png',
          width: 120,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.search, color: Colors.white, size: 28),
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.red),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieRow(title: "Trending Now", movies: trending),
                  MovieRow(title: "Popular", movies: popular),
                  MovieRow(title: "Top Rated", movies: topRated),
                ],
              ),
            ),
    );
  }
}
