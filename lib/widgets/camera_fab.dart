import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_waste_screen.dart';

class CameraFab extends StatefulWidget {
  const CameraFab({ Key? key }) : super(key: key);

  @override
  State<CameraFab> createState() => _CameraFabState();
}

class _CameraFabState extends State<CameraFab> {
  File? image;
  final picker = ImagePicker();

  Future getImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    Navigator.push(context, MaterialPageRoute(builder: ((context) => NewPost(url: url))));
    return url;
  }


  @override
  Widget build(BuildContext context) {
    return Semantics(
      child: FloatingActionButton(
        child: const Icon(Icons.camera_alt_rounded),
        onPressed: () {
          getImage(context);
        }
      ),
      button: true,
      enabled: true,
      onTapHint: 'Select an image'
    );
  }
}