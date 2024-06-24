import 'dart:convert';
import 'dart:math';

import 'package:netflix_clone_app/data/api_data.dart';
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
}
