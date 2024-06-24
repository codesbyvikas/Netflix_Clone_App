import 'package:flutter/material.dart';
import 'package:netflix_clone_app/data/api_services.dart';
import 'package:netflix_clone_app/models/upcoming_model.dart';
import 'package:netflix_clone_app/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcomingmodel;
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    upcomingmodel = apiServices.getUpcomingMovies();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/logo.png",
            height: 50,
            width: 120,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.blue,
                height: 27,
                width: 27,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                    height: 220,
                    child: MovieCard(
                        future: upcomingmodel, headLineText: "Upcoming Movies"))
              ],
            ),
          ),
        ));
  }
}
