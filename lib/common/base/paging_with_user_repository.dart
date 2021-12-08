import 'package:flutter/foundation.dart';
import '../../models/index.dart';
import '../../services/base_services.dart';

import 'base_page_repository.dart';

abstract class PagingWithUserRepository<T> extends BasePageRepository<T> {
  Future<PagingResponse<T>> Function({
    @required User user,
    @required dynamic cursor,
  }) get requestApi;

  final User user;

  PagingWithUserRepository(this.user);

  @override
  Future<List<T>> getData() async {
    if (!hasNext) return <T>[];

    final response = await requestApi(
      cursor: cursor,
      user: user,
    );

    if (response == null) return <T>[];

    List data = response.data;

    cursor = response.cursor ?? cursor;

    if (data?.isEmpty ?? true) {
      hasNext = false;
      return <T>[];
    }

    if (cursor is int) {
      cursor++;
    }

    // First page
    cursor ??= 2;
    return data;
    // return data.map((json) => parseJson(json)).toList();
  }
}
