// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, unused_label, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lat/detailscreen/detailscreen.dart';
import 'model/model.dart';
import 'addscreen/addscreen.dart';
import 'editscreen/editscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data = [];
  Future getData() async {
    var Myresponse = await http.get(Uri.parse(
      'http://127.0.0.1:8000/api/user',
    ));

    if (Myresponse.statusCode == 200) {
      var dataResponse = jsonDecode(Myresponse.body)['data'] as List;
      setState(() {
        data = dataResponse;
      });
    } else {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addscreen(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, Snapshoot) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    final DataUser = data[index];
                    return ListTile(
                      title: Text(
                        DataUser['name'],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => detailscreen(
                                      user: User(
                                        id: DataUser['id'],
                                        name: DataUser['name'],
                                        email: DataUser['email'],
                                      ),
                                    ),
                                  ));
                            },
                            icon: Icon(Icons.details_rounded),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            onPressed: () async {
                              var response = await http.delete(
                                Uri.parse(
                                    'http://127.0.0.1:8000/api/user/${DataUser['id']}'),
                              );
                            },
                            icon: Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => editscreen(
                                      user: User(
                                        id: DataUser['id'],
                                        name: DataUser['name'],
                                        email: DataUser['email'],
                                      ),
                                    ),
                                  ));
                            },
                            icon: Icon(Icons.pending),
                          ),
                        ],
                      ),
                    );
                  }));
            }),
      ),
    );
  }
}
