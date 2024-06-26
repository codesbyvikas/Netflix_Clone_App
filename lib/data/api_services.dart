import 'dart:convert';
import 'package:netflix_clone_app/data/api_data.dart';
import 'package:netflix_clone_app/models/movie_details_model.dart';
import 'package:netflix_clone_app/models/movie_recommendation_model.dart';
import 'package:netflix_clone_app/models/popular_movie_model.dart';
import 'package:netflix_clone_app/models/seach_movie_model.dart';
import 'package:netflix_clone_app/models/tv_series_model.dart';
import 'package:netflix_clone_app/models/upcoming_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org/3/";
const key = "?api_key=$apiKey";
late String endPoint;

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Success Upcoming Movies");
      print(response.body);
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Upcoming Movies");
  }

  Future<UpcomingMovieModel> getNowPlaying() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Success  Now Playing");
      print(response.body);
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Now Playing Movies");
  }

  Future<TvSeriesModel> getTvSeries() async {
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(" Success Top Rated Series");
      print(response.body);
      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Tv Series");
  }

  Future<SearchMovieModel> getSearchedMovie(String searchText) async {
    endPoint = "search/movie?query=$searchText";
    final url = "$baseUrl$endPoint";
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NDg3ZDEzZDY0Yzc2M2IzYzhlOTRiMmExYzYzYjZjZSIsIm5iZiI6MTcxOTIyMTM0OC41MTEzMTcsInN1YiI6IjY2NzkzYjQ0MmRiYzYzOWYxNmY0MTA5OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.F3ju6oVPjcDdtD3Td2L4XsJlHDdWFXYfbIbMAlF2yyI"
    });

    if (response.statusCode == 200) {
      print("Success Get Searched Movies");
      print(response.body);
      return SearchMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to Search Movie");
  }

  Future<PopularMovieModel> getPopularMOvies() async {
    endPoint = "movie/popular";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(" Success Popular Movies");
      print(response.body);
      return PopularMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Movie Recommandation");
  }

  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    endPoint = "movie/$movieId";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Details Fetched");
      print(response.body);
      return MovieDetailsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Movie Details");
  }

  Future<MovieRecommendationsModel> getMovieRecommedation(int movieId) async {
    endPoint = "movie/$movieId/recommendations";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("Recommendation Fetched");
      print(response.body);
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load Recommended Movies");
  }
}
