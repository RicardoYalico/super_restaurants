import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantsService {

  Future<http.Response> getAllRestaurants() async{
    final response = await http.get(Uri.parse("https://probable-knowledgeable-zoo.glitch.me/restaurants"));
    return response;
  }
}