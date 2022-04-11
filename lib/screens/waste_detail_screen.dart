import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class WasteDetailScreen extends StatelessWidget {
  DocumentSnapshot post;
  WasteDetailScreen({ Key? key, required this.post }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Semantics (
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)
          ),
          button: true,
          enabled: true,
          onTapHint: "go back to previous page",
        ),
        title: const Text('Wasteagram'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(DateFormat('EEE, MMM d, y').format(DateTime.fromMillisecondsSinceEpoch(post['date'])), style: const TextStyle(fontSize: 26)),
          Semantics (
            child: Container(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
              width: MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.network(post['url'], fit: BoxFit.contain),
            ),
            image: true,
            label: "Image that you uploaded",
          ),
          Text("${post['quantity']} items", style: const TextStyle(fontSize: 32)),
          Text("Location: (${post['latitude'].toString()}, ${post['longitude'].toString()})")
        ]
      )
    );
  }
}