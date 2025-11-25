class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? json['name'] ?? 'Unknown',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      overview: json['overview'] ?? 'No description available.',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}