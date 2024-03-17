import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class ArEarthMapScreen extends StatefulWidget {
  const ArEarthMapScreen({super.key});

  @override
  State<ArEarthMapScreen> createState() => _ArEarthMapScreenState();
}

class _ArEarthMapScreenState extends State<ArEarthMapScreen> {
  ArCoreController? augmentedRealityCoreController;

  augmentedRealityViewCreated(ArCoreController coreController) {
    augmentedRealityCoreController = coreController;
    displayTutor(augmentedRealityCoreController!);
  }

  displayTutor(ArCoreController coreController) async {
    final ByteData textureBytes = await rootBundle.load("images/tutor.png"); // Use a .png image with a transparent background
    final materials = ArCoreMaterial(
      color: Colors.white,
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    // Create a very thin box to act as a plane
    final cube = ArCoreCube(
      size: vector64.Vector3(0.5, 1.0, 0.001), // The depth is very small to look like a plane
      materials: [materials],
    );

    final node = ArCoreNode(
      shape: cube,
      position: vector64.Vector3(0, 0, -1.5), // Position the image in the AR space
    );

    augmentedRealityCoreController!.addArCoreNode(node);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Earth Map'),
        centerTitle: true,
      ),
      body: ArCoreView(
        onArCoreViewCreated: augmentedRealityViewCreated,
      ),
    );
  }
}
