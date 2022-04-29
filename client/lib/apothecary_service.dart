import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dart:async';
import 'dart:convert';

class ApothecaryService {
  getCurrentMap() async {
    String content = '';
      try {
        var res = await http.get(Uri.parse('http://127.0.0.1:5555/new'));
        if (res.statusCode == 200) {
          Map<String, dynamic> resDecoded = jsonDecode(res.body);
          return resDecoded['graph'];
        } else {
          return content;
        }
      } catch (error) {
        throw (error);
      }
  }

  sendDeliveryList(dataToSend) async {
    String sentContent = '';
      try {
        var res = await http.post(Uri.parse('http://127.0.0.1:5555/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, List<String>>{
          'deliveries': dataToSend,
        }),
        );

        if (res.statusCode == 200) {
          Map<String, dynamic> resDecoded = jsonDecode(res.body);
          return resDecoded['path'];
        } else {
          return sentContent;
        }
      } catch (error) {
        throw (error);
      }
  }
}
