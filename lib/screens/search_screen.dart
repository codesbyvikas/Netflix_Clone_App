import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone_app/data/api_data.dart';
import 'package:netflix_clone_app/data/api_services.dart';
import 'package:netflix_clone_app/models/seach_movie_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SearchMovieModel? searchMovieModel;

  void search(String query) {
    apiServices.getSearchedMovie(query).then((results) {
      setState(() {
        searchMovieModel = results;
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
              searchMovieModel == null
                  ? const SizedBox.shrink()
                  : searchMovieModel!.results.isEmpty
                      ? const Text(
                          "No results found",
                          style: TextStyle(color: Colors.white),
                        )
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
                              final movie = searchMovieModel!.results[index];
                              return Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start, // Marked change
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        "${imageUrl}${movie.backdropPath}",
                                    height: 170,
                                    width: double.infinity, // Marked change
                                    fit: BoxFit.cover, // Marked change
                                  ),
                                  const SizedBox(height: 5), // Marked change
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
