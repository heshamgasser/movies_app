import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/componant/constant.dart';
import 'package:movies_app/models/movie_details_similar_withArguments/MovieDetailsModel.dart';

class FirebaseFunction {
 static CollectionReference<MovieDetailsModel> createCollection() {
    return FirebaseFirestore.instance
        .collection(COLLECTION_REFRENCE)
        .withConverter<MovieDetailsModel>(
          fromFirestore: (snapshot, options) =>
              MovieDetailsModel.fromJson(snapshot.data()),
          toFirestore: (value, options) => value.toJson(),
        );
  }

 static void addMovieToWishList (MovieDetailsModel movieDetailsModel){
    var collection = createCollection();
    var docRef = collection.doc('${movieDetailsModel.id}');
    docRef.set(movieDetailsModel);
  }


}

