import 'dart:async';
import './apothecary_service.dart';

Future<List> sendDeliveryListCalculate(deliveryPoints) async {
  List resultGraphNew = await ApothecaryService().sendDeliveryList(deliveryPoints);
  return resultGraphNew;
}

Future<String> getCurrentMap() async {
  String resultCurrentMap = await ApothecaryService().getCurrentMap();
  return resultCurrentMap;
}