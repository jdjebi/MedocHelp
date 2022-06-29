import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MyHomePage/MyHomePage.dart';

const d_green = Color(0xFF54D3C2);

class ScannerClass extends StatelessWidget{
  const ScannerClass({Key? key}) : super(key: key);

  // final _MyHomePageState My = new _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.camera_alt_rounded),
      label: const Text("Scanner médi"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page')),
        );
      },

      style: ElevatedButton.styleFrom(
        side: const BorderSide(width: 2.0, color: d_green),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}