import "dart:io";

import "package:ai_driven/chat/chat_controller.dart";
import "package:ai_driven/services/export.dart";
import "package:ai_driven/services/import.dart";
import "package:ai_driven/widget/alert_dialog.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ChatController chatController = Get.find<ChatController>();

  File? picked;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            PopupMenuButton(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              shadowColor: Colors.white,
              offset: Offset(0, MediaQuery.of(context).size.height * 0.055),
              itemBuilder: (context){
                return [
                  PopupMenuItem(
                    value: 0,
                    onTap: () async {
                      File? file = await ImportController.loadFile();
                      setState(() {
                        picked = file;
                      });
                      chatController.chats.value = ImportController.setChats(picked!, chatController.chats);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Import Chat",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Expanded(child: Container()),
                        Icon(
                          CupertinoIcons.search,
                          size: 23,
                          color: Colors.blueGrey.shade800,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    onTap: (){
                      Get.dialog(
                        CustomAlertDialog(
                          title: "Save To", 
                          cancel: "Cancel",
                          okay: "Okay",
                          content: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              maxLines: 1,
                              controller: chatController.storageName,
                              validator: (val){
                                return val!.isEmpty ? "Input field cannot be blank" : null;
                              },
                              decoration: InputDecoration(
                                label: Text(
                                  "File name",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.blueGrey.shade700,
                                  ),
                                ),
                                hintText: "Enter file name...",
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                    color: Colors.purple,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onCancel: (){
                            Get.back();
                          },
                          onOkay: (){
                            storeChat(
                              chatController.storageName.text, 
                              chatController.chats
                            );
                            Get.back();
                          },
                        )
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Export Chat",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.save,
                          size: 23,
                          color: Colors.blueGrey.shade800,
                        ),
                      ],
                    ),
                  ),
                ];
              }
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 18,
                child: chatController.chats.isNotEmpty ? Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white60,
                        Colors.white,
                        Colors.grey.shade100,
                        Colors.grey.shade200,
                      ],
                    ),
                  ),
                  child: Obx(
                    () => ListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...List.generate(
                          chatController.chats.length, (index) => Align(
                            alignment: chatController.chats[index]["sender"] == "User" ? Alignment.topRight : Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                                  minWidth: 0
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: chatController.chats[index]["sender"] == "User" ? Colors.purple.withOpacity(.5) : Colors.grey.withOpacity(.7),
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: chatController.chats[index]["sender"] == "User" ? const Radius.circular(0) : const Radius.circular(12),
                                    bottomLeft: chatController.chats[index]["sender"] != "User" ? const Radius.circular(0) : const Radius.circular(12),
                                    topLeft: const Radius.circular(12),
                                    bottomRight: const Radius.circular(12),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: chatController.chats[index]["sender"] == "User" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        chatController.chats[index]["sender"],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.blueGrey.shade700,
                                        ),
                                      ),
                                      Text(
                                        chatController.chats[index]["message"],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ) : Center(
                  child: Text(
                    "Welcome to Gemini Evolutionary AI. Feel free to ask any questions, I'lldo my best to answer you from the best of my knowledge.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: TextFormField(
                      maxLines: 1,
                      controller: chatController.inputText,
                      validator: (val){
                        return val!.isEmpty ? "Input field cannot be blank" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "Type something here...",
                        hintStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            chatController.getResponse(chatController.inputText.text);
          },
          tooltip: 'Send',
          mini: true,
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}