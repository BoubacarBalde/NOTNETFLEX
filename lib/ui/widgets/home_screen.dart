import 'package:flutter/material.dart';
import 'package:notnetflex/repositories/data_repositories.dart';
import 'package:notnetflex/ui/widgets/movie_card.dart';
import 'package:notnetflex/ui/widgets/movie_categorie.dart';
import 'package:notnetflex/utils/constante.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepositories>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 500,
            child: MovieCard(movie: dataProvider.popularMovieList.first)
          ),
          //TODO:Partie 1
          MovieCategorie(
            imageHeigth: 160,
            imageWidth: 110,
            label: 'Tendance actuel',
            movieList: dataProvider.popularMovieList,
            callback: dataProvider.getPopularMovies,
          ),
          //TODO:Partie 2
          MovieCategorie(
            imageHeigth: 320,
            imageWidth: 220,
            label: 'Actuellement au cinéma',
            movieList: dataProvider.nowPlaying,
            callback: dataProvider.getNowPlaying,
          ),
          //TODO:Partie 3
          MovieCategorie(
            imageHeigth: 160,
            imageWidth: 110,
            label: 'Ils arrivent bientot',
            movieList: dataProvider.upcommingMovie,
            callback: dataProvider.getUpcommingMovie,
          ),
          //TODO:Partie 4
          MovieCategorie(
            imageHeigth: 320,
            imageWidth: 220,
            label: 'Animations',
            movieList: dataProvider.animationMovie,
            callback: dataProvider.getAnimationMovie,
          ),
        ],
      ),
    );
  }
}
