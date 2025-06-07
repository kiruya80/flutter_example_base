import 'base_params.dart';

class PaginatedParams extends BaseParams {
  final int page;
  final int limit;

  PaginatedParams({required this.page, required this.limit});
}
