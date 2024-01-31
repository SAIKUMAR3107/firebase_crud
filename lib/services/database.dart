import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/model/details.dart';

class FirebaseMethods{

  //Add user details to Firebase
  Future addUserDetails(UserDetails userDetails,String id) async{
    return FirebaseFirestore.instance.collection("UserInfo").doc(id).set(userDetails.toMap());
  }

  // Get user details from firebase
  Future<Stream<QuerySnapshot>> getUserDetails() async{
    return FirebaseFirestore.instance.collection("UserInfo").snapshots();
  }

  // Update user Details in firebase
  Future updateUserDetails(UserDetails userDetails,String id) async{
    return FirebaseFirestore.instance.collection("UserInfo").doc(id).update(userDetails.toMap());
  }

  Future deleteUserDetails(String id) async{
    return FirebaseFirestore.instance.collection("UserInfo").doc(id).delete();
  }
}