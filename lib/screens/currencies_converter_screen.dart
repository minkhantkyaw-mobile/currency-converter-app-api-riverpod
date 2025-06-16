// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CurrenciesConverterScreen extends StatefulWidget {
  double currencyRate;
  String country;
  CurrenciesConverterScreen({
    Key? key,
    required this.currencyRate,
    required this.country,
  }) : super(key: key);

  @override
  State<CurrenciesConverterScreen> createState() =>
      _CurrenciesConverterScreenState();
}

class _CurrenciesConverterScreenState extends State<CurrenciesConverterScreen> {
  late String fromCurrency;
  late String toCurrency;
  late double fromNumber;
  late double toNumber;
  double total = 0.0;

  void initState() {
    super.initState();
    fromCurrency = widget.country.toString();
    toCurrency = "MMK";
    fromNumber = 1;
    toNumber = widget.currencyRate;
    //rateResult = widget.currencyRate;
  }

  void swapCurrencies() {
    // print("swap");
    setState(() {
      final tempCurrency = fromCurrency;
      final tempNumber = fromNumber;

      fromCurrency = toCurrency;
      toCurrency = tempCurrency;

      fromNumber = toNumber;
      toNumber = tempNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Declaration
    double rateResult = widget.currencyRate;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 251, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 251, 240),
        title: Row(
          children: [
            Image(
              width: MediaQuery.of(context).size.width / 9,
              image: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/a/a7/Central_Bank_of_Myanmar_seal.png",
              ),
            ),
            SizedBox(width: 20),
            Text(
              "Currency Converter",
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              fromNumber.toString() +
                  fromCurrency +
                  ' is Equal to ' +
                  toNumber.toString() +
                  toCurrency,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 18,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      fromCurrency,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                IconButton(
                  onPressed: swapCurrencies,
                  icon: Icon(
                    Icons.swap_horiz_outlined,
                    size: MediaQuery.of(context).size.width / 12,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 18,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      toCurrency,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: "Amount",
                labelStyle: TextStyle(color: Colors.black),
              ),

              onChanged: (value) {
                if (value != "") {
                  setState(() {
                    double amount = double.parse(value);
                    total = amount * rateResult;
                  });
                }

                // if (toCurrency != "MMK") {
                //   setState(() {
                //     double amount = double.parse(value);
                //     total = amount / fromNumber;

                //   });
                // }
              },
            ),
          ),
          Text(
            "$total MMK",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
