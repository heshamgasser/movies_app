/// adult : false
/// backdrop_path : null
/// belongs_to_collection : null
/// budget : 0
/// genres : [{"id":16,"name":"Animation"},{"id":10402,"name":"Music"}]
/// homepage : ""
/// id : 1144103
/// imdb_id : null
/// original_language : "ja"
/// original_title : "イッツ・ア・スモールワールド"
/// overview : "An animated music video directed by Ryo Hirano for the song It's a Small World by Japanese rock band OverTheDogs."
/// popularity : 0.0
/// poster_path : "/2j8eIY0amaol3rKpUm5XpgvLzij.jpg"
/// production_companies : []
/// production_countries : [{"iso_3166_1":"JP","name":"Japan"}]
/// release_date : "2012-03-10"
/// revenue : 0
/// runtime : 3
/// spoken_languages : [{"english_name":"Japanese","iso_639_1":"ja","name":"日本語"}]
/// status : "Released"
/// tagline : ""
/// title : "It's a Small World"
/// video : false
/// vote_average : 0.0
/// vote_count : 0

class NewReleaseMovies {
  NewReleaseMovies({
      this.adult, 
      this.backdropPath, 
      this.belongsToCollection, 
      this.budget, 
      this.genres, 
      this.homepage, 
      this.id, 
      this.imdbId, 
      this.originalLanguage, 
      this.originalTitle, 
      this.overview, 
      this.popularity, 
      this.posterPath, 
      this.productionCompanies, 
      this.productionCountries, 
      this.releaseDate, 
      this.revenue, 
      this.runtime, 
      this.spokenLanguages, 
      this.status, 
      this.tagline, 
      this.title, 
      this.video, 
      this.voteAverage, 
      this.voteCount,});

  NewReleaseMovies.fromJson(dynamic json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    belongsToCollection = json['belongs_to_collection'];
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres?.add(Genres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      productionCompanies = [];
      // json['production_companies'].forEach((v) {
      //   productionCompanies?.add(dynamic.fromJson(v));
      // });
    }
    if (json['production_countries'] != null) {
      productionCountries = [];
      json['production_countries'].forEach((v) {
        productionCountries?.add(ProductionCountries.fromJson(v));
      });
    }
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    if (json['spoken_languages'] != null) {
      spokenLanguages = [];
      json['spoken_languages'].forEach((v) {
        spokenLanguages?.add(SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
  bool? adult;
  dynamic backdropPath;
  dynamic belongsToCollection;
  num? budget;
  List<Genres>? genres;
  String? homepage;
  num? id;
  dynamic imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  num? popularity;
  String? posterPath;
  List<dynamic>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  String? releaseDate;
  num? revenue;
  num? runtime;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  num? voteAverage;
  num? voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['backdrop_path'] = backdropPath;
    map['belongs_to_collection'] = belongsToCollection;
    map['budget'] = budget;
    if (genres != null) {
      map['genres'] = genres?.map((v) => v.toJson()).toList();
    }
    map['homepage'] = homepage;
    map['id'] = id;
    map['imdb_id'] = imdbId;
    map['original_language'] = originalLanguage;
    map['original_title'] = originalTitle;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    if (productionCompanies != null) {
      map['production_companies'] = productionCompanies?.map((v) => v.toJson()).toList();
    }
    if (productionCountries != null) {
      map['production_countries'] = productionCountries?.map((v) => v.toJson()).toList();
    }
    map['release_date'] = releaseDate;
    map['revenue'] = revenue;
    map['runtime'] = runtime;
    if (spokenLanguages != null) {
      map['spoken_languages'] = spokenLanguages?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['tagline'] = tagline;
    map['title'] = title;
    map['video'] = video;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }

}

/// english_name : "Japanese"
/// iso_639_1 : "ja"
/// name : "日本語"

class SpokenLanguages {
  SpokenLanguages({
      this.englishName, 
      this.iso6391, 
      this.name,});

  SpokenLanguages.fromJson(dynamic json) {
    englishName = json['english_name'];
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }
  String? englishName;
  String? iso6391;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['english_name'] = englishName;
    map['iso_639_1'] = iso6391;
    map['name'] = name;
    return map;
  }

}

/// iso_3166_1 : "JP"
/// name : "Japan"

class ProductionCountries {
  ProductionCountries({
      this.iso31661, 
      this.name,});

  ProductionCountries.fromJson(dynamic json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }
  String? iso31661;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iso_3166_1'] = iso31661;
    map['name'] = name;
    return map;
  }

}

/// id : 16
/// name : "Animation"

class Genres {
  Genres({
      this.id, 
      this.name,});

  Genres.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}