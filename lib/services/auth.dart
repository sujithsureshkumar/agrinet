import 'package:AgriNet/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/pages/profile_selection.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Users> get user {
    return _auth.authStateChanges()
    //.map((User user) => _userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      _firestore
          .collection('users')
          .doc(_auth.currentUser.uid)
          .get()
          .then((value) => user.updateDisplayName(value['name']));

      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


// register with email and password
  Future createAccount(String name, String email, String password) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      //print(_userFromFirebaseUser(user));
      Users users =_userFromFirebaseUser(user);
      print("Account created Successfully");

      result.user.updateDisplayName(name);


      await _firestore.collection('users').doc(users.uid).set({
        "name": name,
        "email": email,
        "status": "Unavailable",
        "uid": users.uid,
      });
      await _firestore.collection('search').doc('searchdoc').update({
        'email': FieldValue.arrayUnion([email])
      });

      await _firestore.collection('Users').doc(users.uid).set({
        "uid": users.uid,
        "farmer":false,
        "serviceProvider":false,
        "labour":false,
       "spFormFill":true
      });

      await _firestore.collection('farmUser').doc(user.uid).set({
        'wishlist': []
      });

      await _firestore.collection('farmUser').doc(users.uid)
        .collection("allfarms")
        .doc("allFarm")
        .set({
    'allFarm': []
    });

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}