import 'package:flutter/material.dart';
import 'screens/waste_list_screen.dart';

class App extends StatelessWidget {
  final String title;

  const App({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wasteagram',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const Scaffold(body: WasteListScreen())
        );
  }
}
