import 'package:flutter/material.dart';
import 'package:flutter_vazotsika/app/modules/home/models/credential_model.dart';
import 'package:flutter_vazotsika/app/modules/home/providers/auth_provider.dart';
import 'package:flutter_vazotsika/app/modules/home/models/search_result_model.dart';
import 'package:flutter_vazotsika/app/modules/home/widgets/CustomSearchDelegate.dart';
import 'package:get/get.dart';
import 'package:english_words/english_words.dart' as english_words;

import '../providers/search_result_provider.dart';

class HomeController extends GetxController {
  late final List<String> kTracks;
  late CustomSearchDelegate delegate;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final SearchResultProvider _searchResultProvider = SearchResultProvider();
  SearchResult? searchResult;
  RxBool isLoading = false.obs;

  void searchTrack(String input) {
    isLoading.value = true;
    _searchResultProvider
        .search(query: input, types: ['track'])
    .then((value) {
      searchResult = value;
      isLoading.value = false;
    });
  }

  @override
  void onInit() {
    kTracks = List.from(Set.from(english_words.all))
      ..sort(
        (w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase()),
      );
    super.onInit();
    delegate = CustomSearchDelegate(kTracks);
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }
}
