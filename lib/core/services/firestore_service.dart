import 'package:alpha/core/repositories/remote/firestore_repository.dart';

class FirestoreService {
  final FirestoreRepository firestoreRepository;
  FirestoreService(this.firestoreRepository);

  Future getListSpendingType() async {
    firestoreRepository.getCollection('spending_category').then((value) {
      print(value);
    });
  }
}
