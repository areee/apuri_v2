import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class AddSpacesToCamelCaseText extends StatefulWidget {
  const AddSpacesToCamelCaseText({super.key});

  @override
  State<AddSpacesToCamelCaseText> createState() =>
      _AddSpacesToeCamelCaseTextState();
}

class _AddSpacesToeCamelCaseTextState extends State<AddSpacesToCamelCaseText> {
  final camelCaseTextFieldController = TextEditingController();

  String _addSpacesToCamelCaseText(String content) {
    return content.replaceAllMapped(RegExp(r'(?<=[a-z])[A-Z]'),
        (Match m) => (' ${m.group(0)}').toLowerCase());
  }

  Future<String?> _showResultDialog(BuildContext context) {
    var finalResultToShow =
        _addSpacesToCamelCaseText(camelCaseTextFieldController.text);
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Text with spaces to copy'),
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
        onPressed: () => _showResultDialog(context),
        tooltip: 'Start',
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
