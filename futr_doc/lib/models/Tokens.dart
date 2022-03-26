import 'dart:convert';

class Token {
  final String accessToken;
  final String idToken;
  final String refreshToken;

  Token({
    required this.accessToken,
    required this.idToken,
    required this.refreshToken,
  });

  Map<String, String> toJson() => {
        'accessToken': accessToken,
        'idToken': idToken,
        'refreshToken': refreshToken
      };

  static Token jsonToToken(data) {
    return Token(
      accessToken: data['accessToken'],
      idToken: data['idToken'],
      refreshToken: data['refreshToken'],
    );
  }
}
