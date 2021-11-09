import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/models/Quiz.dart';

// ! The instance of DatabaseService is created in the class auth.dart when user is registered
class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // ~ collection reference ( a reference to a particular collection on our firestore database )
  // ~ when we want to read or write from/into that collection, we will use this reference
  // ! If by the time this line is executed and 'brews' collection does not exist in Firebase, it will create it for us
  final CollectionReference quizCollection =
      FirebaseFirestore.instance.collection('quizes');

  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('user_data');

  // ~ it's return value is Future, because it's async function
  // ! We call this function when user registers in auth.dart
  // ! This function creates/updates quiz entry in the DB
  Future updateQuizData(
      String quizTitle, String quizOwner, String description) async {
    // ~ Get the document based on the UID of the user
    // ~ If document does not exist yet, then Firebase will create the document with that UID. Thereby linking the Firestore document for that user with the Firebase User
    // ~ We pass the data through map (key-value pairs) to set method
    return await quizCollection.doc(uid).set({
      'quizTitle': quizTitle,
      'quizOwner': quizOwner,
      'description': description,
    });
  }

  // ~ it's return value is Future, because it's async function
  // ! We call this function when user registers in auth.dart
  Future updateUserData(
      String username, String email, String avatar, int level) async {
    // ~ Get the document based on the UID of the user
    // ~ If document does not exist yet, then Firebase will create the document with that UID. Thereby linking the Firestore document for that user with the Firebase User
    // ~ We pass the data through map (key-value pairs) to set method
    // ! The unique key which we will use to access data is UID ( User ID )
    return await userDataCollection.doc(uid).set({
      'username': username,
      'email': email,
      'avatar': avatar,
      'level': level,
    });
  }

  // ~ Quiz list from snapshot
  List<Quiz> _quizListFromSnapshot(QuerySnapshot snapshot) {
    // ~ Return the brews from the database as list of objects Brew that we have created in models/Quiz.dart
    return snapshot.docs.map((doc) {
      return Quiz(
          // ~ ?? means if empty return ''
          quizTitle: doc.get('quizTitle') ?? '',
          quizOwner: doc.get('quizOwner') ?? '',
          description: doc.get('description') ?? '');
    }).toList();
  }

  // ~ userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    // ~ Convert snapshot to UserData class that we have created in models/AppUser.dart
    return UserData(
        uid: uid,
        username: snapshot['username'],
        email: snapshot['email'],
        avatar: snapshot['avatar'],
        level: snapshot['level']);
  }

  // ~ Create new stream which will notify us about any changes in the database
  // Stream<QuerySnapshot> get brews{
  Stream<List<Quiz>> get quizes {
    // ! This now returns us a stream which we will use in Home screen
    return quizCollection.snapshots().map(_quizListFromSnapshot);
  }

  // ~ We create a new stream inside the database service class, which will be linked up to
  // ~ my firestore document. We will take UID and setup a stream with that document
  // ~ so whoever logins, it will be new stream. Only their document in the firestore database
  // ! get user doc stream
  // Stream<DocumentSnapshot> get userData{
  Stream<UserData> get userData {
    // ~ we return the stream of UserData
    return userDataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
