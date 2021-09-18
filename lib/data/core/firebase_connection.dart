import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConnection {

  FirebaseFirestore getFirestore(){
    return FirebaseFirestore.instance;
  }

}