class FirebaseDataModel {
  num id;
  String title;
  String posterPath;
  String releaseDate;
  num voteCount;
  // bool selected;








  FirebaseDataModel({required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.voteCount,
    // required this.selected
  });

  FirebaseDataModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    title: json['title'],
    posterPath: json['posterPath'],
    releaseDate: json['releaseDate'],
    voteCount: json['voteCount'],
    // selected: json['selected'],
  );

  Map <String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'voteCount': voteCount,
      // 'selected': selected,
    };
  }

}
