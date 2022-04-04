import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  static Future<QuerySnapshot> getUsers(
      int limit, {
        DocumentSnapshot startAfter,
      }) async {
    final refUsers = FirebaseFirestore.instance
        .collection('users')
        .limit(limit);

    if (startAfter == null) {
      return refUsers.get();
    } else {
      return refUsers.startAfterDocument(startAfter).get();
    }
  }
}