import 'package:ai_driven/chat/chat.dart';
import 'package:ai_driven/chat/chat_controller.dart';
import 'package:ai_driven/image_detection/detection_controller.dart';
import 'package:ai_driven/image_detection/image_detection.dart';
import 'package:flutter/material.dart';
import "package:flutter_gemini/flutter_gemini.dart";
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: "AIzaSyAOWVkyT5e-tEOBX8SD6ylGzln_P2hjMjg");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        colorScheme: const ColorScheme.light(),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            )
          )
        )
      ),
      initialRoute: "/detection",
      getPages: [
        GetPage(
          name: "/", 
          page: () => MyHomePage(title: "Gemini Chat App Demo"),
          binding: BindingsBuilder(() {
            Get.lazyPut<ChatController>(() => ChatController());
          })
        ),
        GetPage(
          name: "/detection", 
          page: () => ImageDetectionScreen(),
          binding: BindingsBuilder(() {
            Get.lazyPut<DetectionController>(() => DetectionController());
          })
        ),
      ],
    ),
  );
}