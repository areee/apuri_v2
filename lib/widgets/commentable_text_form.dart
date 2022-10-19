import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

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

  Future<String?> _showResultDialog(BuildContext context) {
    var finalResultToShow =
        _addContentBeforeString(commentedTextFieldController.text, '/// ');
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Commented text to copy'),
              content: Text(finalResultToShow),
              actions: <Widget>[
                TextButton(
                  child: const Text('Copy to clipboard'),
                  onPressed: () {
                    FlutterClipboard.copy(finalResultToShow);
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
            ));
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
        onPressed: () => _showResultDialog(context),
        tooltip: 'Start',
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
