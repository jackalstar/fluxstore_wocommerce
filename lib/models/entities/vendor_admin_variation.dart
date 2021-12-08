class VendorAdminVariation {
  int id;
  bool isActive;
  bool isManageStock = false;
  int stockQuantity = 0;
  double regularPrice;
  double salePrice;
  Map<String, dynamic> attributes;

  VendorAdminVariation() {
    id = -1;
    isActive = true;
    isManageStock = false;
    stockQuantity = 0;
    regularPrice = 0.0;
    salePrice = 0.0;
    attributes = {};
  }

  VendorAdminVariation.fromJson(json) {
    id = json['variation_id'];
    isActive = json['variation_is_active'];
    if (json['max_qty'] is int) {
      stockQuantity = json['max_qty'];
    }
    if (json['manage_stock'] is String) {
      isManageStock = false;
    } else {
      isManageStock = json['manage_stock'];
    }

    try {
      regularPrice = double.parse(json['display_regular_price']);
    } on Exception {
      regularPrice = 0.0;
    }
    try {
      salePrice = double.parse(json['display_price']);
    } on Exception {
      salePrice = 0.0;
    }
    attributes = (json['attributes'] is List) ? {} : json['attributes'];
  }

  Map toJson() {
    return {
      'variation_id': id,
      'variation_is_active': isActive,
      'max_qty': isManageStock ? stockQuantity : '',
      'manage_stock': isManageStock,
      'display_regular_price': regularPrice,
      'display_price': salePrice,
      'attributes': attributes
    };
  }
}
