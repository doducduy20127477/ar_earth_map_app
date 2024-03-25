import "package:flutter/material.dart";
import 'dart:typed_data';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';

class AugmentedFaces extends StatefulWidget {
  const AugmentedFaces({super.key});

  @override
  State<AugmentedFaces> createState() => _AugmentedFacesState();
}

class _AugmentedFacesState extends State<AugmentedFaces> {
  late ArCoreFaceController arCoreFaceController;

  whenArCoreViewCreated(ArCoreFaceController faceController)
  {
    arCoreFaceController = faceController;

    //load Mesh
    loadMesh();
  }
  @override
  void dispose() {
    super.dispose();
    arCoreFaceController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Augmented Faces"),
        centerTitle: true,
        ),
      body: ArCoreFaceView(
        onArCoreViewCreated: whenArCoreViewCreated,
        enableAugmentedFaces: true,
      ),
    );
  }

  void loadMesh() async
  {
    final ByteData textureBytes = await rootBundle.load("assets/fox_face_mesh_texture.png");

    arCoreFaceController.loadMesh(
        textureBytes: textureBytes.buffer.asUint8List(),
        skin3DModelFilename: "fox_face.sfb"
    );
  }
}

