import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/search_result_model.dart';

class SearchResultProvider extends GetConnect {
  final box = GetStorage();

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return SearchResult.fromJson(map);
      if (map is List) {
        return map.map((item) => SearchResult.fromJson(item)).toList();
      }
    };
  }

  Future<SearchResult?> search({String? query, List<String>? types}) async {
    debugPrint('Searching $query');
    final token = box.read('accessToken');
    final response = await get(
      'https://api.spotify.com/v1/search/',
      query: {'type': types?.join(',') ?? 'track', 'q': query},
      headers: {'Authorization': 'Bearer $token'},
    );
    debugPrint('response ${SearchResult.fromJson(response.body)}');
    return SearchResult.fromJson(response.body);
  }
}
