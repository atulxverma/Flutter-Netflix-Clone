import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../screens/trailer_player_screen.dart';

// 🔥 Global Function to Play Trailer
void playTrailer(BuildContext context, int movieId) async {
  // 1. Loading Indicator dikhao
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator(color: Color(0xFFE50914))),
  );

  try {
    // 2. API se YouTube ID mango
    String videoId = await ApiService().getYoutubeId(movieId);

    // 3. Loading hatao
    if (context.mounted) Navigator.pop(context);

    if (videoId.isNotEmpty) {
      // 4. Video Screen par le jao
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TrailerPlayerScreen(videoId: videoId)),
        );
      }
    } else {
      // 5. Agar Trailer nahi mila
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No Trailer available for this movie"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  } catch (e) {
    if (context.mounted) Navigator.pop(context); // Error aaya to loading hatao
    print("Error playing trailer: $e");
  }
}