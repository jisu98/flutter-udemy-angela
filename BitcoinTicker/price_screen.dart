import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  List<double> price;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    updatePrice();
  }

  void updatePrice() async {
    var data = await CoinData().getData(selectedCurrency);
    setState(() {
      price = data;
      isLoading = false;
    });
  }

  DropdownButton getDropdownButton() {
    List<DropdownMenuItem> dropdownItems = [];

    for (String currency in currenciesList) {
      dropdownItems.add(DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      ));
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          isLoading = true;
          selectedCurrency = value;
          updatePrice();
        });
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Text> pickerItems = currenciesList.map((item) => Text(item)).toList();

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
      },
      children: pickerItems,
    );
  }

  List<Widget> buildCards() {
    List<Card> cards = [];

    for (int i = 0; i < cryptoList.length; i++) {
      cards.add(Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${cryptoList[i]} = ${price[i].toString()} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ));
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildCards(),
                  ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
