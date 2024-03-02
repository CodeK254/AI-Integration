// import 'dart:io';

// import 'package:get/get.dart';
// import "package:file_picker/file_picker.dart";

// class ImportController extends GetxController{
//   static File? picked;
//   // ImagePicker picker = ImagePicker();

//   static Future<File?> loadFile() async {
//     FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ["txt"],
//     );

//     if(pickedFile != null){
//       picked = File(pickedFile.files.single.path!);
//     }
//     return picked;
//   }

//   static List setChats(File file, List data){
//     data = file.readAsString() as List;
//     return data;
//   }
// }