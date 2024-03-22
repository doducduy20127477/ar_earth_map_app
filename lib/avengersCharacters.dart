import "package:flutter/material.dart";
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AvengersCharacters extends StatefulWidget {
  const AvengersCharacters({super.key});

  @override
  State<AvengersCharacters> createState() => _AvengersCharactersState();
}

class _AvengersCharactersState extends State<AvengersCharacters> {
  late ArCoreController arCoreController;

  void whenArCoreViewCreated(ArCoreController arCoreController)
  {
    this.arCoreController = arCoreController;
    this.arCoreController.onPlaneTap = controlOnPlaneTap;

  }

  void controlOnPlaneTap(List<ArCoreHitTestResult> hitsResults)
  {
    final hit = hitsResults.first;

    //adding the character
    addCharacter(hit);

  }

  Future addCharacter(ArCoreHitTestResult hit) async
  {
    final bytes = (await rootBundle.load("assets/tutor_transparent.png")).buffer.asUint8List();

    final characterPos = ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 500, height: 500),
      position: hit.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
      rotation: hit.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
    );

    arCoreController.addArCoreNodeWithAnchor(characterPos);

  }

  @override
  void dispose() {
    super.dispose();
    arCoreController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AR Avengers"),
        centerTitle: true,
      ),
      body: ArCoreView(
        onArCoreViewCreated: whenArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }


}
