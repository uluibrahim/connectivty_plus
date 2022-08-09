import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'network_result_enum.dart';

abstract class INetworkChangeManager {
  Future<NetworkResult> checkNetworkFirst();
  void handleNetworkChange(NetworkConnectivityCallback onChange);
  void dispose();
}

class NetworkChangeManager extends INetworkChangeManager {
  late final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _streamSubscription;

  NetworkChangeManager() {
    _connectivity = Connectivity();
  }

  @override
  Future<NetworkResult> checkNetworkFirst() async {
    final connectivityResult = await (_connectivity.checkConnectivity());
    return NetworkResult.checkConnectivityResult(connectivityResult);
  }

  @override
  void handleNetworkChange(NetworkConnectivityCallback onChange) {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      onChange.call(NetworkResult.checkConnectivityResult(event));
    });
  }

  @override
  void dispose() async {
    await _streamSubscription?.cancel();
  }
}

typedef NetworkConnectivityCallback = void Function(NetworkResult result);
