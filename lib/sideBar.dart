import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        color: Colors.white,
        child: SafeArea(
            child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [Text('TEST')],
          ),
        )));
  }
}
