import 'package:flutter/foundation.dart';

class UserLogged extends ChangeNotifier {
  String _uid = "";

  String get uid => _uid;

  setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }
}