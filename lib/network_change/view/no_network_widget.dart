import 'package:flutter/material.dart';

import '../network_change_manager.dart';
import '../network_result_enum.dart';

class NoNetworkWidget extends StatefulWidget {
  const NoNetworkWidget({Key? key}) : super(key: key);

  @override
  State<NoNetworkWidget> createState() => _NoNetworkWidgetState();
}

class _NoNetworkWidgetState extends State<NoNetworkWidget> {
  late final NetworkChangeManager _networkChangeManager;
  NetworkResult _networkResult = NetworkResult.off;
  @override
  void initState() {
    super.initState();
    _networkChangeManager = NetworkChangeManager();
    // handleNetwork();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _networkChangeManager.handleNetworkChange((result) {
        _updateView(result);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: _networkResult == NetworkResult.off
          ? const SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "Offline",
                style: TextStyle(color: Colors.white),
              )))
          : const SizedBox(),
    );
  }

  Future handleNetwork() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _networkResult = await _networkChangeManager.checkNetworkFirst();

      setState(() {});
    });
  }

  void _updateView(NetworkResult result) {
    _networkResult = result;
    setState(() {});
  }
}
