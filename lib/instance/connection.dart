class ConnectionStateProvider {
  ConnectionStateProvider._internal();

  factory ConnectionStateProvider.instance() {
    _instance ??= ConnectionStateProvider._internal();
    return _instance;
  }

  static ConnectionStateProvider _instance;

  bool _state;

  bool get state => _state;

  void update(bool connectionState) {
    _state = connectionState ?? _state;
  }

  bool get notInternet => !state;
}
