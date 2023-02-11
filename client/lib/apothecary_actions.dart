import 'package:flutter/material.dart';

import 'futures.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String graphData = '';
  String newRoom = '';
  List<String> deliveryPoints = [];
  final _formKey = GlobalKey<FormState>();
  late Future<List> calculatedDelivery;
  late Future<String> currData = Future.value("No data yet.");

  handleSendDeliveryClick() {
    setState(() {
      calculatedDelivery = sendDeliveryListCalculate(deliveryPoints);
    });
  }

  handleGetMapClick() {
    setState(() {
      currData = getCurrentMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Apothecary Dispatch: Actions'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(
            child: const Text("Get current map"), onPressed: handleGetMapClick),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(onChanged: (value) {
                newRoom = value;
              }),
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  deliveryPoints.add(newRoom);
                },
              ),
              TextButton(
                child: const Text('Graph'),
                onPressed: handleSendDeliveryClick,
              ),
            ],
          ),
        ),
        FutureBuilder<String>(
          future: currData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        )
      ]),
    );
  }
}
