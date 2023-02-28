import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../models/credential_model.dart';

class AuthProvider extends GetConnect {
  final clientId = dotenv.env['CLIENT_ID'];
  final clientSecret = dotenv.env['CLIENT_SECRET'];

  Future<Credential> clientCredentialGrant() async {
    final credentials = '$clientId:$clientSecret';
    final authorization = 'Basic ${base64Url.encode(utf8.encode(credentials))}';
    final response = await post(
      'https://accounts.spotify.com/api/token',
      {'grant_type': 'client_credentials'},
      contentType: 'application/x-www-form-urlencoded',
      headers: {'Authorization': authorization},
    );
    return Credential.fromJson(response.body);
  }
}
