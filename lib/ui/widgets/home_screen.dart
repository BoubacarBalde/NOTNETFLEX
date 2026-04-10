import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflex/repositories/data_repositories.dart';
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
          Container(
              height: 500,
              color: Colors.red,
              child: dataProvider.popularMovieList.isEmpty
                  ? Center(child: CircularProgressIndicator(),)
                  : Image.network(dataProvider.popularMovieList[0].posterURL(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.error, color: Colors.white));
                },
              ),
          ),
          //TODO:Partie 1
          SizedBox(height: 15),
          Text(
            'Tendances actuelles',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5,),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: EdgeInsets.only(right: 8),
                    width: 110,
                    color: Colors.yellow,
                    child: Center(
                      child: dataProvider.popularMovieList.isEmpty
                      ?
                      CircularProgressIndicator()
                      : Image.network(dataProvider.popularMovieList[index].posterURL(),
                      fit: BoxFit.cover,)
                    ),
                  );
                }
            ),
          ),
          //TODO:Partie 2
          SizedBox(height: 15),
          Text(
            'Actuellement au cinéma',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5,),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 100,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  margin: EdgeInsets.only(right: 8),
                  width: 220,
                  color: Colors.blue,
                  child: Center(
                    child: Text(index.toString()),
                  ),
                );
              }
            ),
          ),
          //TODO:Partie 3
          SizedBox(height: 15),
          Text(
            'Ils arrivent bientot',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5,),
          SizedBox(
            height: 160,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 100,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: EdgeInsets.only(right: 8),
                    width: 110,
                    color: Colors.green,
                    child: Center(
                      child: Text(index.toString()),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
