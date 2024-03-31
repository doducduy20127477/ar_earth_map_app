# ar_earth_map_app

### Intro:

- **Overview**: Become AR Developer - Flutter Android AR Augmented Reality Applications
- This README is used for tutorial

### Install and Config:

1. Clone repository: [https://github.com/doducduy20127477/ar_earth_map_app.git]
2. If you see this failure:

   ```
   * What went wrong:
   The Android Gradle plugin supports only Kotlin Gradle plugin version 1.5.20 and higher.
   The following dependencies do not satisfy the required version:
   root project 'android' -> org.jetbrains.kotlin:kotlin-gradle-plugin:1.3.50
   ```

   <u>**Resolve**</u>: Just go to Projects: External Libraries -> Flutter Plugins ->
   ar_core_flutter_plugin-0.1.0 -> android -> build.gradle and update `ext.kotlin_version`. In my
   case it's: `ext.kotlin_version = '1.7.10'`

3. Build and run project

### Table of Contents:

1. AR Geometric Shapes `geometricShapes.dart`:
   - Sphere
   - Cube
   - Cylinder
2. AR Avengers `avengersCharacters.dart`:
3. AR Augmented Face `augmentedFaces.dart`
4. AR Augmented Images `augmentedImages.dart`
5. Change Materials at Runtime `runtime_materials.dart`: Sphere
   - Change color
   - Change metallic
   - Change roughness
   - Change reflectance
6. Custom Anchored Object onTap `custom_object.dart`

### Technical and Tools:

1. Tech stack and tools:

- `arcore_flutter_plugin`

### Summary:

### Reference:

[https://www.udemy.com/course/flutter-augmented-reality-course-build-10-android-ar-apps/]
