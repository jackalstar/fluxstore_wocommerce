import '../../services/index.dart';

abstract class BasePageRepository<T> {
  final service = Services();

  BasePageRepository() {
    initCursor();
  }

  Future<List<T>> getData();

  dynamic cursor;

  bool hasNext = true;

  void refresh() {
    hasNext = true;
    cursor = null;
    initCursor();
  }

  void initCursor() {
    if (Config().type != ConfigType.shopify) {
      cursor = 1;
    }
  }

  void updateCursor() {
    // Cursor type of framework Shopify is String
    if (cursor is! String) {
      cursor++;
    }
  }

// T parseJson(Map<String, dynamic> json);
}
