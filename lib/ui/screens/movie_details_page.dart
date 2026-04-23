import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflex/models/Movie.dart';
import 'package:notnetflex/repositories/data_repositories.dart';
import 'package:notnetflex/ui/widgets/action_button.dart';
import 'package:notnetflex/ui/widgets/movie_info.dart';
import 'package:notnetflex/utils/constante.dart';
import 'package:provider/provider.dart';

import '../widgets/cating_card.dart';
import '../widgets/galerie_card.dart';
import '../widgets/my_video_player.dart';

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
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: newMovie!.videos!.isEmpty
                      ? Center(
                          child: Text(
                            'Pas de video',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        )
                      : MyVideoPlayer(movieId: newMovie!.videos!.first),
                ),
                MovieInfo(movie: newMovie!),
                SizedBox(height: 10),
                ActionButton(
                  label: 'Lecture',
                  icon: Icons.play_arrow,
                  bgColor: Colors.white,
                  colorText: kBackgroundColor,
                ),
                SizedBox(height: 10),
                ActionButton(
                  label: 'Télécharger la viedéo',
                  icon: Icons.download,
                  bgColor: Colors.white.withOpacity(0.3),
                  colorText: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  newMovie!.description,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                ),
                SizedBox(height: 20),
                Text(
                  'Casting',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: newMovie!.casting!.length,
                    itemBuilder: (BuildContext context, index) {
                      return newMovie!.casting![index].imageName == null
                          ? Center()
                          : CastingCard(personne: newMovie!.casting![index]);
                    },
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Galerie',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: newMovie!.images!.length,
                      itemBuilder: (context, index){
                        return GalerieCard(posterPath: newMovie!.images![index]);
                      }
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
    );
  }
}
