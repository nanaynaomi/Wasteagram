import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/screens/waste_detail_screen.dart';
import 'package:wasteagram/widgets/camera_fab.dart';

class WasteListScreen extends StatefulWidget {
  const WasteListScreen({Key? key}) : super(key: key);

  @override
  _WasteListScreenState createState() => _WasteListScreenState();
}

class _WasteListScreenState extends State<WasteListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wasteagram')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data!.docs[index];
                      return Semantics (
                        child: ListTile( 
                          title: Text(DateFormat('EEEE, MMMM d, y').format(DateTime.fromMillisecondsSinceEpoch(post['date']))),
                          trailing: Text(post['quantity'].toString()),
                          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => WasteDetailScreen(post: post)));}
                        ),
                        onTapHint: "View post details",
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
        }),
      floatingActionButton: const CameraFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  
}
