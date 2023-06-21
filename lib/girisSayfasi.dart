import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:not_uygulamasi/anaSayfa.dart';
import 'package:not_uygulamasi/kayitOl.dart';
import 'package:not_uygulamasi/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthServices authService = AuthServices();

  loginFonksiyon(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
            child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/girisLogo.jpg",
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87)),
                  labelText: "mail",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    labelText: "Şifre",
                    hintStyle: TextStyle(color: Colors.deepPurple[800]),
                    border: OutlineInputBorder()),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Colors.deepPurple[800])),
                onPressed: () async {
                  try {
                    await authService.signIn(
                        emailController.text, passwordController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnaSayfa(),
                        ));
                  } catch (error) {
                    if (error is FirebaseAuthException) {
                      if (error.code == 'invalid-email') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Geçersiz mail adresi girdiniz. ("örnek@gmail.com")',
                            style: TextStyle(fontSize: 20),
                          ),
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.red,
                        ));
                      }
                      if (error.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Kullanıcı Bulunamadı',
                            style: TextStyle(fontSize: 20),
                          ),
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.red,
                        ));
                      }
                      if (error.code == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Mail veya şifre yanlış',
                            style: TextStyle(fontSize: 20),
                          ),
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  }
                },
                child: Text("Giriş Yap"),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          Colors.deepPurple[800])),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => KayitOl()));
                  },
                  child: Text(
                    "Kayıt ol",
                  )),
            ],
          ),
        )));
  }
}
