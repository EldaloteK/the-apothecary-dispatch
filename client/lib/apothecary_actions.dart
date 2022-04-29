import './apothecary_service.dart';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currData = '';
  String graphData = '';
  String newRoom = '';
  List<String> deliveryPoints = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('The Apothecary Dispatch: Actions'),
      ),
      body: new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('${currData}'),
            RaisedButton(
              child: new Text("Get data"),
              onPressed: () async {
                String newData = await ApothecaryService().getCurrentMap();
                setState(() {
                  currData = newData;
                });
              },
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (value) {
                      newRoom = value;
                    }
                  ),
                  TextButton(
                    child: const Text('Add'),
                    onPressed: () {
                      deliveryPoints.add(newRoom);
                    },
                  ),
                  TextButton(
                    child: const Text('Graph'),
                    onPressed: () async {
                      String resultGraphNew = await ApothecaryService().sendDeliveryList(deliveryPoints);
                    },
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
