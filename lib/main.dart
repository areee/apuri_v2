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
      home: TabBarWidget(),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Another helper project using Flutter'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Add XML Documentation Comments',
              ),
              Tab(
                text: 'Add Spaces to camelCase Text',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: CommentableTextForm(),
            ),
            Center(
              child: Text('Another TabBarView'),
            ),
          ],
        ),
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Commentable text',
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
