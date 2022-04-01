import 'package:flutter/material.dart';
import '../models/Tokens.dart';

final Token initialData = Token(
  accessToken: '',
  idToken: '',
  refreshToken: '',
);

class TokenProvider with ChangeNotifier {
  // All Tokens (that will be displayed on the Home screen)
  Token _tokens = initialData;

  // Retrieve all Tokens
  Token get tokens => _tokens;

  setToken(Token newTokens) {
    _tokens = newTokens;
  }
}
