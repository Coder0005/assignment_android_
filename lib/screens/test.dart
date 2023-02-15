import 'package:flutter/material.dart';

class TextClass extends StatefulWidget {
  const TextClass({Key? key}) : super(key: key);

  @override
  State<TextClass> createState() => _TextClassState();
}

class _TextClassState extends State<TextClass> {
  bool _showState = true;

  void changeState() {
    setState(() {
      _showState = !_showState;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showState = true;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: changeState,
              child: const Text("Press"),
            ),
            Visibility(
              child: const Text("This is the text"),
              visible: _showState,
            )
          ],
        ),
      ),
    );
  }
}
