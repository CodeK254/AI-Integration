import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

void storeChat(String name, List data) async {
  try{
    PermissionStatus permissionStatus = await Permission.storage.status;
    if(permissionStatus == PermissionStatus.granted){
      Directory directory = await Directory("/storage/emulated/0/AiDriven/").create();
      File file = await File("${directory.path}$name.txt").create();
      await file.writeAsString(data.toString());
    }
    else {
      await Permission.storage.request();
    }
  } on PathAccessException {
    await Permission.storage.request();
    rethrow;
  }
}