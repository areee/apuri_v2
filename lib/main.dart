import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apuri v2',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TabBarWidget(),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

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
        body: const TabBarView(
          children: <Widget>[
            CommentableTextForm(),
            AddSpacesToCamelCaseText(),
          ],
        ),
      ),
    );
  }
}

class CommentableTextForm extends StatefulWidget {
  const CommentableTextForm({super.key});

  @override
  State<CommentableTextForm> createState() => _CommentableTextFormState();
}

class _CommentableTextFormState extends State<CommentableTextForm> {
  final commentedTextFieldController = TextEditingController();

  String _addContentBeforeString(String content, String contentBefore) {
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
          decoration: const InputDecoration(
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
                title: const Text('Commented text to copy'),
                content: Text(_addContentBeforeString(
                    commentedTextFieldController.text, '///')),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Copy to clipboard'),
                    onPressed: () {
                      FlutterClipboard.copy(_addContentBeforeString(
                          commentedTextFieldController.text, '///'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Copied to clipboard!'),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Close'),
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
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}

class AddSpacesToCamelCaseText extends StatefulWidget {
  const AddSpacesToCamelCaseText({super.key});

  @override
  State<AddSpacesToCamelCaseText> createState() =>
      _AddSpacesToeCamelCaseTextState();
}

class _AddSpacesToeCamelCaseTextState extends State<AddSpacesToCamelCaseText> {
  final camelCaseTextFieldController = TextEditingController();

  String addSpacesToCamelCaseText(String content) => content.replaceAllMapped(
      RegExp(r'(?<=[a-z])[A-Z]'),
      (Match m) => (' ${m.group(0)}').toLowerCase());

  @override
  void dispose() {
    camelCaseTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'CamelCase text',
          ),
          maxLines: 5,
          controller: camelCaseTextFieldController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('CamelCase text to copy'),
                content: Text(addSpacesToCamelCaseText(
                    camelCaseTextFieldController.text)),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Copy to clipboard'),
                    onPressed: () {
                      FlutterClipboard.copy(addSpacesToCamelCaseText(
                          camelCaseTextFieldController.text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Copied to clipboard!'),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Close'),
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
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
