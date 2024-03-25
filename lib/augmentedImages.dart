import "package:flutter/material.dart";
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';

class AugmentedImages extends StatefulWidget {
  const AugmentedImages({super.key});

  @override
  State<AugmentedImages> createState() => _AugmentedImagesState();
}

class _AugmentedImagesState extends State<AugmentedImages> {
  late ArCoreController arCoreController;
  Map<int, ArCoreAugmentedImage> augmentedImageMap = Map();

  @override
  void dispose() {
    super.dispose();
    arCoreController.dispose();
  }

  whenArCoreViewCreated(ArCoreController coreController)
  {
    arCoreController = coreController;
    arCoreController.onTrackingImage = controlOnTrackingImage;

    //load the single image
    loadSingleImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Augmented Images"),
        centerTitle: true,
      ),
      body: ArCoreView(
        onArCoreViewCreated: whenArCoreViewCreated,
        type: ArCoreViewType.AUGMENTEDIMAGES,
    ),
    );
  }

  void controlOnTrackingImage(ArCoreAugmentedImage augmentedImage)
  {
    if(!augmentedImageMap.containsKey(augmentedImage.index))
    {
      augmentedImageMap[augmentedImage.index] = augmentedImage;
    }

    //addSphere
    addSphere(augmentedImage);
  }

  void loadSingleImage() async
  {
    final ByteData bytes = await rootBundle.load("assets/earth_augmented_image.jpg");

    arCoreController.loadSingleAugmentedImage(
        bytes: bytes.buffer.asUint8List(),
    );
  }

  Future addSphere(ArCoreAugmentedImage arCoreAugmentedImage) async
  {
    final ByteData textureBytes = await rootBundle.load("assets/earth.jpg");

    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final sphere = ArCoreSphere(
        materials: [material],
        radius: arCoreAugmentedImage.extentX / 2,
    );

    final node = ArCoreNode(
      shape: sphere,
    );
    
    arCoreController.addArCoreNodeToAugmentedImage(node, arCoreAugmentedImage.index);
  }
}
