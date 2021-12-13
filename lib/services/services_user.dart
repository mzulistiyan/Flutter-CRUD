import 'dart:convert' as convert;
import 'dart:convert';

import 'package:flutter_http_request_simple/model/model_user.dart';
import 'package:http/http.dart' as http;

class UserService {
  final _baseUrl = 'https://61b6d2ebc95dd70017d41061.mockapi.io/';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/users/'));

      if (response.statusCode == 200) {
        Iterable it = convert.jsonDecode(response.body);

        List<UsersModel> users = it.map((e) => UsersModel.fromJson(e)).toList();
        return users;
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String name) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl + '/users'), body: {
        "name": name,
      });
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future putData(int id, String name) async {
    try {
      final response = await http.put(
          Uri.parse(_baseUrl + '/users/' + id.toString()),
          body: {"name": name});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(
        Uri.parse(_baseUrl + '/users/' + id.toString()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<UsersModel>> getUser() async {
    final response = await http.get(Uri.parse(_baseUrl + '/users/1'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<UsersModel> users = [];

      for (var item in data) {
        users.add(UsersModel.fromJson(item));
      }
      return users;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
