import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:not_uygulamasi/veritabani/ogrenci.dart';
import 'package:not_uygulamasi/veritabani/vtYardimcisi.dart';
import 'package:not_uygulamasi/model.dart';

class OgrenciListesi extends StatefulWidget {
  @override
  _OgrenciListesiState createState() => _OgrenciListesiState();
}

class _OgrenciListesiState extends State<OgrenciListesi> {
  final VeritabaniYardimcisi _veritabaniYardimcisi = VeritabaniYardimcisi();
  List<Map<String, dynamic>> ogrenci = [];
  final url = Uri.parse('https://reqres.in/api/users');
  var ogrResult;

  Future callStudent() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var result = welcomeFromJson(response.body);
      print(result.data[0].avatar);
      if (mounted) {
        setState(() {
          ogrResult = result;
        });
        return result;
      } else {
        print(response.statusCode);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    sqlogrenciler();
    callStudent();
  }

  Future<void> sqlogrenciler() async {
    ogrenci = await _veritabaniYardimcisi.ogrenciListesi();
    setState(() {});
  }

  Future<void> _ogrenciSil(int ogrenciId) async {
    await _veritabaniYardimcisi.ogrenciSil(ogrenciId);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Öğrenci silindi.'),
    ));

    await sqlogrenciler(); // Öğrenci listesini yenile
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          title: const Text(
            'Öğrenci Listesi',
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: ogrenci.length,
          itemBuilder: (BuildContext context, int index) {
            final ogrenciIndex = ogrenci[index];

            final ogrenciId = ogrenciIndex['id'] as int;

            if (ogrResult == null) {
              // API çağrısı tamamlanmadıysa veya hata oluştuysa yükleme göster
              return CircularProgressIndicator();
            } else {
              return Card(
                color: Colors.deepPurple[400],
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(ogrResult.data[ogrenciId].avatar),
                  ),
                  title: Text(
                    'İd: ${ogrenciIndex['id']} - ${ogrenciIndex['ad']} ${ogrenciIndex['soyad']}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Not: ${ogrenciIndex['notlar']}',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.delete),
                    onPressed: () => _ogrenciSil(ogrenciId),
                  ),
                ),
              );
            }
          },
        ));
  }
}
