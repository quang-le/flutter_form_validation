import 'package:filters/filters/filter_field.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test filters',
      home: Scaffold(
        body: SafeArea(child: FilterFields()),
      ),
    );
  }
}
