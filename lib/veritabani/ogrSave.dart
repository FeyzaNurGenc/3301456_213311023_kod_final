import 'package:flutter/material.dart';
import 'package:not_uygulamasi/veritabani/vtYardimcisi.dart';
import 'package:not_uygulamasi/veritabani/ogrenci.dart';

class OgrenciKaydetmeSayfasi extends StatefulWidget {
  @override
  _OgrenciKaydetmeSayfasiState createState() => _OgrenciKaydetmeSayfasiState();
}

class _OgrenciKaydetmeSayfasiState extends State<OgrenciKaydetmeSayfasi> {
  final VeritabaniYardimcisi _veritabaniYardimcisi = VeritabaniYardimcisi();
  final TextEditingController _adController = TextEditingController();
  final TextEditingController _soyadController = TextEditingController();
  final TextEditingController _notController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  Future<void> ogrenciKaydet() async {
    String ad = _adController.text;
    String soyad = _soyadController.text;
    int notlar = int.parse(_notController.text);
    int id = int.parse(_idController.text);

    Ogrenci ogrenci = Ogrenci(id: id, ad: ad, soyad: soyad, notlar: notlar);
    await _veritabaniYardimcisi.ogrenciEkle(ogrenci);
    _adController.clear();
    _soyadController.clear();
    _notController.clear();
    _idController.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Öğrenci bilgileri kaydedildi.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: Text('Öğrenci Kaydetme'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/girisLogo.jpg",
              ),
              Center(
                child: Container(
                    width: 400,
                    height: 400,
                    child: Column(
                      children: [
                        TextField(
                          controller: _adController,
                          decoration: InputDecoration(labelText: 'Ad'),
                        ),
                        TextField(
                          controller: _soyadController,
                          decoration: InputDecoration(labelText: 'Soyad'),
                        ),
                        TextField(
                          controller: _notController,
                          decoration: InputDecoration(labelText: 'Not'),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: _idController,
                          decoration: InputDecoration(labelText: 'id'),
                          keyboardType: TextInputType.number,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color?>(
                                      Colors.deepPurple[800])),
                          onPressed: ogrenciKaydet,
                          child: Text('Kaydet'),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
