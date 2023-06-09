class Album {
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Album(
      this.id,
      this.title,
      this.url,
      this.thumbnailUrl
  );

  Album.fromJson(Map<String, dynamic> json):
    id = json['id'],
    title = json['title'],
    url = json['url'],
    thumbnailUrl = json['thumbnailUrl'];

    Map<String, dynamic> toJson() => {
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl
    };

  static List<Album> listFromJson(List<dynamic> json) {
    List<Album> albumList = [];
    int index = 0;
    for (var element in json) {
      if (index >= 4) {
        break;
      }
      albumList.add(Album.fromJson(element));
      index++;
    }
    return albumList;
  }
}