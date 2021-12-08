import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/index.dart';
import '../../../widgets/paging_list.dart';
import '../models/list_order_history_model.dart';
import 'widgets/order_list_item.dart';
import 'widgets/order_list_loading_item.dart';

class ListOrderHistoryScreen extends StatefulWidget {
  @override
  _ListOrderHistoryScreenState createState() => _ListOrderHistoryScreenState();
}

class _ListOrderHistoryScreenState extends State<ListOrderHistoryScreen> {
  ListOrderHistoryModel get listOrderViewModel =>
      Provider.of<ListOrderHistoryModel>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          S.of(context).orderHistory,
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: PagingList<ListOrderHistoryModel, Order>(
        itemBuilder: (_, order) => OrderListItem(order: order),
        lengthLoadingWidget: 3,
        loadingWidget: const OrderListLoadingItem(),
      ),
    );
  }
}
