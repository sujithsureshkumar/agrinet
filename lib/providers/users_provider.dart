import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AgriNet/services/firebase_api.dart';
import 'package:AgriNet/models/service.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  final _usersSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  int documentLimit = 15;
  bool _hasNext = true;
  bool _isFetchingUsers = false;

  List<String> wishlist=[];


  Future<void> fetchFirebaseWishlist(String uid) async {
    DocumentSnapshot farmUserSnapShot =
    await FirebaseFirestore.instance
        .collection('farmUser')
        .doc(uid)
        .get();
    wishlist= List.from(farmUserSnapShot.get("wishlist"));
  }


  String get errorMessage => _errorMessage;

  bool get hasNext => _hasNext;

  List<Service> get serviceList => _usersSnapshot.map((snap) {
    // final user = snap.data();

      return Service(
        isLiked:wishlist.contains(snap.get('docid'))?true:false,
        docid:snap.get('docid'),
        name: snap.get('name'),
        imageUrl: snap.get('imageUrl'),
        price:snap.get('price'),
        likeCount:snap.get('likecount'),
      );

  }).toList();

  Future fetchNextUsers() async {
    if (_isFetchingUsers) return;

    _errorMessage = '';
    _isFetchingUsers = true;

    try {
      final snap = await FirebaseApi.getUsers(
        documentLimit,
        startAfter: _usersSnapshot.isNotEmpty ? _usersSnapshot.last : null,
      );
      _usersSnapshot.addAll(snap.docs);

      if (snap.docs.length < documentLimit) _hasNext = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    _isFetchingUsers = false;
  }
}