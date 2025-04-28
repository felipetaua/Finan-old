import 'package:flutter/material.dart';

class TemaNotifier extends ChangeNotifier {
  bool _temaEscuro = false;

  TemaNotifier(bool temaEscuro);

  bool get temaEscuro => _temaEscuro;

  void alternarTema(bool value) {
    _temaEscuro = value;
    notifyListeners();
  }
}
