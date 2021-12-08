import 'package:flutter/material.dart';

import '../../../common/tools.dart';
import '../../../widgets/home/banner/banner_items.dart';

/// The Banner Group type to display the image as multi columns
class BannerGroupItems extends StatelessWidget {
  final config;

  BannerGroupItems({this.config, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List items = config['items'];
    final screenSize = MediaQuery.of(context).size;
    final height =
        config['height'] != null ? config['height'] * screenSize.height : null;
    final boxFit = Tools.boxFit(config['fit'] ?? 'fitWidth');

    return Container(
      color: Theme.of(context).backgroundColor,
      height: height,
      margin: EdgeInsets.only(
        left: Tools.formatDouble(config['marginLeft'] ?? 10.0),
        right: Tools.formatDouble(config['marginRight'] ?? 10.0),
        top: Tools.formatDouble(config['marginTop'] ?? 10.0),
        bottom: Tools.formatDouble(config['marginBottom'] ?? 10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (int i = 0; i < items.length; i++)
            Expanded(
              child: BannerImageItem(
                config: items[i],
                boxFit: boxFit,
                height: height,
              ),
            ),
        ],
      ),
    );
  }
}
