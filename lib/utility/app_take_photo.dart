import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AppTakePhoto {
  Future<String> uploadImage() async {
    String urlImage = '';

    var result = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);

    if (result != null) {
      String nameFile = basename(result.path);
      print('##3seb nameFile ---> $nameFile');

      String urlApi =
          'https://www.androidthai.in.th/fluttertraining/UngFew/saveSlip.php';

      Map<String, dynamic> map = {};

      map['file'] = await MultipartFile.fromFile(File(result.path).path,
          filename: nameFile);

      FormData formData = FormData.fromMap(map);

      var response = await Dio().post(urlApi, data: formData);

      urlImage = 'https://www.androidthai.in.th/fluttertraining/UngFew/slip/$nameFile';
    }

    

    return urlImage;
  }
}
