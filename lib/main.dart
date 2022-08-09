import 'package:connectivtyplus/network_change/view/network_change_view.dart';
import 'package:flutter/material.dart';

import 'network_change/view/no_network_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      builder: (context, widget) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(child: widget ?? const SizedBox()),
              const SizedBox( child: NoNetworkWidget()),
            ],
          ),
        );
      },
      home: const NetworkChangeView(),
    );
  }
}
