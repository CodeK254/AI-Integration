// import "dart:io";
import "package:flutter/material.dart";
import "package:flutter_gemini/flutter_gemini.dart";
import "package:get/get.dart";
// import "package:permission_handler/permission_handler.dart";

class ChatController extends GetxController{
  final TextEditingController inputText = TextEditingController();
  final TextEditingController storageName = TextEditingController();
  final gemini = Gemini.instance;
  RxList chats = [].obs;

  Future<void> getResponse(String input) async {
    chats.add(
      {
        "sender": "User",
        "message": input,
      },
    );
    debugPrint("Chats has: $chats");
    inputText.clear();
    gemini.text(
      input,
    ).then((value) {
      Map data = value!.toJson()["content"].toJson()["parts"].first.toJson();
      chats.add(
        {
          "sender": "Gemini",
          "message": data["text"].toString(),
        }
      );
    // ignore: invalid_return_type_for_catch_error
    }).catchError((e) => debugPrint(e.toString()));
  }

  @override
  void onInit() async {
    // if(Platform.isAndroid || Platform.isIOS){
    //   PermissionStatus permissionStatus = await Permission.storage.status;
    //   if(permissionStatus != PermissionStatus.granted){
    //     await Permission.storage.request();
    //   }
    // }
    super.onInit();
  }
}