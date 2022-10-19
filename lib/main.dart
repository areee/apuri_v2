import 'package:flutter/material.dart';

import 'widgets/add_spaces_to_camel_case_text.dart';
import 'widgets/commentable_text_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apuri v2',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Another helper project using Flutter'),
          bottom: const TabBar(
            tabs: [
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
          children: [
            CommentableTextForm(),
            AddSpacesToCamelCaseText(),
          ],
        ),
      ),
    );
  }
}
