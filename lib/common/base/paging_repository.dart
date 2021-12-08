import '../../services/base_services.dart';

import 'base_page_repository.dart';

/// * [T] is type of the data
abstract class PagingRepository<T> extends BasePageRepository<T> {
  Future<PagingResponse<T>> Function(dynamic) get requestApi;

  @override
  Future<List<T>> getData() async {
    if (!hasNext) return <T>[];

    final response = await requestApi(cursor);

    if (response == null) return <T>[];

    List data = response.data;

    cursor = response.cursor ?? cursor;

    updateCursor();

    if (data?.isEmpty ?? true) {
      hasNext = false;
      return <T>[];
    }

    return data;
  }
}
