class Credential {
  String? accessToken;
  int? expiresIn;
  String? tokenType;

  Credential({this.accessToken, this.expiresIn, this.tokenType});

  Credential.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['token_type'] = tokenType;
    return data;
  }

  @override
  String toString() {
    return 'Credential{accessToken: $accessToken, expiresIn: $expiresIn, tokenType: $tokenType}';
  }
}
