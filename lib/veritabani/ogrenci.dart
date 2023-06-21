class Ogrenci {
  int id;
  String ad;
  String soyad;
  int notlar;

  Ogrenci(
      {required this.id,
      required this.ad,
      required this.soyad,
      required this.notlar});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ad': ad,
      'soyad': soyad,
      'notlar': notlar,
    };
  }

  static Ogrenci fromMap(Map<String, dynamic> map) {
    return Ogrenci(
      id: map['id'],
      ad: map['ad'],
      soyad: map['soyad'],
      notlar: map['notlar'],
    );
  }
}
