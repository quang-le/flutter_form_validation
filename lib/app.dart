import 'package:filters/examples/date_only.dart';
import 'package:filters/examples/full_form.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test examples',
      home: Scaffold(
        body: SafeArea(child: FullForm()),
      ),
    );
  }
}
