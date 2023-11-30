import 'dart:convert';

import 'package:api_project_4/model/api_model.dart';
import 'package:http/http.dart' as http;


class HomeScreenController {
  Map<String, dynamic> decodedData = {};
  ApiResModel? modelobj;

  Future getData() async {
    final url = Uri.parse('http://3.92.68.133:8000/api/addemployee/');
    final respone = await http.get(url);
    print(respone.statusCode);
    print(respone.body);
    decodedData = jsonDecode(respone.body);
    modelobj = ApiResModel.fromJson(decodedData);
  }

  Future deleteData(String id) async {
    final url = Uri.parse('http://3.92.68.133:8000/api/addemployee/$id/');
    final respone = await http.delete(url);
    if (respone.statusCode == 200) {
      await getData();
      return true;
    } else {
      return false;
    }
  }

  Future addData(String? name, String? designation) async {
    final url = Uri.parse('http://3.92.68.133:8000/api/addemployee/');
    final respone = await http.post(url, body: {'employee_name': name, 'designation': designation});
    if (respone.statusCode == 200) {
      await getData();
      return true;
    } else {
      return false;
    }
  }

 // Future putData(String id)async{
 //    final url = Uri.parse('http://3.92.68.133:8000/api/addemployee/$id/');
 //    final respone = await http.put(url);
 //    if (respone.statusCode == 200) {
 //      await getData();
 //      return true;
 //    } else {
 //      return false;
 //    }
 //  }
  }
