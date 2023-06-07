import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dani/core/constants.dart';
import 'package:dani/core/repositories/remote/firestore_repository.dart';
import 'package:dani/core/services/local_service.dart';

import '../../features/login/domains/models/user.dart';

class FirestoreService {
  final FirestoreRepository firestoreRepository;
  final LocalService localService;

  FirestoreService(
    this.firestoreRepository,
    this.localService,
  );

  Future<QuerySnapshot> getCollection(String collectionPath) async {
    return await firestoreRepository.getCollection(collectionPath);
  }

  Future<bool> createDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    User? user = await localService.getUser();
    if (user == null) return false;
    Map<String, dynamic> payload = data;
    payload[Constants.userEmail] = user.email;
    return firestoreRepository.createDocument(
      collectionPath: collectionPath,
      data: payload,
    );
  }
}
