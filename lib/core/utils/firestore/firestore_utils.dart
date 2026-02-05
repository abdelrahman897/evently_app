import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/model/event_data_model.dart';

abstract class FirestoreUtils {
  static CollectionReference<EventDataModel> getCollectionRef() {
    return FirebaseFirestore.instance
        .collection(EventDataModel.collectionName)
        .withConverter<EventDataModel>(
      fromFirestore:
          (snapshot, _) => EventDataModel.fromFireStore(snapshot.data()!),
      toFirestore: (value, _) => value.toFireStore(),
    );
  }

  static Future<bool> addEvent(EventDataModel event) async {
    try{
      var collectionRef = getCollectionRef();
      var docRef = collectionRef.doc();
      event.eventId = docRef.id;
      docRef.set(event);
      return true;
    }catch(error){
      return false;
    }
  }

  static Future<List<EventDataModel>> getDataFromFirestore() async {
    List<EventDataModel> eventList = [];
    var collectionRef = getCollectionRef();
    var data = await collectionRef.get();
    eventList =
        data.docs.map((element) {
          return element.data();
        }).toList();
    return eventList;
  }

static Stream<QuerySnapshot<EventDataModel>> getStreamAllDataFromFirestore(){
  var collectionRef = getCollectionRef();
  return collectionRef.snapshots();
}

  static Stream<QuerySnapshot<EventDataModel>> getStreamDataFromFirestore(
      String categoryId,) {
    var collectionRef = getCollectionRef().where(
      "eventCategoryId",
      isEqualTo: categoryId,
    );
    return collectionRef.snapshots();
  }

  static Stream<QuerySnapshot<EventDataModel>> getStreamFavouriteDataFromFirestore() {
    var collectionRef = getCollectionRef().where(
      "isFavourite",
      isEqualTo: true,
    );
    return collectionRef.snapshots();
  }

  static Future<bool> updateEvent(EventDataModel event) async {
    try{
      var collectionRef = getCollectionRef();
      var docRef = collectionRef.doc(event.eventId);
      await docRef.update(event.toFireStore());
      return true;
    }catch(error){
      return false;
    }
  }

  static Future<bool> deleteEvent(EventDataModel event) async {
    try{
      var collectionRef = getCollectionRef();
      var docRef = collectionRef.doc(event.eventId);
      await docRef.delete();
      return true;
    }catch(error){
      return false;
    }
  }

  static Future<void> updateFavouriteStatus(EventDataModel event)async{
    var collectionRef = getCollectionRef();
    await collectionRef.doc(event.eventId).update({
      'isFavourite': !event.isFavourite,
    });
  }


}
