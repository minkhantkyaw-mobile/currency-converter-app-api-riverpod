import 'dart:convert';

import 'package:currency_converter_app_sl/model/riverpod_test_joke_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});

String ApiService = "https://official-joke-api.appspot.com/random_joke";

Future<RiverpodTestJokeModel> getUser() async {
  Response response = await get(Uri.parse(ApiService));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    print("result $result");
    return RiverpodTestJokeModel.fromJson(result);
    //result.map((e) => RiverpodTestJokeModel.fromJson(e)).toList();
  } else {
    throw Exception(response.reasonPhrase);
  }
}

final getApi = FutureProvider<RiverpodTestJokeModel>((ref) => getUser());
