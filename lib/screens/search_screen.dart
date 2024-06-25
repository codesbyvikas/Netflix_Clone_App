import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_clone_app/data/api_data.dart';
import 'package:netflix_clone_app/data/api_services.dart';
import 'package:netflix_clone_app/models/movie_recommendation_model.dart';
import 'package:netflix_clone_app/models/seach_movie_model.dart';
import 'package:netflix_clone_app/screens/movie_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SearchMovieModel? searchMovieModel;
  bool _isLoading = false;
  late Future<MovieRecommendationModel> recommendedMovies;

  @override
  void initState() {
    recommendedMovies = apiServices.getRecommendedMOvies();
    super.initState();
  }

  void search(String query) {
    setState(() {
      _isLoading = true;
    });
    apiServices.getSearchedMovie(query).then((results) {
      setState(() {
        searchMovieModel = results;
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CupertinoSearchTextField(
                controller: searchController,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  search(value);
                },
              ),
              const SizedBox(height: 20),
              searchController.text.isEmpty
                  ? FutureBuilder(
                      future: recommendedMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!.results;

                          return Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Top Searches",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 15),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => Get.to(MovieDetailsScreen(
                                            movieId: data[index].id)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 150,
                                                width: 100, // Adjust as needed
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Image.network(
                                                  "$imageUrl${data[index].posterPath}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  data[index].title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      })
                  : _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFFF9000),
                          ),
                        )
                      : searchMovieModel == null
                          ? const SizedBox.shrink()
                          : Expanded(
                              child: GridView.builder(
                                itemCount: searchMovieModel!.results.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 1.0 / 2,
                                ),
                                itemBuilder: (context, index) {
                                  final movie =
                                      searchMovieModel!.results[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      movie.backdropPath == null
                                          ? Image.asset("assets/netflix.png")
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  "$imageUrl${movie.backdropPath}",
                                              height: 170,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                      const SizedBox(height: 5),
                                      Text(
                                        movie.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
            ],
          ),
        ),
      ),
    );
  }
}
