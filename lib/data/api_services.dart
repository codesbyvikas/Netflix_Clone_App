import 'dart:convert';
import 'package:netflix_clone_app/data/api_data.dart';
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
    final respose = await http.get(Uri.parse(url));

    if (respose.statusCode == 200) {
      print("Success");
      print(respose.body);
      return UpcomingMovieModel.fromJson(jsonDecode(respose.body));
    }
    throw Exception("Failec to load Upcoming Movies");
  }

   Future<UpcomingMovieModel> getNowPlaying() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";
    final respose = await http.get(Uri.parse(url));

    if (respose.statusCode == 200) {
      print("Success");
      print(respose.body);
      return UpcomingMovieModel.fromJson(jsonDecode(respose.body));
    }
    throw Exception("Failec to load Now Playing Movies");
  }

  Future<TvSeriesModel> getTvSeries() async {
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";
    final respose = await http.get(Uri.parse(url));

    if (respose.statusCode == 200) {
      print("Success");
      print(respose.body);
      return TvSeriesModel.fromJson(jsonDecode(respose.body));
    }
    throw Exception("Failec to load Tv Series Carousel");
  }

}
