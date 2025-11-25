import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie.dart';
import '../services/wishlist_manager.dart';
import '../utils/utils.dart'; // 🔥 Import Helper Function

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  const DetailsScreen({super.key, required this.movie});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Hive se check karo favorite hai ya nahi
    bool isFav = WishlistManager.isFavorite(widget.movie);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header (Image + Close Button)
            Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: "https://image.tmdb.org/t/p/original${widget.movie.backdropPath.isNotEmpty ? widget.movie.backdropPath : widget.movie.posterPath}",
                    fit: BoxFit.cover,
                  ),
                ),
                // Play Icon Overlay
                Positioned.fill(
                   child: Center(
                     child: IconButton(
                       icon: const Icon(Icons.play_circle_fill, color: Colors.white54, size: 60),
                       // 🔥 Play Trailer on Image Tap
                       onPressed: () => playTrailer(context, widget.movie.id),
                     ),
                   ),
                ),
                // Close Button
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                      child: const Icon(Icons.close, color: Colors.white, size: 22),
                    ),
                  ),
                ),
              ],
            ),

            // 2. Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.movie.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    
                    Row(
                      children: [
                        Text("98% Match", style: TextStyle(color: Colors.green.shade400, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 12),
                        const Text("2023", style: TextStyle(color: Colors.grey)),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          color: Colors.grey[800],
                          child: const Text("HD", style: TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🔥 PLAY BUTTON WITH TRAILER LOGIC
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 12)),
                        onPressed: () {
                          // 🔥 Call Helper Function
                          playTrailer(context, widget.movie.id);
                        },
                        icon: const Icon(Icons.play_arrow, size: 28),
                        label: const Text("Play", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800], foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12)),
                        onPressed: () {}, // Download logic (Dummy)
                        icon: const Icon(Icons.download, size: 28),
                        label: const Text("Download", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(widget.movie.overview, style: const TextStyle(color: Colors.white70, height: 1.4)),

                    const SizedBox(height: 30),

                    // Action Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 🔥 My List Toggle
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              WishlistManager.toggleFavorite(widget.movie);
                            });
                          },
                          child: Column(
                            children: [
                              Icon(isFav ? Icons.check : Icons.add, color: Colors.white),
                              const SizedBox(height: 5),
                              const Text("My List", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                        Column(children: const [Icon(Icons.thumb_up, color: Colors.white), SizedBox(height: 5), Text("Rate", style: TextStyle(color: Colors.grey, fontSize: 12))]),
                        Column(children: const [Icon(Icons.share, color: Colors.white), SizedBox(height: 5), Text("Share", style: TextStyle(color: Colors.grey, fontSize: 12))]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}