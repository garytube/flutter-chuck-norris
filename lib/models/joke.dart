
/// Joke Model
class Joke {
  final String id;
  final String joke;

  Joke({this.id, this.joke});

  factory Joke.fromJson(Map json) {
    return Joke(
      id: json["id"],
      joke: json["value"],
    );
  }
}
