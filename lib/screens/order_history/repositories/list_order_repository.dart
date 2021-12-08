import 'package:flutter/foundation.dart';
import '../../../common/base/paging_with_user_repository.dart';

import '../../../models/entities/index.dart';
import '../../../models/entities/paging_response.dart';

class ListOrderRepository extends PagingWithUserRepository<Order> {
  ListOrderRepository({@required User user}) : super(user);

  @override
  Future<PagingResponse<Order>> Function({dynamic cursor, User user})
      get requestApi => service.api.getMyOrders;
}
