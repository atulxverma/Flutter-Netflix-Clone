import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Movie> _results = [];
  bool _isLoading = false;

  void _search(String query) async {
    if (query.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final movies = await ApiService().searchMovies(query);
      setState(() => _results = movies);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // 🔥 BACK BUTTON FIXED
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: CupertinoSearchTextField(
          controller: _controller,
          backgroundColor: Colors.grey.shade800,
          itemColor: Colors.grey,
          style: const TextStyle(color: Colors.white),
          placeholder: "Search titles, genres...",
          placeholderStyle: const TextStyle(color: Colors.grey),
          onSubmitted: _search,
          onChanged: (value) {
            if(value.length > 3) _search(value);
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _results.isEmpty
              ? const Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.movie_creation_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Find your next favorite.", style: TextStyle(color: Colors.grey)),
                ],
              ))
              : ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final movie = _results[index];
                    return ListTile(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(movie: movie))),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: movie.posterPath.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                                width: 80, // Thoda bada image
                                fit: BoxFit.cover,
                              )
                            : Container(width: 80, color: Colors.grey),
                      ),
                      title: Text(movie.title, style: const TextStyle(color: Colors.white)),
                      trailing: const Icon(Icons.play_circle_outline, color: Colors.white),
                    );
                  },
                ),
    );
  }
}