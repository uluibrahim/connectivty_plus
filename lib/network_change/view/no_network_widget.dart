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
    return AnimatedCrossFade(
        firstChild: Container(
          color: Colors.black,
          child: const SizedBox(
            height: 50,
            child: Center(
              child: Text(
                "Offline",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        secondChild: const SizedBox(),
        crossFadeState: _networkResult == NetworkResult.off
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 400));
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
