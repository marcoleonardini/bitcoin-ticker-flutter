import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  double value = 0;

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem> items = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      items.add(item);
    }
    return items;
  }

  List<Text> getPickerItems() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      var item = Text(currency);
      items.add(item);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $value $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: CupertinoPicker(
                itemExtent: 32,
                onSelectedItemChanged: (value) {
                  getConversion(currenciesList[value]);
                },
                children: getPickerItems(),
              )),
        ],
      ),
    );
  }

  void getConversion(String currency) async {
    Response r = await get(
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC$currency',
        headers: {'x-ba-key': 'NzY3ODI2ZGZlMjhlNDRiYThmMzNmZTViM2RmMGE5MzI'});
    var decoded = jsonDecode(r.body);
    setState(() {
      value = decoded['last'];
      selectedCurrency = currency;
    });
    print(value);
    //
  }
}

// DropdownButton(
//               value: selectedCurrency,
//               onChanged: (value) {
//                 print(value);
//                 setState(() {
//                   selectedCurrency = value;
//                 });
//               },
//               items: getDropdownItems(),
//             ),
