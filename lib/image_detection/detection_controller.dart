import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class DetectionController extends GetxController{
  CameraController? cameraController;
  RxList<CameraDescription> cameras = <CameraDescription>[].obs;
  RxBool isInitialized = false.obs;
  CameraImage? cameraImage;
  final gemini = Gemini.instance;
  RxString response = "".obs;

  initializeCamera() async {
    PermissionStatus permissionStatus = await Permission.camera.status;
    if(permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.limited){
      cameras.value = await availableCameras();
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );
      await cameraController!.initialize();
      isInitialized.value = true;
    } else {
      await Permission.camera.request();
      initializeCamera();
    }
  }

  Future<String> describeImage(File image) async {
    response.value = "";
    var data = await gemini.textAndImage(
      text: "Describe this image?", 
      images: [
        image.readAsBytesSync(),
      ]
    );
    Map answer = data!.toJson();
    Map toPrint = answer["content"].toJson()["parts"][0].toJson();
    response.value = toPrint["text"];
    return response.value;
  }

  @override
  void onInit() {
    initializeCamera();
    super.onInit();
  }
}