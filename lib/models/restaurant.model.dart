
class RestaurantsModel{
  int id;
  String title;
  String poster;
  bool ?isFavorite;

  RestaurantsModel(this.id, this.title, this.poster, this.isFavorite);

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'title': title,
      'poster': poster,
    };
  }
}