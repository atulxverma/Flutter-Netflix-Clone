import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'details_screen.dart';
import 'search_screen.dart';
import 'wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trending;
  late Future<List<Movie>> popular;
  late Future<List<Movie>> topRated;

  @override
  void initState() {
    super.initState();
    trending = ApiService().getTrendingMovies();
    popular = ApiService().getPopularMovies();
    topRated = ApiService().getTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 80, 
        title: Image.asset(
          "assets/images/netflix_logo.png",
          height: 70, 
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 30, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.favorite, size: 30, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const WishlistScreen()));
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 CAROUSEL WITH BUTTONS FIXED
            FutureBuilder<List<Movie>>(
              future: trending,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return _buildCarousel(snapshot.data!);
                }
                return const SizedBox(height: 500, child: Center(child: CircularProgressIndicator()));
              },
            ),

            const SizedBox(height: 20),
            _buildSection("Trending Now", trending),
            _buildSection("Top Rated Movies", topRated),
            _buildSection("Popular on Netflix", popular),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(List<Movie> movies) {
    final topMovies = movies.take(5).toList();
    return CarouselSlider(
      options: CarouselOptions(
        height: 600.0, // Height badhayi taaki buttons fit aayein
        autoPlay: true,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 5),
      ),
      items: topMovies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(movie: movie))),
              child: Stack(
                children: [
                  // 1. Image
                  SizedBox(
                    width: double.infinity,
                    height: 600,
                    child: CachedNetworkImage(
                      imageUrl: "https://image.tmdb.org/t/p/original${movie.posterPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  // 2. Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                  // 3. 🔥 TEXT & BUTTONS (Jo miss ho gaya tha)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        // Genres
                        const Text(
                          "Sci-Fi • Thriller • Action",
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 15),
                        
                        // Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // My List Button
                            Column(
                              children: const [
                                Icon(Icons.add, color: Colors.white),
                                SizedBox(height: 5),
                                Text("My List", style: TextStyle(color: Colors.white, fontSize: 12))
                              ],
                            ),
                            const SizedBox(width: 30),

                            // Play Button
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsScreen(movie: movie)));
                              },
                              icon: const Icon(Icons.play_arrow, size: 28),
                              label: const Text("Play", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 30),

                            // Info Button
                            Column(
                              children: const [
                                Icon(Icons.info_outline, color: Colors.white),
                                SizedBox(height: 5),
                                Text("Info", style: TextStyle(color: Colors.white, fontSize: 12))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildSection(String title, Future<List<Movie>> future) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 240,
          child: FutureBuilder<List<Movie>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => MovieCard(movie: snapshot.data![index]),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}