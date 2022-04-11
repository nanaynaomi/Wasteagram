import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/wasted_food_form.dart';

class NewPost extends StatelessWidget {
  final String? url;
  const NewPost({ Key? key, required this.url}) : super(key: key);

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
        title: const Text('New Post'),
        centerTitle: true,
      ),
      body: WastedFoodForm(url: url),
    );
  }
}