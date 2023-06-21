import 'package:flutter/material.dart';
import 'package:not_uygulamasi/veritabani/ogrSave.dart';
import 'package:not_uygulamasi/veritabani/ogrenciListesi.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Not Sistemi"),
          backgroundColor: Colors.deepPurple[800],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/anaSayfaLogo.jpg",
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(400, 50)),
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Colors.deepPurple[800])),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OgrenciKaydetmeSayfasi()));
                    },
                    child: Text("Öğrenci Ekle")),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(400, 50)),
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Colors.deepPurple[800])),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OgrenciListesi()));
                    },
                    child: Text("Öğrenci Listesi")),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ));
  }
}
