import 'package:odu_api/app/data/api/api_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_providers.g.dart';

@Riverpod(keepAlive: true)
ApiRequest apiRequest(Ref ref) {
  return ApiRequest();
}
