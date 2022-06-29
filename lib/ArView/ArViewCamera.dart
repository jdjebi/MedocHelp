import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArViewCamera extends StatelessWidget {

  ArViewCamera({Key? key, required this.data}) : super(key: key);

  var data = {};

  late ArCoreController arCoreController;
  late ArCoreNode? object;

  int setObjectCounter = 0;
  bool isDoctorPlaced = false;

  @override
  Widget build(BuildContext context){

   print(data);

    return Scaffold(
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
          enableUpdateListener: true,
        )
    );
  }

  _onArCoreViewCreated(ArCoreController _arCoreController){
    arCoreController = _arCoreController;
    arCoreController.onPlaneTap = _handleOnPlane;
    //arCoreController.onNodeTap = (name) => onTapHandler(name);

  }

   void _handleOnPlane(List<ArCoreHitTestResult> hits) {
    ArCoreHitTestResult plane = hits.first;
    _addSphere(plane);
  }

  void onTapHandler(String name){}

  _addSphere(ArCoreHitTestResult plane) async {

    var tdata = plane.translation;

    if(setObjectCounter > 0){
      await arCoreController.removeNode(nodeName: object?.name);
      setObjectCounter = 0;
    }

    final material = ArCoreMaterial(color: Colors.blue);
    final sphere = ArCoreSphere(materials: [material], radius: 0.08);

    /*
    object = ArCoreRotatingNode(
      shape: sphere,
      position: plane.pose.translation - vector.Vector3(0,0.1,0),
      rotation: plane.pose.rotation,
    );
    */

    object = ArCoreReferenceNode(
      name: "doctor",
      object3DFileName: "women.sfb",
      position: plane.pose.translation,
      rotation: plane.pose.rotation - vector.Vector4(0,-4,0,0),
      scale: vector.Vector3(2,2,2)
    );

    arCoreController.addArCoreNodeWithAnchor(object);

    setObjectCounter += 1;

    if(!isDoctorPlaced){
      arCoreController.togglePlaneRenderer();
    }else{
      isDoctorPlaced = true;
    }
  }

}