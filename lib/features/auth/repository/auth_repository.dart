import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository{
final FirebaseAuth _auth;
final FirebaseFirestore _firestore;

AuthenticationRepository({ required FirebaseFirestore firestore,required FirebaseAuth auth}):
      _auth = auth,
_firestore = firestore;

CollectionReference get _user => _firestore.collection('users');



}