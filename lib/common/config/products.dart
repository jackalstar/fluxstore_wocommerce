part of '../config.dart';

/// Everything Config about the Product Setting

Map get ProductVariantLayout => Configurations.productVariantLayout;

Map get kProductDetail => Configurations.productDetail;

Map get kProductAddons => Configurations.productAddons;

Map get kCartDetail => Configurations.cartDetail;

Map get kProductVariantLanguage => Configurations.productVariantLanguage;

int get kExcludedCategory => Configurations.excludedCategory;

Map get kSaleOffProduct => Configurations.saleOffProduct;

bool get kNotStrictVisibleVariant => Configurations.notStrictVisibleVariant;

Map get kProductCard => Configurations.productCard;

BoxFit get kCardFit {
  var boxFit = Configurations.productCard['fit'];
  return Tools.boxFit(boxFit);
}
