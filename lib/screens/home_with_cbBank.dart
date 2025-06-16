import 'dart:convert';

import 'package:currency_converter_app_sl/model/curency.dart';
import 'package:currency_converter_app_sl/model/rate.dart';
import 'package:currency_converter_app_sl/provider/date_provider.dart';
import 'package:currency_converter_app_sl/screens/currencies_converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<Rate> fetchRates() async {
  var response = await http.get(
    Uri.parse('https://forex.cbm.gov.mm/api/latest'),
  );

  if (response.statusCode == 200) {
    return Rate.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("Failed to load Rates");
  }
}

Future<void> datePicker(BuildContext context, WidgetRef ref) async {
  final currentDate = ref.read(selectedDateProvider);

  final pickedDate = await showDatePicker(
    context: context,
    initialDate: currentDate,
    firstDate: DateTime(1888),
    lastDate: DateTime(2029),
  );

  if (pickedDate != null) {
    ref.read(selectedDateProvider.notifier).state = pickedDate;
  }
}

Future<Currency> fetchCurrencies() async {
  var response = await http.get(
    Uri.parse('https://forex.cbm.gov.mm/api/currencies'),
  );

  if (response.statusCode == 200) {
    return Currency.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("Failed to load Currencies");
  }
}

Future fetchConbineData(WidgetRef ref) async {
  final rates = await fetchByDate(ref);
  final currencyName = await fetchCurrencies();

  return await [rates, currencyName];
}

Future<Rate> fetchByDate(WidgetRef ref) async {
  final selectedDate = ref.read(selectedDateProvider);
  String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate!);

  var response = await http.get(
    Uri.parse('https://forex.cbm.gov.mm/api/history/$formattedDate'),
  );
  print(formattedDate);

  if (response.statusCode == 200) {
    return Rate.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("Failed to load Currenciesmkk");
  }
}

String getCountryCodeFromCurrency(String currencyCode) {
  // Take the first 2 characters and convert to uppercase
  return currencyCode.substring(0, 2).toUpperCase();
}

class HomeWithCbbank extends ConsumerWidget {
  late final Future<Rate> futureRate;
  late final Future<Currency> futureCurrency;
  late final Future futureCombine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    return FutureBuilder(
      future: fetchConbineData(ref),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapShot.hasError) {
          return Text('Error: ${snapShot.error}');
        } else if (!snapShot.hasData || snapShot.data == null) {
          return CircularProgressIndicator();
        }

        if (snapShot.hasData) {
          final rates = snapShot.data![0].rates;
          final info = snapShot.data![0].info;
          final description = snapShot.data![0].description;
          final currencyDetails = snapShot.data![1].currency;

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
                  SizedBox(width: 10),
                  Text(
                    info.toString(),
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(9),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    description.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final selectedDate = ref.watch(selectedDateProvider);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              datePicker(context, ref);
                            },
                            icon: Icon(
                              Icons.calendar_month,
                              color: Color.fromARGB(255, 85, 61, 58),
                            ),
                          ),
                          Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
                        ],
                      );
                    },
                  ),
                  if (snapShot.data[0]!.rates.isEmpty)
                    Center(
                      child: Text(
                        "No data",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  // else
                  Expanded(
                    child: ListView.builder(
                      itemCount: rates.length,
                      itemBuilder: (BuildContext context, int index) {
                        String currency = rates.keys.elementAt(index);
                        String value = rates.values.elementAt(index);
                        String currencyName = currencyDetails.values.elementAt(
                          index,
                        );
                        // print("rate" + rates);

                        return Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image(
                                  image: NetworkImage(
                                    'https://flagcdn.com/48x36/${getCountryCodeFromCurrency(currency).toLowerCase()}.png',
                                  ),
                                ),
                                title: Text(
                                  currency,
                                  style: TextStyle(fontSize: 18),
                                ),
                                subtitle: Text(currencies[currency] ?? "-"),
                                trailing: Text(
                                  value,
                                  style: TextStyle(fontSize: 18),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              CurrenciesConverterScreen(
                                                currencyRate: double.parse(
                                                  value,
                                                ),
                                                country: currency,
                                              ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
