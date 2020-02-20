import './models/joke.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Joke> fetchAlbum() async {
  final response = await http.get('https://api.chucknorris.io/jokes/random');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Joke.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}
