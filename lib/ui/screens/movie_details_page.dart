import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflex/models/Movie.dart';
import 'package:notnetflex/repositories/data_repositories.dart';
import 'package:notnetflex/ui/widgets/movie_info.dart';
import 'package:notnetflex/utils/constante.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepositories>(context, listen: false);
    Movie _data = await dataProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      newMovie = _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(backgroundColor: kBackgroundColor),
      body: newMovie == null
          ? SpinKitFadingCircle(color: kPrimaryColor)
          : ListView(
              padding: EdgeInsets.all(8.0),
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  color: Colors.red,
                ),
                MovieInfo(movie: newMovie!)
              ],
            ),
    );
  }
}
