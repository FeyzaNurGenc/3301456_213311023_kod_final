import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String mail, sifre) async {
    var user =
        await auth.signInWithEmailAndPassword(email: mail, password: sifre);
    return user.user;
  }

  signOut() async {
    return await auth.signOut();
  }

  Future<User?> createPerson(String name, String mail, String sifre) async {
    var user =
        await auth.createUserWithEmailAndPassword(email: mail, password: sifre);

    await firestore.collection('Person').add({
      'mail': mail,
      'şifre': sifre,
    });

    return user.user;
  }
}
