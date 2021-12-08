import 'package:flutter/foundation.dart';

import '../../../models/entities/index.dart';
import '../../../models/paging_data_provider.dart';
import '../repositories/list_order_repository.dart';

class ListOrderHistoryModel extends PagingDataProvider<Order> {
  ListOrderHistoryModel({@required User user})
      : super(dataRepo: ListOrderRepository(user: user));
}
