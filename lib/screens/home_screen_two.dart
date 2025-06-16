import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenTwo extends StatefulWidget {
  const HomeScreenTwo({super.key});

  @override
  State<HomeScreenTwo> createState() => _HomeScreenTwoState();
}

class _HomeScreenTwoState extends State<HomeScreenTwo> {
  String fromCurrency = "USD";
  String toCurrency = "EUR";
  double rate = 0.0;
  double total = 0.0;
  TextEditingController amountController = TextEditingController();
  List<String> currencies = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _getCurrencies();
  }

  Future<void> _getCurrencies() async {
    var response = await http.get(
      Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'),
    );
    var data = json.decode(response.body);

    setState(() {
      currencies = (data['rates'] as Map<String, dynamic>).keys.toList();
      rate = data['rates'][toCurrency];
      print(data);
    });
  }

  Future<void> _getRate() async {
    var response = await http.get(
      Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'),
    );
    var data = json.decode(response.body);
    setState(() {
      rate = data['rates'][toCurrency];
    });
  }

  void swapCurrencies() {
    setState(() {
      String temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
      _getRate();
      amountController.clear();
      rate = 0;
      total = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: [
              Color(0xff1f005c),
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Currency Converter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                TextField(
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        double amount = double.parse(value);
                        total = amount * rate;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: swapCurrencies,
                  child: Image(
                    image: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/2845/2845677.png",
                    ),
                    width: MediaQuery.of(context).size.width / 8,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.white,
                            value: fromCurrency,

                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            isExpanded: false,
                            decoration: InputDecoration(
                              label: Text("From"),
                              border: OutlineInputBorder(),
                            ),
                            items:
                                currencies.map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.flag,
                                          color: Colors.green,
                                          size: 30,
                                        ),
                                        SizedBox(width: 8),
                                        Text(value),
                                      ],
                                    ),
                                  );
                                }).toList(),

                            onChanged: (value) {
                              setState(() {
                                fromCurrency = value!;
                                _getRate();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.white,
                            value: toCurrency,

                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            isExpanded: false,
                            decoration: InputDecoration(
                              label: Text("to"),
                              border: OutlineInputBorder(),
                            ),
                            items:
                                currencies.map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.flag,
                                          color: Colors.green,
                                          size: 30,
                                        ),
                                        SizedBox(width: 8),
                                        Text(value),
                                      ],
                                    ),
                                  );
                                }).toList(),

                            onChanged: (value) {
                              setState(() {
                                toCurrency = value!;
                                _getRate();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                SizedBox(height: 24),
                Text(
                  "The Currency Rate : $rate ",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '${total.toStringAsFixed(2)}  $toCurrency',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Image(
                  image: NetworkImage(
                    "https://cdni.iconscout.com/illustration/premium/thumb/currency-exchange-illustration-download-in-svg-png-gif-file-formats--forex-trading-money-market-rate-financial-management-pack-people-illustrations-3749068.png",
                  ),
                  width: MediaQuery.of(context).size.width / 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
