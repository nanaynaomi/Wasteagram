import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class WastedFoodForm extends StatefulWidget {
  final String? url;

  const WastedFoodForm({ Key? key, required this.url}) : super(key: key);
  
  @override
  State<WastedFoodForm> createState() => _WastedFoodFormState();
}

class _WastedFoodFormState extends State<WastedFoodForm> {
  
  final formKey = GlobalKey<FormState>();
  FoodWastePost post = FoodWastePost();
  LocationData? locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: formContent(context)
    );
  }


  Widget formContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          photoContainer(context),
          quantityField(),
          uploadButton(context)
        ]
      ),
    );
  }


  Widget photoContainer(BuildContext context) {
    return Semantics (
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Image.network(widget.url.toString(), fit: BoxFit.contain)
      ),
      image: true,
      label: "Image that you uploaded"
    );
  }


  Widget quantityField() {
    Locale locale = Localizations.localeOf(context);
    locale.languageCode;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
      child: TextFormField(
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Number of Wasted Items'
          ),
          onSaved: (value) {
            post.quantity = int.tryParse(value.toString());
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a quantity';
            }
            else {
              return null;
            }
          },
        ),
    );
  }


  Widget uploadButton(BuildContext context) {
    return Semantics (
      child: FloatingActionButton.large(
        child: const Icon(Icons.cloud_upload),
        backgroundColor: Colors.green,
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            post.url = widget.url;
            post.date = DateTime.now().millisecondsSinceEpoch;
            post.latitude = locationData!.latitude;
            post.longitude = locationData!.longitude;
            FirebaseFirestore.instance.collection('posts').add({
              'date': post.date, 
              'quantity': post.quantity, 
              'url': post.url, 
              'latitude': post.latitude, 
              'longitude': post.longitude
            });
            Navigator.of(context).pop();
          }
        }
      ),
      button: true,
      enabled: true,
      onTapHint: "Upload your post",
    );
  }
  
}

