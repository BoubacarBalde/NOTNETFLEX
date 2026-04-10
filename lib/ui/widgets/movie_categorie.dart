import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflex/models/Movie.dart';

import 'movie_card.dart';

class MovieCategorie extends StatelessWidget {
  final String label;
  final List<Movie> movieList;
  final double imageHeigth;
  final double imageWidth;
  final Function callback;

  const MovieCategorie({
    super.key,
    required this.imageHeigth,
    required this.imageWidth,
    required this.label,
    required this.movieList,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          height: imageHeigth,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              final currentPosition = notification.metrics.pixels;
              final maxPosition = notification.metrics.maxScrollExtent;
              if (currentPosition >= maxPosition / 2) {
                callback();
              }
              return true;
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(right: 8),
                  width: imageWidth,
                  child: Center(
                    child: movieList.isEmpty
                        ? CircularProgressIndicator()
                        : MovieCard(movie: movieList[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
