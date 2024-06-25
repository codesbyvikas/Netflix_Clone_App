import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_clone_app/data/api_services.dart';
import 'package:netflix_clone_app/models/tv_series_model.dart';
import 'package:netflix_clone_app/models/upcoming_model.dart';
import 'package:netflix_clone_app/screens/profile_screen.dart';
import 'package:netflix_clone_app/screens/search_screen.dart';
import 'package:netflix_clone_app/widgets/custom_carousel.dart';
import 'package:netflix_clone_app/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upComingMovies;
  late Future<UpcomingMovieModel> nowPlayingMovies;
  late Future<TvSeriesModel> topRatedTvSeries;

  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    upComingMovies = apiServices.getUpcomingMovies();
    nowPlayingMovies = apiServices.getNowPlaying();
    topRatedTvSeries = apiServices.getTvSeries();
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
                onTap: () {
                  Get.to(SearchScreen());
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Center(
                child: Container(
                  child: IconButton(
                    onPressed: () {
                      Get.to(ProfileScreen());
                    },
                    icon: Icon(Icons.person),
                    iconSize: 12,
                  ),
                  color: Colors.blue,
                  height: 27,
                  width: 27,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                FutureBuilder(
                    future: topRatedTvSeries,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        return CustomCarouselWidget(data: snapshot.data!);
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 220,
                  child: MovieCard(
                      future: nowPlayingMovies,
                      headLineText: "Now Playing Movies"),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 220,
                  child: MovieCard(
                      future: upComingMovies, headLineText: "Upcoming Movies"),
                ),
              ],
            ),
          ),
        ));
  }
}
