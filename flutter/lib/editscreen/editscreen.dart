import 'dart:math';
import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:lat/model/model.dart';
import 'package:http/http.dart' as http;

class editscreen extends StatelessWidget {
  final User user;
  editscreen({required this.user});

  var inputname = TextEditingController();
  var inputpass = TextEditingController();
  var inputemail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void PostData() async {
      String url = 'http://127.0.0.1:8000/api/user/${user.id}';

      String passWord = BCrypt.hashpw(
        inputpass.text,
        BCrypt.gensalt(),
      );

      var response = await http.put(Uri.parse(url), body: {
        'name': inputname.text,
        'password': passWord,
        'email': inputemail.text,
      });

      Navigator.pop(context);
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          TextField(
            controller: inputname,
            maxLength: 15,
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(
              hintText: 'Nama User',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            controller: inputpass,
            maxLength: 15,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            controller: inputemail,
            maxLength: 15,
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(
              hintText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: PostData,
            child: Text('Kirim data ke server'),
          )
        ],
      ),
    );
  }
}
