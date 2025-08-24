import 'package:odu_api/app/data/api/api_response.dart';
import 'package:odu_api/app/data/api/url/api_url.dart';
import 'package:odu_api/app/data/data_providers.dart';
import 'package:odu_api/core/data/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'send_request.g.dart';

@riverpod
class SendRequest extends _$SendRequest {
  @override
  AsyncValue<ApiResponse> build() {
    return AsyncData(ApiResponse(statusCode: 0));
  }

  Future<void> call(ApiUrl url) async {
    state = const AsyncLoading();
    final apiRequest = ref.read(apiRequestProvider);
    final result = await apiRequest.execute(url);
    switch (result) {
      case Ok<ApiResponse>():
        state = AsyncData(result.value);
      case Error<ApiResponse>():
        state = AsyncError(
          result.error,
          result.stackTrace ?? StackTrace.current,
        );
    }
  }
}
