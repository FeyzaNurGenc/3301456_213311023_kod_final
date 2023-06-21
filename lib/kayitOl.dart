import 'package:flutter/material.dart';
import 'package:not_uygulamasi/anaSayfa.dart';
import 'package:not_uygulamasi/girisSayfasi.dart';
import 'package:not_uygulamasi/main.dart';
import 'package:not_uygulamasi/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class KayitOl extends StatefulWidget {
  @override
  _KayitOlState createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();

  AuthServices authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[800],
        ),
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
                controller: nameController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    labelText: "Kullanıcı Adı",
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Kullanıcı Adınızı Giriniz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    labelText: "Mail",
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Mail Giriniz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    labelText: "Şifre",
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Şifrenizi Giriniz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: passwordAgainController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    labelText: "Şifre",
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Şifrenizi Tekrar Giriniz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          Colors.deepPurple[800])),
                  onPressed: () {
                    if (passwordController.text ==
                        passwordAgainController.text) {
                      authService
                          .createPerson(nameController.text,
                              emailController.text, passwordController.text)
                          .then((value) {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GirisSayfasi()));
                      }).catchError((error) {
                        if (error.toString().contains('email-already-in-use')) {
                          Duration _snackBarDisplayDuration =
                              Duration(seconds: 3);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: _snackBarDisplayDuration,
                            content: Text('Böyle bir kullanıcı zaten var'),
                          ));
                        }
                      });
                    } else
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Parola eşleşmiyor.'),
                      ));
                  },
                  child: Text(
                    "Kayıt ol",
                  )),
            ],
          ),
        )));
  }
}
