import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie.dart';
import '../services/wishlist_manager.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  const DetailsScreen({super.key, required this.movie});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    bool isFav = WishlistManager.isFavorite(widget.movie);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 🔥 TOP SECTION (Video Player Style)
            Stack(
              children: [
                // 1. Movie Poster (16:9 Aspect Ratio like video player)
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: CachedNetworkImage(
                    imageUrl: "https://image.tmdb.org/t/p/original${widget.movie.backdropPath.isNotEmpty ? widget.movie.backdropPath : widget.movie.posterPath}",
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                  ),
                ),
                
                // 2. Gradient Shadow at Bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                      ),
                    ),
                  ),
                ),

                // 3. Play Button Overlay (Center)
                Positioned.fill(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.play_arrow, size: 40, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                // 4. 🔥 CLOSE BUTTON (Top Right - Netflix Style)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ],
            ),

            // 🔥 DETAILS SCROLLABLE SECTION
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.movie.title,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),

                    // Metadata Row
                    Row(
                      children: [
                        const Text("98% Match", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 12),
                        const Text("2023", style: TextStyle(color: Colors.grey)),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(4)),
                          child: const Text("HD", style: TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Big White Play Button
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow),
                        label: const Text("Play", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    // Download Button
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[900], foregroundColor: Colors.white),
                        onPressed: () {},
                        icon: const Icon(Icons.download),
                        label: const Text("Download", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Description
                    Text(
                      widget.movie.overview,
                      style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
                    ),

                    const SizedBox(height: 30),

                    // Action Icons Row (My List, Rate, Share)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // My List Toggle
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              WishlistManager.toggleFavorite(widget.movie);
                            });
                          },
                          child: Column(
                            children: [
                              Icon(isFav ? Icons.check : Icons.add, color: Colors.white, size: 28),
                              const SizedBox(height: 4),
                              Text(isFav ? "My List" : "My List", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                        Column(
                          children: const [
                            Icon(Icons.thumb_up_alt_outlined, color: Colors.white, size: 28),
                            SizedBox(height: 4),
                            Text("Rate", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(Icons.share, color: Colors.white, size: 28),
                            SizedBox(height: 4),
                            Text("Share", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
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