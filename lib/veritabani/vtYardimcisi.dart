import 'dart:io';
import 'package:flutter/services.dart';
import 'package:not_uygulamasi/veritabani/ogrenci.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class VeritabaniYardimcisi {
  static final VeritabaniYardimcisi _singleton =
      VeritabaniYardimcisi._internal();

  factory VeritabaniYardimcisi() {
    return _singleton;
  }

  VeritabaniYardimcisi._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = appDocumentsDirectory.path;

    final String path = join(dbPath, 'okul_not.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE ogrenci_notlari(id INTEGER, ad TEXT, soyad TEXT, notlar INTEGER)');
      },
    );
  }

  Future<List<Map<String, dynamic>>> ogrenciListesi() async {
    final db = await database;
    return db.query('ogrenci_notlari');
  }

  Future<void> ogrenciEkle(Ogrenci ogrenci) async {
    final Database db = await database;
    final result = await db.insert('ogrenci_notlari', ogrenci.toMap());
    result;
  }

  Future<void> ogrenciGuncelle(Ogrenci ogrenci) async {
    final Database db = await database;
    await db.update(
      'ogrenci_notlari',
      ogrenci.toMap(),
      where: 'id = ?',
      whereArgs: [ogrenci.id],
    );
  }

  Future<void> ogrenciSil(int ogrenciId) async {
    final Database db = await database;
    await db.delete(
      'ogrenci_notlari',
      where: 'id = ?',
      whereArgs: [ogrenciId],
    );
  }
}
