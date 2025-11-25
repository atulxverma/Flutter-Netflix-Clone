import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie.dart';
import '../screens/details_screen.dart';
import '../services/wishlist_manager.dart'; // Import Manager

class MovieCard extends StatefulWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  
  @override
  Widget build(BuildContext context) {
    bool isFav = WishlistManager.isFavorite(widget.movie);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(movie: widget.movie)),
        ).then((_) => setState((){})); // Wapis aane par status update ho
      },
      child: Container(
        width: 130,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Poster
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 180,
                    width: 130,
                    child: CachedNetworkImage(
                      imageUrl: "https://image.tmdb.org/t/p/w500${widget.movie.posterPath}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.grey.shade900),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                
                // Heart Icon
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        WishlistManager.toggleFavorite(widget.movie);
                      });
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(WishlistManager.isFavorite(widget.movie) ? "Added to My List" : "Removed from My List"),
                          duration: const Duration(milliseconds: 800),
                          backgroundColor: const Color(0xFFE50914),
                        )
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? const Color(0xFFE50914) : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 14),
                const SizedBox(width: 4),
                Text(
                  widget.movie.voteAverage.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}