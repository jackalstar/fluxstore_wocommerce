import '../../../common/base/paging_repository.dart';

import '../../../models/entities/blog.dart';
import '../../../models/entities/paging_response.dart';

class ListBlogRepository extends PagingRepository<Blog> {
  @override
  Future<PagingResponse<Blog>> Function(dynamic) get requestApi =>
      service.api.getBlogs;
}
