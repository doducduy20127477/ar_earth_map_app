import "package:flutter/material.dart";
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart' as vector;

class RuntimeMaterials extends StatefulWidget {
  const RuntimeMaterials({super.key});

  @override
  State<RuntimeMaterials> createState() => _RuntimeMaterialsState();
}

class _RuntimeMaterialsState extends State<RuntimeMaterials> {
  late ArCoreController arCoreController;
  late ArCoreNode sphereNode;

  double metallic = 0.0;
  double roughness = 0.4;
  double reflectance = 0.5;
  Color color = Colors.yellow;

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Runtime Change Materials"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SphereControl(
              initialColor: color,
              initialMetallicValue: metallic,
              initialRoughnessValue: roughness,
              initialReflectanceValue: reflectance,
              onColorChange: onColorChange,
              onMetallicChange: onMetallicChange,
              onRoughnessChange: onRoughnessChange,
              onReflectanceChange: onReflectanceChange
          ),
          Expanded(
              child: ArCoreView(
                onArCoreViewCreated: whenArCoreViewCreated,
              
            )
          )
        ],
      ),
    );
  }

  void whenArCoreViewCreated(ArCoreController controller)
  {
    arCoreController = controller;
    _addSphere(arCoreController);
  }

  void _addSphere(ArCoreController controller)
  {
    final material = ArCoreMaterial(
      color: Colors.yellow,
    );

    final sphere = ArCoreSphere(
        materials: [material],
        radius: 0.1,
    );

    sphereNode = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );

    controller.addArCoreNode(sphereNode);
  }

  onColorChange(Color newColor)
  {
    if (newColor != this.color)
      {
        this.color = newColor;
        updateMaterials();
      }
  }
  onMetallicChange(double newMetallic)
  {
    if (newMetallic!= this.metallic)
      {
        this.metallic = newMetallic;
        updateMaterials();
      }
  }
  onRoughnessChange(double newRoughness)
  {
    if (newRoughness!= this.roughness)
      {
        this.roughness = newRoughness;
        updateMaterials();
      }
  }
  onReflectanceChange(double newReflectance)
  {
    if (newReflectance != this.reflectance)
      {
        this.reflectance = newReflectance;
        updateMaterials();
      }
  }

  void updateMaterials()
  {
    debugPrint("updateMaterials");
    if (sphereNode == null)
      {
        return;
      }
    debugPrint("updateMaterials sphere node not null");
    final material = ArCoreMaterial(
      color: color,
      metallic: metallic,
      roughness: roughness,
      reflectance: reflectance,
    );
    sphereNode.shape?.materials.value = [material];
  }
}

class SphereControl extends StatefulWidget {
  final double initialRoughnessValue;
  final double initialReflectanceValue;
  final double initialMetallicValue;
  final Color initialColor;
  final ValueChanged<Color> onColorChange;
  final ValueChanged<double> onMetallicChange;
  final ValueChanged<double> onRoughnessChange;
  final ValueChanged<double> onReflectanceChange;

  const SphereControl({
    Key? key,
    required this.initialRoughnessValue,
    required this.initialReflectanceValue,
    required this.initialMetallicValue,
    required this.initialColor,
    required this.onColorChange,
    required this.onMetallicChange,
    required this.onRoughnessChange,
    required this.onReflectanceChange,
  }) : super(key: key);


  @override
  State<SphereControl> createState() => _SphereControlState();
}

class _SphereControlState extends State<SphereControl> {
  late double metallicValue;
  late double roughnessValue;
  late double reflectanceValue;
  late Color color;

  @override
  void initState() {
    roughnessValue = widget.initialRoughnessValue;
    reflectanceValue = widget.initialReflectanceValue;
    metallicValue = widget.initialMetallicValue;
    color = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ElevatedButton(
                  child: Text("Random Color"),
                  onPressed: () {
                    final newColor = Colors.accents[Random().nextInt(14)];
                    widget.onColorChange(newColor);
                    setState(() {
                      color = newColor;
                    });
                  },
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: color,
                    ),
                )
              ],
            ),
            Row(
              children: [
                Text("Metallic"),
                Checkbox(
                    value: metallicValue == 1.0,
                    onChanged: (value) {
                      if (value != null) { // Check for null
                        metallicValue = value ? 1.0 : 0.0;
                        widget.onMetallicChange(metallicValue);
                      }
                    }
                )
              ],
            ),
            Row(
              children: [
                Text("Roughness"),
                Expanded(
                    child: Slider(
                      value: roughnessValue,
                      divisions: 10,
                      onChangeEnd: (value) {
                        roughnessValue = value;
                        widget.onRoughnessChange(roughnessValue);
                      },
                      onChanged: (double value) {
                        setState(() {
                          roughnessValue = value;
                        });
                      },
                    )
                )
              ],
            ),
            Row(
              children: [
                Text("Reflectance"),
                Expanded(
                    child: Slider(
                      value: reflectanceValue,
                      divisions: 10,
                      onChangeEnd: (value) {
                        reflectanceValue = value;
                        widget.onReflectanceChange(reflectanceValue);
                      },
                      onChanged: (double value) {
                        setState(() {
                          reflectanceValue = value;
                        });
                      },
                    )
                )
              ],
            ),
          ],
        )
    );
  }
}

