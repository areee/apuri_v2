import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

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

  String addContentBeforeString(String content, String contentBefore) {
    var lines = content.split('\n');

    var returnedText = StringBuffer();

    for (var i = 0; i < lines.length; i++) {
      var line = lines[i];

      var lineResult = '$contentBefore$line';
      returnedText.write(lineResult);

      if (i != lines.length - 1) {
        returnedText.write('\n');
      }
    }

    return returnedText.toString();
  }

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
                content: Text(addContentBeforeString(
                    commentedTextFieldController.text, '///')),
                actions: <Widget>[
                  TextButton(
                    child: Text('Copy to clipboard'),
                    onPressed: () {
                      FlutterClipboard.copy(addContentBeforeString(
                          commentedTextFieldController.text, '///'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Copied to clipboard!'),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
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
