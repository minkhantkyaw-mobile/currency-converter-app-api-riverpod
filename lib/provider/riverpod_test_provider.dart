// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import 'package:currency_converter_app_sl/model/riverpod_test_joke_model.dart';

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

final sliderProvider = StateProvider<AppState>((ref) {
  return AppState(slider: 0.5, showPassword: false);
});

class AppState {
  final double slider;
  final bool showPassword;
  AppState({required this.slider, required this.showPassword});

  AppState copyWith({double? slider, bool? showPassword}) {
    return AppState(
      slider: slider ?? this.slider,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}

final searchProvider = StateNotifierProvider<SerchNotifier, SearchState>((ref) {
  return SerchNotifier();
});

class SerchNotifier extends StateNotifier<SearchState> {
  SerchNotifier() : super(SearchState(search: '', isChange: false));

  void search(String query) {
    state = state.copyWith(search: query);
  }

  void onChange(bool isChange) {
    state = state.copyWith(isChange: isChange);
  }
}

class SearchState {
  final String search;
  final bool isChange;
  SearchState({required this.search, required this.isChange});

  SearchState copyWith({String? search, bool? isChange}) {
    return SearchState(
      search: search ?? this.search,
      isChange: isChange ?? this.isChange,
    );
  }
}
