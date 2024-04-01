import 'dart:math';
import 'dart:typed_data';
import "package:flutter/material.dart";
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARQuotes extends StatefulWidget {
  const ARQuotes({super.key});

  @override
  State<ARQuotes> createState() => _ARQuotesState();
}

class _ARQuotesState extends State<ARQuotes> {
  late ArCoreController arCoreController;

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Object"),
        centerTitle: true,
      ),
      body: ArCoreView(
        onArCoreViewCreated: whenArCoreViewCreated,
        enableTapRecognizer: true,

      ),
    );
  }

  void whenArCoreViewCreated(ArCoreController controller)
  {
    arCoreController = controller;
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    addQuotedImage(hit);
  }

  Future addQuotedImage(ArCoreHitTestResult hit) async {
    final bytes = (await rootBundle.load("assets/topolino.jpg")).buffer.asUint8List();

    final imageQuote = ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 600, height: 600),
      position: hit.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
      rotation: hit.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
    );

    arCoreController.addArCoreNodeWithAnchor(imageQuote);
  }

}
