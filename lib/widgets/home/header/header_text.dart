import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../common/tools.dart';
import 'header_type.dart';

class HeaderText extends StatelessWidget {
  final config;

  HeaderText({this.config, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Tools.formatDouble(config['height'] ?? 100),
      margin: EdgeInsets.only(
        top: Tools.formatDouble(config['marginTop'] ?? 20.0),
        left: Tools.formatDouble(config['marginLeft'] ?? 20.0),
        right: Tools.formatDouble(config['marginRight'] ?? 15.0),
        bottom: Tools.formatDouble(config['marginBottom'] ?? 10.0),
      ),
      child: SafeArea(
        bottom: false,
        top: config['isSafeArea'] ?? false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: HeaderType(config: config),
            ),
            if (config['showSearch'] == true)
              IconButton(
                icon: const Icon(Icons.search),
                iconSize: 24.0,
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteList.homeSearch);
                },
              )
          ],
        ),
      ),
    );
  }
}
