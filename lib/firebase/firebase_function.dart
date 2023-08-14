import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../models/user_model.dart';


class FirebaseFunctions {

  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
      toFirestore: (task, options) => task.toJson(),
    );
  }

  static Future<void> addTaskToFirestore(TaskModel task) {
    var collections = getTasksCollection();
    var docRef = collections.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasksFromFireStore(DateTime date) {
    var collection = getTasksCollection();
    return collection.where("userID",isEqualTo: FirebaseAuth.instance.currentUser?.uid)
    .where("date", isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch).
   // orderBy("dateOfTime", descending: true)
        snapshots();
  }
  // static Stream<QuerySnapshot<TaskModel>> getTasksFromFirestore(DateTime date) {
  //   var collection = getTasksCollection();
  //   return collection
  //       .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where("date",
  //       isEqualTo: DateUtils
  //           .dateOnly(date)
  //           .millisecondsSinceEpoch)
  //       .orderBy("time", descending: true)
  //       .snapshots();
  // }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

 static Future<void>updetIsCheack(TaskModel task)async {
    return getTasksCollection().doc(task.id).update({"status" : !task.status});
 }


  static Future<void> updateTask(TaskModel task) {
    return getTasksCollection().doc(task.id).update(task.toJson());
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.COLLECTIN_NAME)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (user, options) => user.toJson(),
    );
  }

  static Future<void> addUserToFirestore(UserModel user) {
    var collections = getUsersCollection();
    var docRef = collections.doc(user.id);
   // task.id = docRef.id;
    return docRef.set(user);
  }

  static void creatAccount(String name,String emailAddress ,String password,int age,Function created) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      UserModel user=UserModel(id:credential.user!.uid ,name: name, email: emailAddress, age: age);
      addUserToFirestore(user).then((value) => created());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.message);
      } else if (e.code == 'email-already-in-use') {
        print(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  static void logIn(String emailAddress, String password, Function onError,Function loged)async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      loged();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError(e.message);
      } else if (e.code == 'wrong-password') {
        onError(e.message);
      }
    }
  }

   static Future<UserModel?> readUser(String id) async {
    DocumentSnapshot<UserModel> userSnap= await getUsersCollection().doc(id).get();
  return userSnap.data();
}

}

