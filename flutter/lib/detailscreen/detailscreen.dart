import 'package:flutter/material.dart';
import 'package:lat/model/model.dart';

class detailscreen extends StatelessWidget {
  final User user;

  detailscreen({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail user'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Text('Name: ${user.name}'),
          Text('Name: ${user.email}'),
        ],
      ),
    );
  }
}
