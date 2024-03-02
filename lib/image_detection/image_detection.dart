import 'dart:io';
import 'package:ai_driven/image_detection/detection_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageDetectionScreen extends StatefulWidget {
  const ImageDetectionScreen({super.key});

  @override
  State<ImageDetectionScreen> createState() => _ImageDetectionScreenState();
}

class _ImageDetectionScreenState extends State<ImageDetectionScreen> {
  final DetectionController detectionController = Get.find<DetectionController>();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(
            "Describe this Image",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade900,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: (){
                setState(() {
                  image == null;
                });
                detectionController.response.value = "";
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.refresh,
                ),
              ),
            )
          ],
        ),
        body: detectionController.isInitialized.value ? 
        image == null ? 
          CameraPreview(detectionController.cameraController!) 
          : 
          Column(
            children: [
              Expanded(flex: 3, child: SizedBox(width: double.infinity, child: Image(image: FileImage(image!), fit: BoxFit.cover))),
              Center(
                child: Visibility(
                  visible: detectionController.response.value != "",
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Text(
                        detectionController.response.value,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
         :
        const AlertDialog(
          backgroundColor: Colors.white,
          content: LinearProgressIndicator(
            color: Colors.blue,
          ),
        ),
        floatingActionButton: Visibility(
          visible: image == null,
          child: FloatingActionButton(
            onPressed: () async {
              if(detectionController.isInitialized.value){
                XFile file = await detectionController.cameraController!.takePicture();
                setState(() {
                  image = File(file.path);
                });
                detectionController.describeImage(File(file.path));
              }
            },
            mini: true,
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.type_specimen,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}