import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apuri v2',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CommentableTextForm(),
    );
  }
}

class CommentableTextForm extends StatefulWidget {
  @override
  _CommentableTextFormState createState() => _CommentableTextFormState();
}

class _CommentableTextFormState extends State<CommentableTextForm> {
  final commentedTextFieldController = TextEditingController();

  @override
  void dispose() {
    commentedTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A helper made with Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Commented text',
          ),
          maxLines: 5,
          controller: commentedTextFieldController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Commented text to copy'),
                content: Text(commentedTextFieldController.text),
                actions: <Widget>[
                  TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Start',
        child: Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
