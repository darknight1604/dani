import 'package:alpha/core/repositories/remote/firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirestoreRepository firestoreRepository;
  FirestoreService(this.firestoreRepository);

  Future getListSpendingType() async {
    firestoreRepository
        .getCollection('spending_category')
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);
      });
    });
  }
}
