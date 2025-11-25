import 'package:flutter/material.dart';
import 'movie_card.dart';

class MovieRow extends StatelessWidget {
  final String title;
  final List movies;

  const MovieRow({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: movies[index]);
            },
          ),
        )
      ],
    );
  }
}
