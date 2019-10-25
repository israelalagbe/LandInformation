import 'dart:convert';
import 'dart:io';

import 'package:land_information/property/property.dart';
import 'package:http/http.dart' as http;

class PropertyService {
  var _baseUrl = "http://appstore.successfarm.com.ng/api";
  Future<String> uploadFile(File file) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse('$_baseUrl/files'));
      var pic = await http.MultipartFile.fromPath("file", file.path);
      request.files.add(pic);
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var data = jsonDecode(responseString);
      return data['url'];
    } catch (e) {
      return Future.error(e);
    }
  }

  Future savePost(Property property) async {
    try {
      var body = property.toJson();
      var response = await http.post('$_baseUrl/posts', body: body);
      if (response.statusCode > 290) {
        return Future.error(response.body);
      }
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Property>> getPosts() async {
    try {
      var response = await http.get('$_baseUrl/posts');
      if (response.statusCode > 290) {
        return Future.error(response.body);
      }
      var data = jsonDecode(response.body);
      var properties = data.map((item) => Property.fromJson(item)).toList();
      return List<Property>.from(properties);
    } catch (e) {
      return Future.error(e);
    }
  }
  /* 
  
  */
}
