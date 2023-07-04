import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/componant/constant.dart';
import 'package:movies_app/models/firebase_data_model.dart';
import 'package:movies_app/models/movie_details_similar_withArguments/MovieDetailsModel.dart';

class FirebaseFunction {
  static CollectionReference<FirebaseDataModel> createCollection() {
    return FirebaseFirestore.instance
        .collection(COLLECTION_REFRENCE)
        .withConverter<FirebaseDataModel>(fromFirestore: (snapshot, options) =>
        FirebaseDataModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),);

  }

  static void addMovieToWishList(FirebaseDataModel firebaseDataModel) {
    var collection = createCollection();
    var docRef = collection.doc('${firebaseDataModel.id}');
    docRef.set(firebaseDataModel);
  }

  static Stream<QuerySnapshot<FirebaseDataModel>> getDataFromFireStore () {
    var collection = createCollection();
    return  collection.snapshots();
  }


  static Future<void> removeFromWishlist (num id){
   return createCollection().doc('$id').delete();
  }
}

