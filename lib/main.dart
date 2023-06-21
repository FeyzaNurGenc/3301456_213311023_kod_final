import 'package:flutter/material.dart';
import 'package:not_uygulamasi/veritabani/ogrSave.dart';
import 'package:not_uygulamasi/veritabani/ogrenciListesi.dart';
import 'package:not_uygulamasi/girisSayfasi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'anaSayfa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ogrenci',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.lightGreen[900],
          textTheme: TextTheme(),
        ),
        home: GirisSayfasi());
  }
}
