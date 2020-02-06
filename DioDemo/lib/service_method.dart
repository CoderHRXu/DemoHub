import 'package:dio/dio.dart';
import 'package:async/async.dart';
import 'dart:io';

Future request(url, formData) async {
  try {
    print('start request....');
    Response response;
    Dio dio = new Dio();
    // dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    if (formData == null) {
      response = await dio.post(url);
    }else{
      response = await dio.post(url, data: formData);
    }

    if (response.statusCode == 200) {
      return response.data;
    }else{
      throw Exception('exception');
    }

  } catch (e) {
    return print("Error: ====> $e");
  }
}

Future postTest(name) async {
  return request('http://localhost:3000/post', {'name': name});
}