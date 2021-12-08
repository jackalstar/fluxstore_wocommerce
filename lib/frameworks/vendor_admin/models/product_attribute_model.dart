import 'package:flutter/cupertino.dart';

import '../../../models/entities/product_attribute.dart';
import '../../../models/entities/user.dart';
import '../services/vendor_admin.dart';

class VendorAdminProductAttributeModel extends ChangeNotifier {
  /// Service
  final _services = VendorAdminApi();
  final User _user;

  /// Your Other Variables Go Here

  List<ProductAttribute> defaultAttributes = [];

  VendorAdminProductAttributeModel(this._user) {
    getDefaultAttributes();
  }

  /// Your Defined Functions Go Here

  Future<void> getDefaultAttributes() async {
    defaultAttributes =
        await _services.getDefaultProductAttributes(cookie: _user.cookie);
  }
}
