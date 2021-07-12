import 'package:flutter/material.dart';

enum SessionState {
  init,
  logged_in,
  logged_out,
  expired,
  cleared,
}

class Session extends ChangeNotifier {
  Session._internal() {
    _state = SessionState.init;
  }

  factory Session.instance() {
    _instance ??= Session._internal();
    return _instance;
  }

  static Session _instance;

  SessionState _state;

  String _version = "1.0.0";

  String get version => _version;

  String _accessToken;

  String _refreshToken;

  String _fcmToken;

  String get fcmToken => _fcmToken;

  String get refreshToken => _refreshToken;

  SessionState get state => _state;

  bool get hasSession => _accessToken != null;

  String get accessToken => _accessToken;

  void setAccessToken(String accessT, {bool shouldNotify = false}) {
    _accessToken = accessT;
    _state = SessionState.logged_in;
    if (shouldNotify) {
      notify();
    }
  }

  void setFCMToken(String fcm, {bool shouldNotify = false}) {
    _fcmToken = fcm;
    _state = SessionState.logged_in;
    if (shouldNotify) {
      notify();
    }
  }

  void setRefreshToken(String refreshT, {bool shouldNotify = false}) {
    _refreshToken = refreshT;
    _state = SessionState.logged_in;
    if (shouldNotify) {
      notify();
    }
  }

  void notify() {
    notifyListeners();
  }

  @override
  void dispose() {
    _instance = null;
    super.dispose();
  }

  void _clear({bool shouldNotify = true}) {
    _accessToken = null;
    _refreshToken = null;
    _fcmToken = null;

    shouldNotify ??= true;
    if (shouldNotify) {
      notifyListeners();
    }
  }

  void clear({bool shouldNotify = true}) {
    _state = SessionState.cleared;
    _clear(shouldNotify: shouldNotify);
  }

  void expired({bool shouldNotify = true}) {
    _state = SessionState.expired;
    _clear(shouldNotify: shouldNotify);
  }

  void reInit({bool shouldNotify = true}) {
    _state = SessionState.init;
    _clear(shouldNotify: shouldNotify);
  }
}
