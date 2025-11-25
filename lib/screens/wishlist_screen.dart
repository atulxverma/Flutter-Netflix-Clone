import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/wishlist_manager.dart';
import 'details_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final movies = WishlistManager.wishlist;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My List", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      body: movies.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No movies added yet", style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailsScreen(movie: movie)),
                    ).then((_) => setState(() {})); // Refresh on back
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}