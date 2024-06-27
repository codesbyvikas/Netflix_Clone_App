import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_clone_app/data/api_data.dart';
import 'package:netflix_clone_app/data/api_services.dart';
import 'package:netflix_clone_app/data/payment_stuff.dart';
import 'package:netflix_clone_app/models/movie_details_model.dart';
import 'package:netflix_clone_app/models/movie_recommendation_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  static bool isSubscribed = false;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  ApiServices apiServices = ApiServices();
  late Future<MovieDetailsModel> movieDetails;
  late Future<MovieRecommendationsModel> movieRecommendations;
  static bool isSubscribed = false;
  late Payment payment;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
    payment = Payment();
  }

  void fetchInitialData() {
    movieDetails = apiServices.getMovieDetails(widget.movieId);
    movieRecommendations = apiServices.getMovieRecommedation(widget.movieId);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    payment.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<MovieDetailsModel>(
                future: movieDetails,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  } else if (snapshot.hasData) {
                    final movie = snapshot.data!;
                    final String genreText =
                        movie.genres.map((genre) => genre.name).join(',');

                    return Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "$imageUrl${movie.backdropPath}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back_ios),
                                    onPressed: () => Get.back(),
                                  ),
                                ],
                              ),
                            ),
                            if (!isSubscribed)
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            isSubscribed = true;
                                          });
                                          payment.openPayment();
                                        },
                                        child: const Text(
                                          "Subscribe👑 to Watch",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        "only @ Rs20",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    movie.releaseDate.year.toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    genreText,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                movie.overview,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              FutureBuilder<MovieRecommendationsModel>(
                future: movieRecommendations,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  } else if (snapshot.hasData) {
                    final recommendations = snapshot.data!;
                    return recommendations.results.isEmpty
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("More Like This"),
                              const SizedBox(
                                height: 15,
                              ),
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: recommendations.results.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 1.0 / 2,
                                ),
                                itemBuilder: (context, index) {
                                  final recommendationMovie =
                                      recommendations.results[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailsScreen(
                                            movieId: recommendationMovie.id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              "$imageUrl${recommendationMovie.posterPath}",
                                          height: 170,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          recommendationMovie.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
