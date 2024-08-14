// import 'package:flutter/material.dart';
// import 'dart:convert';

import 'dart:convert';

import 'package:http/http.dart' as http;

void main(List<String> args) async {
  //1 get
  // var response = await http.get(Uri.parse('http://127.0.0.1:8000/core/a'));
  // print(jsonDecode((response.body)));
  // print(response.body);
  //2 post
  var response =
      await http.post(Uri.parse('http://127.0.0.1:8000/core/a'), body: {
    'username': 'chaurasiya',
    'email': 'himanshuchaurasiya@gmail.com',
    'password':'pbkdf2_sha256\$260000\$hEwJy1up5W2fKEcVipf05T\$f+Ea9OWoico1lyMIMuXlpW3qF/+xOHvFzk4XNlb7UuA=',
  });
  // print(jsonDecode(response.body)['username']);
  // print('object');
  print(jsonDecode(response.body)['email']);
  // print('object');
  // print(jsonDecode(response.body)['password']);
  // print('object');
}
