import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ArViewCamera.dart';
import 'ArViewController.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArView extends StatelessWidget {

  var data;

  ArView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context){

    Container arViewCameraContainer = Container(
        height: double.infinity,
        width: double.infinity,
        child: ArViewCamera(data: data)
    );

    Container arViewControllerContainer = Container(
        height: double.infinity,
        width: 80,
        decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0)
        ),
        child: ArViewController(data: data)
    );

    return Stack(
      children: <Widget>[
        arViewCameraContainer,
        arViewControllerContainer
      ],
    );
  }

}