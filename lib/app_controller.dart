import 'package:flutter/material.dart';
import 'package:flutter_vazotsika/app/modules/home/providers/search_result_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/modules/home/models/credential_model.dart';
import 'app/modules/home/providers/auth_provider.dart';

class AppController extends GetxController with StateMixin<Credential> {
  final AuthProvider _authProvider = AuthProvider();
  final SearchResultProvider _searchResultProvider = SearchResultProvider();
  final box = GetStorage();
  final scaffoldMessenger = GlobalKey<ScaffoldMessengerState>();

  @override
  void onInit() {
    super.onInit();
    auth();
  }

  void auth() async {
      _authProvider.clientCredentialGrant().then((response) {
        box.write('accessToken', response.accessToken);
        debugPrint('Authenticated successfully');
        change(response, status: RxStatus.success());
      }, onError: (err) {
        change(null, status: RxStatus.error(err.toString()));
      });
  }
}
